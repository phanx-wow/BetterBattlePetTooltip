--[[--------------------------------------------------------------------
	BetterBattlePetTooltip
	Copyright (c) 2012-2018 Phanx <addons@phanx.net>. All rights reserved.
	https://github.com/phanx-wow/BetterBattlePetTooltip
	https://www.curseforge.com/wow/addons/betterbattlepettooltip
	https://www.wowinterface.com/downloads/info21978
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

local PetBreedNames = {
	[ 3] = "B/B",
	[ 4] = "P/P",
	[ 5] = "S/S",
	[ 6] = "H/H",
	[ 7] = "H/P",
	[ 8] = "P/S",
	[ 9] = "H/S",
	[10] = "P/B",
	[11] = "S/B",
	[12] = "H/B",
}

local PetItemToSpecies = Addon.PetItemToSpecies

local PetNameToSpecies = setmetatable({}, { __index = function(t, name)
	local speciesID = C_PetJournal.FindPetIDByName(name)
	t[name] = speciesID
	return speciesID
end })

-- Used to match hyperlinked recipe items to the pet taught by the item created by the recipe
local ItemNameToSpecies = setmetatable({ __cached = false }, { __index = function(t, name)
	local done, found = true
	if not t.__cached then
		for itemID, speciesID in pairs(PetItemToSpecies) do
			local item = GetItemInfo(itemID)
			if item then
				t[item] = speciesID
				found = name == item and speciesID
			else
				done = false
			end
		end
		t.__cached = done
	end
	if done and not found then
		t[name] = false
	end
	return found
end })

------------------------------------------------------------------------

local colorblindMode
local petSourceText = {}
local seenWildPetQualities = {}
local seenWildPetBreeds = {}

local LEVEL_REMOVE = gsub(UNIT_LEVEL_TEMPLATE, "%%d", "")

------------------------------------------------------------------------

local defaults = {
	showAll               = false,
	showCount             = false,
	showLevel             = true,
	compactLevel          = true,
	showBreed             = false,
	showSource            = true,
	showSourceOnlyMissing = false,
	showWildQuality       = true,
	colorTooltipBorder    = true,
}
local dbremap = {
	all          = "showAll",
	breed        = "showBreed",
	count        = "showCount",
	level        = "showLevel",
	compact      = "compactLevel",
	wildQuality  = "showWildQuality",
	tooltipColor = "colorTooltipBorder",
}

------------------------------------------------------------------------

BBPTDB = defaults
local db = BBPTDB -- reassigned in ADDON_LOADED

local EventFrame = CreateFrame("Frame", ADDON)
EventFrame:SetScript("OnEvent", function(self, event, ...) return self[event] and self[event](self, event, ...) end)
Addon.EventFrame = EventFrame

EventFrame:RegisterEvent("ADDON_LOADED")
function EventFrame:ADDON_LOADED(event, name)
	if name ~= ADDON then return end

	db = BBPTDB
	for oldk, newk in pairs(dbremap) do
		local v = db[oldk]
		if type(v) ~= "nil" then
			db[newk] = v
			db[oldk] = nil
		end
	end
	for k, v in pairs(defaults) do
		if type(db[k]) == "nil" then
			db[k] = v
		end
	end

	colorblindMode = tonumber(GetCVar("colorblindMode")) > 0
	LibPetBreedInfo = LibStub("LibPetBreedInfo-1.0", true)

	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
end

------------------------------------------------------------------------
--	Rewrite pet strings
------------------------------------------------------------------------

do
	local petStringCache = {}
	local speciesIsOwned = {}

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

		if not speciesIsOwned[speciesID] then
			--print("Not collected")
			petString = (colorblindMode and HIGHLIGHT_FONT_COLOR_CODE or PetQualityColors[6].hex) .. L.NotCollected
			petStringCache[speciesID] = petString
			return petString
		end

		if IsAddOnLoaded("PetTracker_Breeds") then
			-- only use PetTracker icons if the breeds module is loaded
			petString = PetTracker.Journal:GetOwnedText(speciesID)
			if petString and colorblindMode then
				petString = gsub(petString, "|cff%x%x%x%x%x%x", HIGHLIGHT_FONT_COLOR_CODE)
			end
			--print("PetTracker:", petString)
		end

		if not petString then
			local showBreed = db.showBreed and (GetBreedID_Journal or LibPetBreedInfo)
			local baseString = db.showAll and (showBreed or db.showLevel) and (NORMAL_FONT_COLOR_CODE .. L.Collected .. L.Colon .. "|r")
			local numCollected, bestLevel, bestQuality, bestBreed = 0, 0, 0
			for _, petID in LibPetJournal:IteratePetIDs() do
				local species, _, level, _, _, _, _, name, _, _, _, _, _, _, _, _, unique = C_PetJournal.GetPetInfoByPetID(petID)
				if species == speciesID then
					numCollected = numCollected + 1
					local _, _, _, _, quality = C_PetJournal.GetPetStats(petID)
					if baseString then
						-- Show all, append
						local breed = showBreed and (GetBreedID_Journal and GetBreedID_Journal(petID) or PetBreedNames[LibPetBreedInfo:GetBreedByPetID(petID)])
						local color = colorblindMode and HIGHLIGHT_FONT_COLOR_CODE or PetQualityColors[quality].hex
						local qText = colorblindMode and format(L.Parentheses, PetQualityStrings[quality]) or ""
						if breed then
							petString = (numCollected > 1 and (petString .. L.Comma) or baseString) .. color .. (db.showLevel and format(L.CollectedLevelBreed, level, breed) or breed) .. qText .. "|r"
						else
							petString = (numCollected > 1 and (petString .. L.Comma) or baseString) .. color .. format(L.CollectedLevel, level) .. qText .. "|r"
						end
					elseif quality >= bestQuality then
						-- Show highest level of best quality only
						bestQuality = quality
						bestLevel = max(bestLevel, level)
						bestBreed = showBreed and (GetBreedID_Journal and GetBreedID_Journal(petID) or PetBreedNames[LibPetBreedInfo:GetBreedByPetID(petID)])
					end
				end
			end

			if petString then
				--print("All:", petString)
			elseif numCollected > 0 then
				if bestBreed and db.showLevel then
					petString = format(L.CollectedLevelBreed, bestLevel, bestBreed)
				elseif bestBreed then
					petString = bestBreed
				elseif db.showLevel then
					petString = format(L.CollectedLevel, bestLevel)
				end

				local color = colorblindMode and HIGHLIGHT_FONT_COLOR_CODE or PetQualityColors[bestQuality].hex
				local qText = colorblindMode and format(L.Parentheses, PetQualityStrings[bestQuality]) or ""
				if db.showCount and not isUnique then
					if petString then
						petString = L.Collected .. L.Colon .. color .. format(L.CollectedCount, numCollected) .. qText .. " - " .. petString .. "|r"
					else
						petString = L.Collected .. L.Colon .. color .. format(L.CollectedCount, numCollected) .. qText .. "|r"
					end
				elseif petString then
					petString = L.Collected .. L.Colon .. color .. petString .. qText .. "|r"
				else
					petString = L.Collected
				end

				if colorblindMode then
					petString = petString .. PetQualityStrings[bestQuality]
				end
				--print("Best:", petString)
			end
		end

		if db.compactLevel then
			petString = gsub(petString, LEVEL_REMOVE, "") -- TODO: check in various languages
		end

		petStringCache[speciesID] = petString
		return petString
	end

	function EventFrame:PET_JOURNAL_LIST_UPDATE()
		-- print("PET_JOURNAL_LIST_UPDATE")
		wipe(petStringCache)
		wipe(speciesIsOwned)
		for _, petID in LibPetJournal:IteratePetIDs() do
			local speciesID = C_PetJournal.GetPetInfoByPetID(petID)
			if speciesID then
				speciesIsOwned[speciesID] = true
			end
		end
		for _, speciesID in LibPetJournal:IterateSpeciesIDs() do
			if speciesIsOwned[speciesID] and db.showSourceOnlyMissing then
				petSourceText[speciesID] = nil
			else
				local _, _, _, _, source = C_PetJournal.GetPetInfoBySpeciesID(speciesID)
				petSourceText[speciesID] = source:gsub("|n$", ""):gsub("|r", "|cffffffff") .. "|r"
			end
		end
	end

	-- EventFrame:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
	LibPetJournal.RegisterCallback(EventFrame, "PetListUpdated", EventFrame.PET_JOURNAL_LIST_UPDATE)

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
		if not db.colorTooltipBorder then
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
				local color = colorblindMode and HIGHLIGHT_FONT_COLOR or GRAY_FONT_COLOR
				self.CollectedText:SetText(C_PetJournal.GetOwnedBattlePetString(speciesName))
				self.CollectedText:SetTextColor(color.r, color.g, color.b)
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
				self:UnregisterEvents(event)
			end
		end
	end
end

------------------------------------------------------------------------
--	Add border color and source info to BattlePetTooltip
------------------------------------------------------------------------

local function BattlePetTooltip_Show(self, species)
	--print("BattlePetTooltip_Show", species)
	local ownedText = self.Owned:GetText() -- C_PetJournal.GetOwnedBattlePetString(species)
	if not colorblindMode then
		local hex = strmatch(ownedText, "|cff%x%x%x%x%x%x")
		local quality = hex and HexToPetQuality[hex]
		if quality then
			ColorBorderByQuality(self, quality)
		end
	end
	local source = db.showSource and petSourceText[species]
	if source then
		local origHeight = self.Owned:GetHeight()
		self.Owned:SetWordWrap(true)
		self.Owned:SetText(ownedText .."|n" .. source)
		self:SetHeight(self:GetHeight() + self.Owned:GetHeight() - origHeight + 2)
		if self == FloatingBattlePetTooltip then
			self.Delimiter:SetPoint("TOPLEFT", self.Owned, "BOTTOMLEFT", -6, -2)
		end
	else
		self.Owned:SetWordWrap(false)
		if self == FloatingBattlePetTooltip then
			self.Delimiter:SetPoint("TOPLEFT", self.SpeedTexture, "BOTTOMLEFT", -6, -5)
		end
	end
end

hooksecurefunc("BattlePetToolTip_Show", function(species, level, quality, health, power, speed, customName)
	BattlePetTooltip_Show(BattlePetTooltip, species)
end)
hooksecurefunc("FloatingBattlePet_Show", function(species, level, quality, health, power, speed, customName, petID)
	BattlePetTooltip_Show(FloatingBattlePetTooltip, species)
end)

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
				local color = colorblindMode and HIGHLIGHT_FONT_COLOR or GRAY_FONT_COLOR
				line:SetText(petString)
				line:SetTextColor(color.r, color.g, color.b)
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
			local color = colorblindMode and HIGHLIGHT_FONT_COLOR or GRAY_FONT_COLOR
			self:AddLine(petString, color.r, color.g, color.b)
			if not colorblindMode then
				local hex = strmatch(petString, "|cff%x%x%x%x%x%x")
				local quality = hex and HexToPetQuality[hex]
				if quality then
					ColorBorderByQuality(self, quality)
				end
			end
		end
	end

	if guid and db.showWildQuality then
		local quality = seenWildPetQualities[guid]
		if quality then
			local color = RED_FONT_COLOR
			local qcolor = not colorblindMode and PetQualityColors[quality]
			local breed = db.showBreed and seenWildPetBreeds[guid]
			-- print("Already battled:", quality, breed)
			local infoString
			if breed and IsAddOnLoaded("PetTracker_Breeds") then -- icon + quality
				infoString = breed .. PetQualityStrings[quality]
			elseif breed and qcolor then -- breed only
				infoString = PetBreedNames[breed] or breed
			elseif breed then -- quality + breed
				infoString = PetQualityStrings[quality] .. " " .. (PetBreedNames[breed] or breed)
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
	if not item then return end

	local species
	if item == "" then
		species = ItemNameToSpecies[_G[self:GetName().."TextLeft1"]:GetText()]
	else
		species = PetItemToSpecies[tonumber(strmatch(link, "item:(%d+)"))] or PetNameToSpecies[item]
	end
	if not species then return end
	--print("OnTooltipSetItem:", link, species)
	SetTooltipPetInfo(self, species)

	local source = db.showSource and petSourceText[species]
	if source then
		self:AddLine(source)
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
	local species = spell and not ignoreSpells[spellID] and PetNameToSpecies[spell]
	if not species then return end
	--print("OnTooltipSetSpell:", spell)
	SetTooltipPetInfo(self, species)

	local source = db.showSource and petSourceText[species]
	if source then
		self:AddLine(source)
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
	if not unit or not UnitIsWildBattlePet(unit) then return end
	--print("UnitIsWildBattlePet")
	SetTooltipPetInfo(self, UnitBattlePetSpeciesID(unit), UnitGUID(unit))
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
		currentText = GameTooltipTextLeft1:GetText()
	else
		local i = 0
		local color = colorblindMode and HIGHLIGHT_FONT_COLOR_CODE or GRAY_FONT_COLOR_CODE
		for text in gmatch(text, "[^\n]+") do
			local name = strtrim(gsub(gsub(gsub(text, "|T.-|t", ""), "|cff%x%x%x%x%x%x", ""), "|r", ""))
			local petString = C_PetJournal.GetOwnedBattlePetString(name)
			if petString then
				i = i + 1
				multiparts[i] = text
				i = i + 1
				multiparts[i] = color .. petString .. "|r"
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

local BattlePetBreedID_EnemyObject = { petOwner = LE_BATTLE_PET_ENEMY, petIndex = 1 }

EventFrame:RegisterEvent("PET_BATTLE_OPENING_START")
function EventFrame:PET_BATTLE_OPENING_START(event)
	if UnitIsWildBattlePet("target") and C_PetBattles.IsWildBattle() then
		local guid = UnitGUID("target")
		local quality = C_PetBattles.GetBreedQuality(LE_BATTLE_PET_ENEMY, 1)
		local species = C_PetBattles.GetPetSpeciesID(LE_BATTLE_PET_ENEMY, 1)
		local _, _, _, _, _, _, _, _, _, _, obtainable = C_PetJournal.GetPetInfoBySpeciesID(species)
		if not guid or not quality or not obtainable then
			return
		end
		--print("seen quality:", quality)
		seenWildPetQualities[guid] = quality
		local confidence, breed = 0

		if LibPetBreedInfo then
			breed, confidence = LibPetBreedInfo:GetBreedByPetBattleSlot(LE_BATTLE_PET_ENEMY, 1)
			confidence = confidence or 0
			-- print("LibPetBreedInfo sees breed:", breed, PetBreedNames[breed], confidence and confidence >= 2.5 and "|cff33ff33" or "|cff999999", confidence)
			seenWildPetBreeds[guid] = breed
		end

		if GetBreedID_Battle then -- BattlePetBreedID
			breed = GetBreedID_Battle(BattlePetBreedID_EnemyObject)
			if confidence < 2.5 or breed ~= seenWildPetBreeds[guid] then
				-- print("BattlePetBreedID sees breed:", breed, PetBreedNames[breed])
				seenWildPetBreeds[guid] = breed
				confidence = 9000 -- don't let PetTracker override it
			end
		end

		if IsAddOnLoaded("PetTracker_Breeds") then
			-- only use PetTracker icons if the PetTracker_Breeds addon is loaded
			breed = PetTracker.Battle:Get(LE_BATTLE_PET_ENEMY, 1):GetBreed()
			if confidence < 2.5 then -- don't override anything else, because
				-- PetTracker is frequently wrong for */B breeds and new pets,
				-- but it needs to be last in the chain to get the icon.
				-- print("PetTracker sees breed:", breed, PetBreedNames[breed])
				seenWildPetBreeds[guid] = PetTracker:GetBreedIcon(breed, 0.8, -2)
			else
				-- use someone else's breed guess but PetTracker's icon
				seenWildPetBreeds[guid] = PetTracker:GetBreedIcon(seenWildPetBreeds[guid], 0.8, -2)
			end
		end
	end
end
