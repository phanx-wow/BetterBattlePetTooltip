--[[--------------------------------------------------------------------
	BetterBattlePetTooltip
	A World of Warcraft user interface addon
	Copyright (c) 2012-2013 A. Kinley (Phanx)

	This addon is freely available, and its source code freely viewable,
	but it is not "open source software" and you may not distribute it,
	with or without modifications, without permission from its author.

	See the included README and LICENSE files for more information!
----------------------------------------------------------------------]]

local ADDON, private = ...
local L = private.L

local battled = {}
local petCount, petLevel, petQuality, petSpecies = {}, {}, {}, {}
local speciesFromItem = private.speciesFromItem

local BATTLE_PET_CAGE_TOOLTIP_LEVEL_S = "%s (" .. BATTLE_PET_CAGE_TOOLTIP_LEVEL .. ")"
local ITEM_PET_KNOWN_S = gsub(ITEM_PET_KNOWN, "[%(%)]", "%%%1")

------------------------------------------------------------------------

local __GetOwnedBattlePetString = C_PetJournal.GetOwnedBattlePetString
C_PetJournal.GetOwnedBattlePetString = function(species)
	local text = __GetOwnedBattlePetString(species)
	if not text then
		return petCount[species] and NOT_COLLECTED
	end
	if BBPT_COUNT then
		text = strmatch(text, ITEM_PET_KNOWN_S) or text -- strip inline color
	else
		text = COLLECTED
	end
	if BBPT_LEVEL then
		text = format(BATTLE_PET_CAGE_TOOLTIP_LEVEL_S, text, petLevel[species])
	end
	return text
end

------------------------------------------------------------------------

local BorderRegions = { "BorderTopLeft", "BorderTopRight", "BorderBottomRight", "BorderBottomLeft", "BorderTop", "BorderRight", "BorderBottom", "BorderLeft" }
local function SetBorderColor(self, r, g, b)
	self:SetBackdropBorderColor(r, g, b)
	for i = 1, #BorderRegions do
		self[BorderRegions[i]]:SetVertexColor(r, g, b)
	end
end

------------------------------------------------------------------------
--	PetBattleUnitTooltip
--	LibPetJournal-2.0

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event)
	if event == "PET_BATTLE_OPENING_START" then
		if UnitIsWildBattlePet("target") then
			local guid = UnitGUID("target")
			local quality = C_PetBattles.GetBreedQuality(LE_BATTLE_PET_ENEMY, 1)
			if guid and quality then
				battled[guid] = quality
			end
		end
		return
	end

	if PetBattleUnitTooltip_UpdateForUnit and not self.hookedPetBattleUI then
		hooksecurefunc("PetBattleUnitTooltip_UpdateForUnit", function(self, owner, index)
			local species = C_PetBattles.GetPetSpeciesID(owner, index)

			local SHOW_COLORS = tonumber(ENABLE_COLORBLIND_MODE) == 0

			local color = SHOW_COLORS and ITEM_QUALITY_COLORS[C_PetBattles.GetBreedQuality(owner, index) - 1] or TOOLTIP_DEFAULT_COLOR
			SetBorderColor(self, color.r, color.g, color.b)

			if owner == LE_BATTLE_PET_ENEMY and C_PetBattles.IsWildBattle() then
				local text = C_PetJournal.GetOwnedBattlePetString(species)
				self.CollectedText:SetText(text)

				if SHOW_COLORS then
					local quality = petQuality[species]
					local color = quality and ITEM_QUALITY_COLORS[quality - 1] or ITEM_QUALITY_COLORS[5]
					self.CollectedText:SetTextColor(color.r, color.g, color.b)
				else
					self.CollectedText:SetTextColor(1, 1, 1)
				end
			end
		end)
		self.hookedPetBattleUI = true
	end

	if not self.registeredCallback then
		local PetJournal = LibStub("LibPetJournal-2.0")
		PetJournal.RegisterCallback(ADDON, "PetListUpdated", function()
			wipe(petCount)
			wipe(petLevel)
			wipe(petQuality)
			wipe(petSpecies)

			for _, species in PetJournal:IterateSpeciesIDs() do
				local name = C_PetJournal.GetPetInfoBySpeciesID(species)
				petSpecies[name] = species
				petCount[species] = 0 -- serves as a "is this a valid speciesID" check
			end

			for _, pet in PetJournal:IteratePetIDs() do
				local species, _, level = C_PetJournal.GetPetInfoByPetID(pet)
				local _, _, _, _, quality = C_PetJournal.GetPetStats(pet)
				petCount[species] = 1 + petCount[species]
				petLevel[species] = max(level, petLevel[species] or 0)
				petQuality[species] = max(quality, petQuality[species] or 0)
			end
		end)
		self.registeredCallback = true
		self:RegisterEvent("PET_BATTLE_OPENING_START")
	end
end)

------------------------------------------------------------------------
--	BattlePetTooltip

local function BattlePetTooltip_OnShow(self)
	if tonumber(ENABLE_COLORBLIND_MODE) > 0 then
		self.Owned:SetTextColor(1, 1, 1)
		SetBorderColor(self, 1, 1, 1)
		return
	end

	local quality = petQuality[self.speciesID]
	if quality then
		local color = ITEM_QUALITY_COLORS[quality - 1]
		self.Owned:SetTextColor(color.r, color.g, color.b)
	else
		local color = ITEM_QUALITY_COLORS[5]
		self.Owned:SetTextColor(color.r, color.g, color.b)
	end

	SetBorderColor(self, self.Name:GetTextColor())
end

hooksecurefunc("BattlePetToolTip_Show", function() BattlePetTooltip_OnShow(BattlePetTooltip) end)
hooksecurefunc("FloatingBattlePet_Show", function() BattlePetTooltip_OnShow(FloatingBattlePetTooltip) end)

------------------------------------------------------------------------
--	GameTooltip and derivatives

local function AddTooltipInfo(tooltip, name, species, guid)
	--print("AddTooltipInfo", name, species)
	if not species then
		species = petSpecies[name] or petSpecies[_G[tooltip:GetName().."TextLeft1"]:GetText()]
	end
	if not species then
		--print("species not found")
		return
	end

	local SHOW_COLORS = tonumber(ENABLE_COLORBLIND_MODE) == 0
	local addedInfo

	for i = 2, tooltip:NumLines() do
		local line = _G[tooltip:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text == NOT_COLLECTED or text == UNIT_CAPTURABLE then
			--print("modifying line", i, text)
			local color = SHOW_COLORS and ITEM_QUALITY_COLORS[5] or HIGHLIGHT_FONT_COLOR
			line:SetTextColor(color.r, color.g, color.b)
			line:SetText(NOT_COLLECTED)
			addedInfo = true

		elseif strmatch(text, ITEM_PET_KNOWN_S) then
			--print("modifying line", i, text)
			if SHOW_COLORS then
				local quality = petQuality[species]
				local color = quality and ITEM_QUALITY_COLORS[quality-1] or ITEM_QUALITY_COLORS[6] -- heirloom for unknown
				line:SetTextColor(color.r, color.g, color.b)
				tooltip:SetBackdropBorderColor(color.r, color.g, color.b)
			else
				line:SetTextColor(1, 1, 1)
			end
			line:SetText(C_PetJournal.GetOwnedBattlePetString(species))
			addedInfo = true
		end
	end

	if not addedInfo then
		if petCount[species] > 0 then
			--print("adding info")
			if SHOW_COLORS then
				local quality = petQuality[species]
				local color = quality and ITEM_QUALITY_COLORS[quality-1] or ITEM_QUALITY_COLORS[6] -- heirloom for unknown
				tooltip:AddLine(C_PetJournal.GetOwnedBattlePetString(species), color.r, color.g, color.b)
				tooltip:SetBackdropBorderColor(color.r, color.g, color.b)
			else
				tooltip:AddLine(C_PetJournal.GetOwnedBattlePetString(species), 1, 1, 1)
			end
		else
			local _, _, _, _, _, _, _, _, _, _, obtainable = C_PetJournal.GetPetInfoBySpeciesID(species)
			if obtainable then
				--print("adding", NOT_COLLECTED)
				local color = SHOW_COLORS and ITEM_QUALITY_COLORS[5] or HIGHLIGHT_FONT_COLOR
				tooltip:AddLine(NOT_COLLECTED, color.r, color.g, color.b)
			else
				--print("not obtainable")
			end
		end
	end

	if guid and BBPT_WILD_QUALITY then
		local quality = battled[guid]
		if quality then
			local color = RED_FONT_COLOR
			local qcolor = SHOW_COLORS and ITEM_QUALITY_COLORS[quality-1]
			tooltip:AddLine(format(L.AlreadyBattled, qcolor and qcolor.hex or "|cffffffff", _G["BATTLE_PET_BREED_QUALITY"..quality]), color.r, color.g, color.b)
		end
	end

	tooltip:Show()
end

------------------------------------------------------------------------
--	Item tooltips

local function AddTooltipItemInfo(tooltip)
	local name, link = tooltip:GetItem()
	if link then
		local id = tonumber(strmatch(link, "item:(%d+)"))
		if id then
			AddTooltipInfo(tooltip, name, speciesFromItem[id])
		end
	end
end

GameTooltip:HookScript("OnTooltipSetItem", AddTooltipItemInfo)
ItemRefTooltip:HookScript("OnTooltipSetItem", AddTooltipItemInfo)

------------------------------------------------------------------------
--	Unit tooltips

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	local name, unit = GameTooltip:GetUnit()
	if unit and UnitIsWildBattlePet(unit) then
		AddTooltipInfo(self, name, UnitBattlePetSpeciesID(unit), UnitGUID(unit))
	end
end)

------------------------------------------------------------------------
--	Minimap tracking tooltips

local current

local updater = CreateFrame("Frame")
updater:Hide()
updater:SetScript("OnUpdate", function()
	local text = GameTooltipTextLeft1:GetText()
	if text == current then
		return
	end
	current = text
	if strfind(text, "\n") then
		-- Multiples
		for text in gmatch(text, "[^\n]+") do
			local name = strtrim(gsub(text, "|T.-|t", ""))
			--print("multiple:", name)
			AddTooltipInfo(GameTooltip, name)
		end
	else
		-- Just one
		local name = strtrim(gsub(text, "|T.-|t", ""))
		--print("single:", name)
		AddTooltipInfo(GameTooltip, name)
	end
end)

GameTooltip:HookScript("OnShow", function(self)
	if self:IsOwned(Minimap) then
		updater:Show()
	end
end)

GameTooltip:HookScript("OnHide", function(self)
	updater:Hide()
	current = nil
end)

------------------------------------------------------------------------