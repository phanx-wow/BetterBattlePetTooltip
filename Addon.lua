--[[--------------------------------------------------------------------
	BetterBattlePetTooltip
	A World of Warcraft user interface addon
	Copyright (c) 2012-2013 A. Kinley (Phanx)

	This addon is freely available, and its source code freely viewable,
	but it is not "open source software" and you may not distribute it,
	with or without modifications, without permission from its author.

	See the included README and LICENSE files for more information!
----------------------------------------------------------------------]]

local ADDON, Addon = ...
local L = Addon.L

local PetQualityColors = {}
for i = 1, 6 do PetQualityColors[i] = ITEM_QUALITY_COLORS[i-1] end

local PetQualityStrings = {}
for i = 1, 6 do PetQualityStrings[i] =  format(L.Parentheses, _G["BATTLE_PET_BREED_QUALITY"..i]) end

local seenWildPetQualities = {}

------------------------------------------------------------------------

BBPT_COUNT = false
BBPT_LEVEL = true
BBPT_WILD_QUALITY = true

------------------------------------------------------------------------

local eventFrame = CreateFrame("Frame", ADDON)
eventFrame:SetScript("OnEvent", function(self, event, ...) return self[event] and self[event](self, event, ...) end)

------------------------------------------------------------------------
--	Rewrite pet strings
------------------------------------------------------------------------

do
	local petStringCache = {}

	local __GetOwnedBattlePetString = C_PetJournal.GetOwnedBattlePetString

	function C_PetJournal.GetOwnedBattlePetString(speciesID)
		--print("GetOwnedBattlePetString:", speciesID)

		local petID
		if type(speciesID) == "string" then
			speciesID, petID = C_PetJournal.FindPetIDByName(speciesID)
		end
		if type(speciesID) ~= "number" or speciesID < 1 then
			--print("Invalid species.")
			return
		end
		if petStringCache[speciesID] then
			--print("Cached.")
			return petStringCache[speciesID]
		end
		local speciesName, _, _, _, _, _, _, _, _, _, obtainable = C_PetJournal.GetPetInfoBySpeciesID(speciesID)
		if not obtainable then
			--print("Not obtainable.")
			return
		end
		if not petID then
			_, petID = C_PetJournal.FindPetIDByName(speciesName)
		end

		local petString
		local colorblindMode = tonumber(ENABLE_COLORBLIND_MODE) > 0
		if petID then
			--print("Collected.")
			local _, _, _, _, quality = C_PetJournal.GetPetStats(petID)
			local color = colorblindMode and HIGHLIGHT_FONT_COLOR_CODE or PetQualityColors[quality].hex
			local qText = colorblindMode and PetQualityStrings[quality] or ""
			local count, maxCount, level

			if BBPT_COUNT then
				count, maxCount = strmatch(__GetOwnedBattlePetString(speciesID) or "", "(%d+)/(%d+)")
			end
			if BBPT_LEVEL then
				_, _, level = C_PetJournal.GetPetInfoByPetID(petID)
			end

			if count and level then
				petString = format(L.PetStringCountLevel, color, count, maxCount, COLLECTED, level, qText)
			elseif count then
				petString = format(L.PetStringCount, color, count, maxCount, COLLECTED, qText)
			elseif level then
				petString = format(L.PetStringLevel, color, COLLECTED, level, qText)
			else
				petString = format(L.PetString, color, COLLECTED, qText)
			end
		else
			--print("Not collected.")
			petString = format(L.PetString, colorblindMode and HIGHLIGHT_FONT_COLOR_CODE or PetQualityColors[5].hex, NOT_COLLECTED, "")
		end

		petStringCache[speciesID] = petString
		return petString
	end

	eventFrame:RegisterEvent("PET_JOURNAL_UPDATE")
	function eventFrame:PET_JOURNAL_UPDATE(event)
		--print(event)
		wipe(petStringCache)
	end
end

------------------------------------------------------------------------
--	Color tooltip border
------------------------------------------------------------------------

local ColorBorderByQuality
do
	local BorderRegions = {
		"BorderTopLeft",
		"BorderTopRight",
		"BorderBottomRight",
		"BorderBottomLeft",
		"BorderTop",
		"BorderRight",
		"BorderBottom",
		"BorderLeft"
	}
	function ColorBorderByQuality(self, r, g, b)
		--print("ColorBorderByQuality")
		if not g or not b then
			-- r is quality
			local color = tonumber(ENABLE_COLORBLIND_MODE) == 0 and PetQualityColors[quality] or TOOLTIP_DEFAULT_COLOR
			r, g, b = color.r, color.g, color.b
		end
		self:SetBackdropBorderColor(r, g, b)
		for i = 1, #BorderRegions do
			local region = self[BorderRegions[i]]
			if not region then break end
			region:SetVertexColor(r, g, b)
		end
	end
end

------------------------------------------------------------------------
--	Add info to pet battle unit tooltips
------------------------------------------------------------------------

do
	local function HookPetBattleUI()
		--print("HookPetBattleUI")
		hooksecurefunc("PetBattleUnitTooltip_UpdateForUnit", function(self, owner, index)
			if owner == LE_BATTLE_PET_ENEMY and C_PetBattles.IsWildBattle() then
				local _, speciesName = C_PetBattles.GetName(owner, index)
				self.CollectedText:SetText(C_PetJournal.GetOwnedBattlePetString(speciesName))
				ColorBorderByQuality(self, C_PetBattles.GetBreedQuality(owner, index))
			end
		end)
	end

	if PetBattleUnitTooltip_UpdateForUnit then
		HookPetBattleUI()
	else
		eventFrame:RegisterEvent("ADDON_LOADED")
		function eventFrame:ADDON_LOADED(event, addon)
			if PetBattleUnitTooltip_UpdateForUnit then
				HookPetBattleUI()
				f:UnregisterEvents(event)
			end
		end
	end
end

------------------------------------------------------------------------
--	Add border color to BattlePetTooltip
------------------------------------------------------------------------

local function BattlePetTooltip_OnShow(self)
	--print("BattlePetTooltip_OnShow")
	local speciesName = C_PetJournal.GetPetInfoBySpeciesID(self.speciesID)
	local petID = C_PetJournal.FindPetIDByName(speciesName)
	if petID then
		local _, _, _, _, quality = C_PetJournal.GetPetStats(petID)
		ColorBorderByQuality(self, quality)
	else
		ColorBorderByQuality(self, 5)
	end
end

hooksecurefunc("BattlePetToolTip_Show", function() BattlePetTooltip_OnShow(BattlePetTooltip) end)
hooksecurefunc("FloatingBattlePet_Show", function() BattlePetTooltip_OnShow(FloatingBattlePetTooltip) end)

------------------------------------------------------------------------
--	Add info to GameTooltip and derivatives
------------------------------------------------------------------------

local function SetTooltipPetInfo(self, species, guid)
	local tooltip = self:GetName()
	--print("SetTooltipPetInfo:", tooltip, species, guid)

	local addString = true
	local colorblindMode = tonumber(ENABLE_COLORBLIND_MODE) > 0

	for i = 2, self:NumLines() do
		local line = _G[tooltip.."TextLeft"..i]
		local text = line:GetText()
		--print("Checking line", i, text)
		if strfind(text, COLLECTED) and not strfind(text, NOT_COLLECTED) then
			--print("Modifying existing line")
			addString = false
			local petString = C_PetJournal.GetOwnedBattlePetString(species)
			line:SetText(petString)
			if not colorblindMode then
				local hex = strmatch(petString, "|cff%x%x%x%x%x%x")
				for quality, color in pairs(PetQualityColors) do
					if color.hex == hex then
						ColorBorderByQuality(self, quality)
						break
					end
				end
			end
			break
		end
	end

	if addString then
		--print("Adding new line.")
		if not species then
			species = _G[tooltip.."TextLeft1"]:GetText()
		end
		local petString = C_PetJournal.GetOwnedBattlePetString(species)
		if petString then
			self:AddLine(petString)
			if not colorblindMode then
				local hex = strmatch(petString, "|cff%x%x%x%x%x%x")
				for quality, color in pairs(PetQualityColors) do
					if color.hex == hex then
						ColorBorderByQuality(self, quality)
						break
					end
				end
			end
		end
	end

	if guid and BBPT_WILD_QUALITY then
		local quality = seenWildPetQualities[guid]
		if quality then
			--print("Already seen:", quality)
			local color = RED_FONT_COLOR
			local qcolor = not colorblindMode and PetQualityColors[quality]
			self:AddLine(format(L.AlreadyBattled, qcolor and qcolor.hex or HIGHLIGHT_FONT_COLOR_CODE, PetQualityStrings[quality]), color.r, color.g, color.b)
		else
			--print("Not seen.")
		end
	end

	self:Show()
end

------------------------------------------------------------------------
--	Add info to item tooltips
------------------------------------------------------------------------

local function OnTooltipSetItem(self)
	local _, link = self:GetItem()
	if link then
		--print("OnTooltipSetItem:", link)
		local id = tonumber(strmatch(link, "item:(%d+)"))
		if id then
			local species = speciesFromItem[id]
			if species then
				--print("speciesFromItem")
				SetTooltipPetInfo(self, species)
			end
		end
	end
end

GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
ItemRefTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)

------------------------------------------------------------------------
--	Add info to unit tooltips
------------------------------------------------------------------------

local function OnTooltipSetUnit(self)
	local _, unit = GameTooltip:GetUnit()
	--print("OnTooltipSetUnit:", unit)
	if unit and UnitIsWildBattlePet(unit) then
		--print("UnitIsWildBattlePet")
		SetTooltipPetInfo(self, UnitBattlePetSpeciesID(unit), UnitGUID(unit))
	end
end

GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)

------------------------------------------------------------------------
--	Add info to tracking tooltips
------------------------------------------------------------------------

local currentText
local multiparts = {}

eventFrame:Hide()
eventFrame:SetScript("OnUpdate", function()
	local text = GameTooltipTextLeft1:GetText()
--	if text ~= currentText then
--		currentText = text
		if strfind(text, "\n") then
			local i = 0
			for text in gmatch(text, "[^\n]+") do
				local speciesName = strtrim(gsub(text, "|T.-|t", ""))
				local petString = C_PetJournal.GetOwnedBattlePetString(speciesName)
				if petString then
					i = i + 1
					multiparts[i] = text
					i = i + 1
					multiparts[i] = petString
				else
					i = i + 1
					multiparts[i] = text
				end
			end
			GameTooltipTextLeft1:SetText(table.concat(multiparts, "\n", 1, i))
			GameTooltip:Show()
		else
			SetTooltipPetInfo(GameTooltip, strtrim(gsub(text, "|T.-|t", "")))
		end
--	end
end)

GameTooltip:HookScript("OnShow", function(self)
	if self:IsOwned(Minimap) then
		--print("GameTooltip:Show")
		eventFrame:Show()
	end
end)

GameTooltip:HookScript("OnHide", function(self)
	eventFrame:Hide()
	currentText = nil
end)

hooksecurefunc(GameTooltip, "SetOwner", function(self, owner, ...)
	if owner == Minimap then
		--print("GameTooltip:SetOwner")
		eventFrame:Show()
	end
end)

------------------------------------------------------------------------
--	Remember quality of previously battled wild pets
------------------------------------------------------------------------

eventFrame:RegisterEvent("PET_BATTLE_OPENING_START")
function eventFrame:PET_BATTLE_OPENING_START(event)
	--print(event)
	if UnitIsWildBattlePet("target") then
		local guid = UnitGUID("target")
		local quality = C_PetBattles.GetBreedQuality(LE_BATTLE_PET_ENEMY, 1)
		if guid and quality then
			seenWildPetQualities[guid] = quality
		end
	end
end