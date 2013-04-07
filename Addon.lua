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

local colorblindMode
local seenWildPetQualities = {}
local speciesFromItem = Addon.speciesFromItem

L.PetString           = "%s" .. L.PetString .. "%s|r"
L.PetStringCount      = "%s" .. L.PetStringCount .. "%s|r"
L.PetStringCountLevel = "%s" .. L.PetStringCountLevel .. "%s|r"
L.PetStringLevel      = "%s" .. L.PetStringLevel .. "%s|r"

------------------------------------------------------------------------

BBPT_COUNT = false
BBPT_LEVEL = true
BBPT_WILD_QUALITY = true

------------------------------------------------------------------------

local EventFrame = CreateFrame("Frame", ADDON)
EventFrame:SetScript("OnEvent", function(self, event, ...) return self[event] and self[event](self, event, ...) end)
Addon.EventFrame = EventFrame

EventFrame:RegisterEvent("PLAYER_LOGIN")
function EventFrame:PLAYER_LOGIN(event)
	colorblindMode = tonumber(GetCVar("colorblindMode")) > 0
end

------------------------------------------------------------------------
--	Rewrite pet strings
------------------------------------------------------------------------

do
	local petStringCache = {}

	local __GetOwnedBattlePetString = C_PetJournal.GetOwnedBattlePetString

	function C_PetJournal.GetOwnedBattlePetString(speciesID)
		--print("GetOwnedBattlePetString:", speciesID)
		if type(speciesID) == "string" then
			speciesID = C_PetJournal.FindPetIDByName(speciesID)
		end
		if type(speciesID) ~= "number" or speciesID < 1 then
			--print("Invalid species.")
			return
		end
		if petStringCache[speciesID] then
			--print("Cached.")
			return petStringCache[speciesID]
		end

		local numCollected, bestLevel, bestQuality = 0, 0, 0
		for _, petID in LibStub("LibPetJournal-2.0"):IteratePetIDs() do
			local petSpecies, _, petLevel, _, _, _, _, petName = C_PetJournal.GetPetInfoByPetID(petID)
			if petSpecies == speciesID then
				numCollected = numCollected + 1
				local _, _, _, _, petQuality = C_PetJournal.GetPetStats(petID)
				if petQuality >= bestQuality then
					bestQuality = petQuality
					bestLevel = max(bestLevel, petLevel)
				end
			end
		end

		local _, _, _, _, _, _, _, _, _, isUnique, obtainable = C_PetJournal.GetPetInfoBySpeciesID(speciesID)
		if not obtainable then
			--print("Not obtainable.")
			return
		end

		local petString
		if numCollected > 0 then
			--print("Collected.")
			local color = colorblindMode and HIGHLIGHT_FONT_COLOR_CODE or PetQualityColors[bestQuality].hex
			local qText = colorblindMode and PetQualityStrings[bestQuality] or ""

			if BBPT_COUNT and BBPT_LEVEL then
				petString = format(L.PetStringCountLevel, color, numCollected, isUnique and 1 or 3, COLLECTED, bestLevel, qText)
			elseif BBPT_COUNT then
				petString = format(L.PetStringCount, color, numCollected, isUnique and 1 or 3, COLLECTED, COLLECTED, qText)
			elseif BBPT_LEVEL then
				petString = format(L.PetStringLevel, color, COLLECTED, bestLevel, qText)
			else
				petString = format(L.PetString, color, COLLECTED, qText)
			end
			--print("String:", petString)
		else
			--print("Not collected.")
			petString = format(L.PetString, colorblindMode and HIGHLIGHT_FONT_COLOR_CODE or PetQualityColors[6].hex, NOT_COLLECTED, "")
		end

		petStringCache[speciesID] = petString
		return petString
	end

	EventFrame:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
	function EventFrame:PET_JOURNAL_LIST_UPDATE(event)
		--print(event)
		wipe(petStringCache)
	end

	hooksecurefunc("SetCVar", function(cvar, value)
		if cvar == "colorblindMode" then
			local enable = tonumber(value) > 0
			if enable ~= colorblindMode then
				colorblindMode = enable
				wipe(petStringCache)
			end
		end
	end)
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
		if colorblindMode then
			local color = DEFAULT_TOOLTIP_COLOR
			r, g, b = color.r, color.g, color.b
		elseif not g or not b then
			-- r is quality
			local color = PetQualityColors[r]
			r, g, b = color.r, color.g, color.b
		end
		--print("ColorBorderByQuality", r, g, b)
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
		EventFrame:RegisterEvent("ADDON_LOADED")
		function EventFrame:ADDON_LOADED(event, addon)
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
	if not colorblindMode then
		local speciesName = C_PetJournal.GetPetInfoBySpeciesID(self.speciesID)
		local petString = C_PetJournal.GetOwnedBattlePetString(speciesName)
		local hex = strmatch(petString, "|cff%x%x%x%x%x%x")
		for quality, color in pairs(PetQualityColors) do
			if color.hex == hex then
				ColorBorderByQuality(self, quality)
				break
			end
		end
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

	for i = 2, self:NumLines() do
		local line = _G[tooltip.."TextLeft"..i]
		local text = strtrim(line:GetText() or "")
		--print("Checking line", i, text)
		if text == UNIT_CAPTURABLE or text == NOT_COLLECTED or strfind(text, COLLECTED) then -- wat
			--print("Modifying existing line")
			addString = false
			local petString = C_PetJournal.GetOwnedBattlePetString(species)
			if petString then
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
			else
				-- Missing itemID -> speciesID mapping
				print("Missing pet string for species:", species)
				return
			end
			break
		end
	end

	if addString then
		--print("Adding new line.")
		local petString = C_PetJournal.GetOwnedBattlePetString(species or _G[tooltip.."TextLeft1"]:GetText())
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
	local item, link = self:GetItem()
	if link then
		--print("OnTooltipSetItem:", link)
		local species = speciesFromItem[tonumber(strmatch(link, "item:(%d+)"))]
		SetTooltipPetInfo(self, species or item)
	end
end

GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
ItemRefTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
ItemRefTooltip:HookScript("OnShow", OnTooltipSetItem) -- hyperlinks don't trigger OnTooltipSetItem

------------------------------------------------------------------------
--	Add info to spell tooltips
------------------------------------------------------------------------

local function OnTooltipSetSpell(self)
	local spell = GameTooltip:GetSpell()
	--print("OnTooltipSetSpell:", spell)
	if spell then
		SetTooltipPetInfo(self, spell)
	end
end

GameTooltip:HookScript("OnTooltipSetSpell", OnTooltipSetSpell)
ItemRefTooltip:HookScript("OnTooltipSetSpell", OnTooltipSetSpell)

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

EventFrame:Hide()
EventFrame:SetScript("OnUpdate", function()
	local text = GameTooltipTextLeft1:GetText()
	if not strfind(text, "\n") then
		SetTooltipPetInfo(GameTooltip, strtrim(gsub(gsub(gsub(text, "|T.-|t", ""), "|cff%x%x%x%x%x%x", ""), "|r", "")))
	elseif text ~= currentText then
		local i = 0
		for text in gmatch(text, "[^\n]+") do
			local petString = C_PetJournal.GetOwnedBattlePetString(strtrim(gsub(gsub(gsub(text, "|T.-|t", ""), "|cff%x%x%x%x%x%x", ""), "|r", "")))
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
		currentText = table.concat(multiparts, "\n", 1, i)
		GameTooltipTextLeft1:SetText(currentText)
		GameTooltip:Show()
	end
end)

GameTooltip:HookScript("OnShow", function(self)
	if self:IsOwned(Minimap) then
		--print("GameTooltip:Show")
		EventFrame:Show()
	end
end)

GameTooltip:HookScript("OnHide", function(self)
	EventFrame:Hide()
	currentText = nil
end)

hooksecurefunc(GameTooltip, "SetOwner", function(self, owner, ...)
	if owner == Minimap then
		--print("GameTooltip:SetOwner")
		EventFrame:Show()
	end
end)

------------------------------------------------------------------------
--	Remember quality of previously battled wild pets
------------------------------------------------------------------------

EventFrame:RegisterEvent("PET_BATTLE_OPENING_START")
function EventFrame:PET_BATTLE_OPENING_START(event)
	--print(event)
	if UnitIsWildBattlePet("target") then
		local guid = UnitGUID("target")
		local quality = C_PetBattles.GetBreedQuality(LE_BATTLE_PET_ENEMY, 1)
		if guid and quality then
			seenWildPetQualities[guid] = quality
		end
	end
end