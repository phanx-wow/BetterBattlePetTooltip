--[[--------------------------------------------------------------------
	BetterBattlePetTooltip
	Copyright (c) 2012-2015 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info21978-BetterBattlePetTooltip.html
	http://www.curse.com/addons/wow/betterbattlepettooltip
	https://github.com/Phanx/BetterBattlePetTooltip
----------------------------------------------------------------------]]

local ADDON, Addon = ...
local L = Addon.L

local LibPetJournal = LibStub("LibPetJournal-2.0")
local LibPetBreedInfo -- not embedded, checked for in PLAYER_LOGIN

------------------------------------------------------------------------

local PetQualityColors = {}
for i = 1, 6 do PetQualityColors[i] = ITEM_QUALITY_COLORS[i-1] end

local PetQualityStrings = {}
for i = 1, 6 do PetQualityStrings[i] = _G["BATTLE_PET_BREED_QUALITY"..i] end
--for i = 1, 6 do PetQualityStrings[i] = format(L.Parentheses, _G["BATTLE_PET_BREED_QUALITY"..i]) end

local HexToPetQuality = {}
for i = 1, 6 do HexToPetQuality[PetQualityColors[i].hex] = i end

local PetBreedIcons = {
	--[[ BB ]] [3]  = "|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:16:32:0:16|t",
	--[[ PP ]] [4]  = "|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:0:16:0:16|t|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:0:16:0:16|t", -- "|TInterface\\WorldStateFrame\\CombatSwords:0:0:-2:0:64:64:0:32:0:32|t",
	--[[ SS ]] [5]  = "|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:16:32:16:32|t|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:16:32:16:32|t",
	--[[ HH ]] [6]  = "|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:0:16:16:32|t|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:0:16:16:32|t",
	--[[ HP ]] [7]  = "|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:0:16:16:32|t|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:0:16:0:16|t",
	--[[ PS ]] [8]  = "|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:0:16:0:16|t|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:16:32:16:32|t",
	--[[ HS ]] [9]  = "|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:0:16:16:32|t|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:16:32:16:32|t",
	--[[ PB ]] [10] = "|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:0:16:0:16|t",
	--[[ SB ]] [11] = "|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:16:32:16:32|t",
	--[[ HB ]] [12] = "|TInterface\\PetBattles\\PetBattle-StatIcons:0:0:-2:0:32:32:0:16:16:32|t",
}

local PetBreedNames = setmetatable({}, { __index = function(self, breed)
	local name = LibPetBreedInfo and LibPetBreedInfo:GetBreedName(breed)
	--print("PetBreedNames", breed, name, not not LibPetBreedInfo)
	if name then
		name = gsub(name, "/", "")
		self[breed] = name
	end
	return name or ""
end })

------------------------------------------------------------------------

local colorblindMode
local seenWildPetQualities = {}
local seenWildPetBreeds = {}

local PetItemToSpecies = Addon.PetItemToSpecies
local PetNameToSpecies = setmetatable({}, { __index = function(t, name)
	local speciesID = C_PetJournal.FindPetIDByName(name)
	t[name] = speciesID
	return speciesID
end })

------------------------------------------------------------------------

BBPTDB = {
	count = false,
	level = true,
	wildQuality = true,
	tooltipColor = true,
}

------------------------------------------------------------------------

local db = BBPTDB -- reassigned in PLAYER_LOGIN

local EventFrame = CreateFrame("Frame", ADDON)
EventFrame:SetScript("OnEvent", function(self, event, ...) return self[event] and self[event](self, event, ...) end)
Addon.EventFrame = EventFrame

EventFrame:RegisterEvent("PLAYER_LOGIN")
function EventFrame:PLAYER_LOGIN(event)
	db = BBPTDB
	colorblindMode = tonumber(GetCVar("colorblindMode")) > 0
	LibPetBreedInfo = LibStub("LibPetBreedInfo-1.0", true)
end

------------------------------------------------------------------------
--	Rewrite pet strings
------------------------------------------------------------------------

do
	local petStringCache = {}

	function C_PetJournal.GetOwnedBattlePetString(speciesID)
		--print("GetOwnedBattlePetString:", speciesID)
		if type(speciesID) == "string" then
			speciesID = PetNameToSpecies[speciesID]
		end
		if type(speciesID) ~= "number" or speciesID < 1 then
			--print("Invalid species.")
			return
		end
		if petStringCache[speciesID] then
			--print("Cached.")
			return petStringCache[speciesID]
		end

		local _, _, _, _, _, _, _, _, _, isUnique, obtainable = C_PetJournal.GetPetInfoBySpeciesID(speciesID)
		if not obtainable then
			--print("Not obtainable.")
			return
		end

		local petString

		if PetTracker then
			petString = PetTracker.Journal:GetOwnedText(speciesID)
			if petString and colorblindMode then
				petString = gsub(petString, "|cff%x%x%x%x%x%x", HIGHLIGHT_FONT_COLOR_CODE)
			end
			--print("PetTracker:", petString)
		end

		if not petString then
			local showBreed = db.breed and LibPetBreedInfo
			local baseString = db.all and (showBreed or db.level) and (NORMAL_FONT_COLOR_CODE .. L.Collected .. "|r")
			local numCollected, bestLevel, bestQuality, bestBreed = 0, 0, 0
			for _, petID in LibPetJournal:IteratePetIDs() do
				local species, _, level, _, _, _, _, name, _, _, _, _, _, _, _, _, unique = C_PetJournal.GetPetInfoByPetID(petID)
				if species == speciesID then
					numCollected = numCollected + 1
					local _, _, _, _, quality = C_PetJournal.GetPetStats(petID)
					if baseString then
						-- Show all, append
						local breed = showBreed and PetBreedNames[LibPetBreedInfo:GetBreedByPetID(petID)]
						local color = colorblindMode and HIGHLIGHT_FONT_COLOR_CODE or PetQualityColors[quality].hex
						local qText = colorblindMode and format(L.Parentheses, PetQualityStrings[quality]) or ""
						if breed then
							petString = (numCollected > 1 and (petString .. L.Comma) or (baseString .. L.Colon)) .. color .. (db.level and format(L.CollectedLevelBreed, level, breed) or breed) .. qText
						else
							petString = (numCollected > 1 and (petString .. L.Comma) or (baseString .. L.Colon)) .. color .. format(L.CollectedLevel, level) .. qText
						end
					elseif quality >= bestQuality then
						-- Show highest level of best quality only
						bestQuality = quality
						bestLevel = max(bestLevel, level)
						bestBreed = showBreed and gsub(LibPetBreedInfo:GetBreedName(LibPetBreedInfo:GetBreedByPetID(petID)), "/", "")
					end
				end
			end

			if petString then
				--print("All:", petString)
			elseif numCollected > 0 then
				if bestBreed and db.level then
					petString = format(L.CollectedLevelBreed, bestLevel, bestBreed)
				elseif bestBreed then
					petString = bestBreed
				elseif db.level then
					petString = format(L.CollectedLevel, bestLevel)
				end

				if db.count and not isUnique then
					if petString then
						petString = L.Collected .. L.Colon .. format(L.CollectedCount, numCollected) .. " - " .. petString
					else
						petString = L.Collected .. L.Colon .. format(L.CollectedCount, numCollected)
					end
				elseif petString then
					petString = L.Collected .. L.Colon .. petString
				else
					petString = L.Collected
				end

				if colorblindMode then
					petString = HIGHLIGHT_FONT_COLOR_CODE .. petString .. PetQualityStrings[bestQuality]
				else
					petString = PetQualityColors[bestQuality].hex .. petString
				end
				--print("Best:", petString)
			end
		end

		if not petString then
			--print("Not collected")
			petString = (colorblindMode and HIGHLIGHT_FONT_COLOR_CODE or PetQualityColors[6].hex) .. L.NotCollected
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
		if not db.tooltipColor then
			return
		end
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
		local petString = self.Owned:GetText() -- C_PetJournal.GetOwnedBattlePetString(self.speciesID)
		local hex = strmatch(petString, "|cff%x%x%x%x%x%x")
		local quality = hex and HexToPetQuality[hex]
		if quality then
			return ColorBorderByQuality(self, quality)
		end
	end
end

hooksecurefunc("BattlePetToolTip_Show", function() BattlePetTooltip_OnShow(BattlePetTooltip) end)
hooksecurefunc("FloatingBattlePet_Show", function() BattlePetTooltip_OnShow(FloatingBattlePetTooltip) end)

------------------------------------------------------------------------
--	Add info to GameTooltip and derivatives
------------------------------------------------------------------------

local S_COLLECTED      = COLLECTED
local S_NOT_COLLECTED  = NOT_COLLECTED
local S_ITEM_PET_KNOWN = strmatch(ITEM_PET_KNOWN, "[^%(]+")

local warned = {}

local function SetTooltipPetInfo(self, species, guid)
	if species == "" or type(species) == "string" and not PetNameToSpecies[species] then return end
	local tooltip = self:GetName()
	--print("SetTooltipPetInfo:", tooltip, "["..(species or "nil").."]", guid)
	local addString = true

	for i = 2, self:NumLines() do
		local line = _G[tooltip.."TextLeft"..i]
		local text = strtrim(line:GetText() or "")
		--print("Checking line", i, text)
		if text == UNIT_CAPTURABLE or ((strmatch(text, S_COLLECTED) or strmatch(text, S_NOT_COLLECTED) or strmatch(text, S_ITEM_PET_KNOWN)) and not strmatch(text, '"')) then -- flavor text gtfo
			--print("Modifying existing line:", text)
			addString = false
			local petString = C_PetJournal.GetOwnedBattlePetString(species)
			if petString then
				line:SetText(petString)
				if not colorblindMode then
					local hex = strmatch(petString, "|cff%x%x%x%x%x%x")
					local quality = hex and HexToPetQuality[hex]
					if quality then
						ColorBorderByQuality(self, quality)
					end
				end
			elseif not warned[species] then
				-- Missing itemID -> speciesID mapping
				DEFAULT_CHAT_FRAME:AddMessage("|cffff7f7fBetterBattlePetTooltip:|r Missing pet string for " .. species)
				warned[species] = true
				return
			end
			break
		end
	end

	if addString then
		local petString = C_PetJournal.GetOwnedBattlePetString(species or _G[tooltip.."TextLeft1"]:GetText())
		if petString then
			--print("Adding new line.")
			self:AddLine(petString)
			if not colorblindMode then
				local hex = strmatch(petString, "|cff%x%x%x%x%x%x")
				local quality = hex and HexToPetQuality[hex]
				if quality then
					ColorBorderByQuality(self, quality)
				end
			end
		end
	end

	if guid and db.wildQuality then
		local quality = seenWildPetQualities[guid]
		if quality then
			local color = RED_FONT_COLOR
			local qcolor = not colorblindMode and PetQualityColors[quality]
			local breed = db.breed and seenWildPetBreeds[guid]
			-- print("Already battled:", quality, breed)
			local infoString
			if PetTracker then -- icon + quality
				infoString = breed .. PetQualityStrings[quality]
			elseif breed and qcolor then -- breed only
				infoString = PetBreedNames[breed]
			elseif breed then -- quality + breed
				infoString = PetQualityStrings[quality] .. " " .. PetBreedNames[breed]
			else -- quality only
				infoString = PetQualityStrings[quality]
			end
			self:AddLine(L.AlreadyBattled .. L.Colon .. (qcolor and qcolor.hex or HIGHLIGHT_FONT_COLOR_CODE) .. infoString, color.r, color.g, color.b)
		else
			--print("Not yet battled.")
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
		local species = PetItemToSpecies[tonumber(strmatch(link, "item:(%d+)"))]
		--print("OnTooltipSetItem:", link, species)
		SetTooltipPetInfo(self, species or item)
	end
end

GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
ItemRefTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
ItemRefTooltip:HookScript("OnShow", OnTooltipSetItem) -- hyperlinks don't trigger OnTooltipSetItem

------------------------------------------------------------------------
--	Add info to spell tooltips
------------------------------------------------------------------------

local ignoreSpells = {
	[77799] = true, -- Fel Flame
}

local function OnTooltipSetSpell(self)
	local spell, _, spellID = self:GetSpell()
	--print("OnTooltipSetSpell:", spell)
	if spell and not ignoreSpells[spellID] then
		SetTooltipPetInfo(self, spell)
	end
end

GameTooltip:HookScript("OnTooltipSetSpell", OnTooltipSetSpell)
ItemRefTooltip:HookScript("OnTooltipSetSpell", OnTooltipSetSpell)

------------------------------------------------------------------------
--	Add info to unit tooltips
------------------------------------------------------------------------

local function OnTooltipSetUnit(self)
	local _, unit = self:GetUnit()
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
	if not text or text == currentText then
		return
	elseif not strmatch(text, "\n") then
		local name = strtrim(gsub(gsub(gsub(text, "|T.-|t", ""), "|cff%x%x%x%x%x%x", ""), "|r", ""))
		SetTooltipPetInfo(GameTooltip, name)
	else
		local i = 0
		for text in gmatch(text, "[^\n]+") do
			local name = strtrim(gsub(gsub(gsub(text, "|T.-|t", ""), "|cff%x%x%x%x%x%x", ""), "|r", ""))
			local petString = C_PetJournal.GetOwnedBattlePetString(name)
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
	if UnitIsWildBattlePet("target") and C_PetBattles.IsWildBattle() then
		local guid = UnitGUID("target")
		local quality = C_PetBattles.GetBreedQuality(LE_BATTLE_PET_ENEMY, 1)
		local _, _, _, _, _, _, _, _, _, _, obtainable = C_PetJournal.GetPetInfoBySpeciesID(C_PetBattles.GetPetSpeciesID(LE_BATTLE_PET_ENEMY, 1))
		if guid and quality and obtainable then
			seenWildPetQualities[guid] = quality
			--print("seen quality:", quality)
		end
		if LibPetBreedInfo then
			local breed, confidence = LibPetBreedInfo:GetBreedByPetBattleSlot(LE_BATTLE_PET_ENEMY, 1)
			if breed then
				if PetTracker then
					seenWildPetBreeds[guid] = PetTracker:GetBreedIcon(breed, 0.8, -2)
				else
					seenWildPetBreeds[guid] = breed
				end
				--print("seen breed:", seenWildPetBreeds[guid])
			end
		end
	end
end