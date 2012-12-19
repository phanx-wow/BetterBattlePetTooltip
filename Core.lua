--[[--------------------------------------------------------------------
	BetterBattlePetTooltip
	A World of Warcraft user interface addon
	Copyright (c) 2012 Phanx

	This addon is freely available, and its source code freely viewable,
	but it is not "open source software" and you may not distribute it,
	with or without modifications, without permission from its author.

	See the included README and LICENSE files for more information!
----------------------------------------------------------------------]]

local petCount, petLevel, petQuality, petSpecies = {}, {}, {}, {}

local F_BATTLE_PET_CAGE_TOOLTIP_LEVEL = "%s (" .. BATTLE_PET_CAGE_TOOLTIP_LEVEL .. ")"
local S_ITEM_PET_KNOWN = ITEM_PET_KNOWN:gsub("[%(%)]", "%%%1")
local L_PET_CAPTURABLE = gsub(NOT_COLLECTED, COLLECTED, UNIT_CAPTURABLE)

------------------------------------------------------------------------

local get = C_PetJournal.GetOwnedBattlePetString
C_PetJournal.GetOwnedBattlePetString = function(speciesID)
	local text = get(speciesID)
	if not text then
		return petCount[speciesID] and NOT_COLLECTED
	end
	if BBPT_HideCount then
		text = COLLECTED
	else
		text = strmatch(text, S_ITEM_PET_KNOWN) or text -- strips inline color
	end
	if BBPT_ShowLevel then
		text = format(F_BATTLE_PET_CAGE_TOOLTIP_LEVEL, text, petLevel[speciesID])
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

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
f:SetScript("OnEvent", function(f, event)
	if event == "PET_JOURNAL_LIST_UPDATE" then
		local wiped
		for i = C_PetJournal.GetNumPets(false), 1, -1 do
			local id, species, owned, _, level, _, _, name, _, _, _, _, _, wild = C_PetJournal.GetPetInfoByIndex(i)
			if not id or not name then
				-- List is filtered. Skip update.
				break
			end

			if not wiped then
				wipe(petCount)
				wipe(petLevel)
				wipe(petQuality)
				wipe(petSpecies)
				wiped = true
			end

			petSpecies[name] = species
			if owned then
				local _, _, _, _, quality = C_PetJournal.GetPetStats(id)
				petCount[species] = 1 + (petCount[species] or 0)
				if not petLevel[species] or level > petLevel[species] then
					petLevel[species] = level
				end
				if not petQuality[species] or quality > petQuality[species] then
					petQuality[species] = quality
				end
			elseif not petCount[species] then
				petCount[species] = 0
			end
		end
	elseif PetBattleUnitTooltip_UpdateForUnit then
		hooksecurefunc("PetBattleUnitTooltip_UpdateForUnit", function(self, owner, index)
			local species = C_PetBattles.GetPetSpeciesID(owner, index)

			local color = tonumber(ENABLE_COLORBLIND_MODE) > 0 and ITEM_QUALITY_COLORS[C_PetBattles.GetBreedQuality(owner, index) - 1] or TOOLTIP_DEFAULT_COLOR
			SetBorderColor(self, color.r, color.g, color.b)

			if owner == LE_BATTLE_PET_ENEMY and C_PetBattles.IsWildBattle() then
				local text = C_PetJournal.GetOwnedBattlePetString(species)
				self.CollectedText:SetText(text)

				if tonumber(ENABLE_COLORBLIND_MODE) > 0 then
					self.CollectedText:SetTextColor(1, 1, 1)
				else
					local quality = petQuality[species]
					local color = quality and ITEM_QUALITY_COLORS[quality - 1] or ITEM_QUALITY_COLORS[5]
					self.CollectedText:SetTextColor(color.r, color.g, color.b)
				end
			end
		end)
		f:UnregisterEvent("ADDON_LOADED")
	end
end)

------------------------------------------------------------------------
--	GameTooltip derivatives

local function AddTooltipInfo(tooltip, name)
	if not name then
		name = _G[tooltip:GetName().."TextLeft1"]:GetText()
	end
	local species = petSpecies[name]
	if not species then
		return
	end

	for i = 2, tooltip:NumLines() do
		local line = _G[tooltip:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text == NOT_COLLECTED or text == UNIT_CAPTURABLE then
			line:SetText(NOT_COLLECTED)

			local color = tonumber(ENABLE_COLORBLIND_MODE) > 0 and HIGHLIGHT_FONT_COLOR or ITEM_QUALITY_COLORS[5]
			line:SetTextColor(color.r, color.g, color.b)

			return
		elseif strmatch(text, S_ITEM_PET_KNOWN) then
			line:SetText(C_PetJournal.GetOwnedBattlePetString(species))

			if tonumber(ENABLE_COLORBLIND_MODE) == 0 then
				local quality = petQuality[species]
				local color = quality and ITEM_QUALITY_COLORS[quality - 1] or ITEM_QUALITY_COLORS[6] -- heirloom for unknown
				line:SetTextColor(color.r, color.g, color.b)
				tooltip:SetBackdropBorderColor(color.r, color.g, color.b)
			else
				line:SetTextColor(1, 1, 1)
			end

			tooltip:Show()
			return
		end
	end

	if petCount[species] > 0 then
		local quality = petQuality[species]
		local color = quality and (tonumber(ENABLE_COLORBLIND_MODE) > 0 and HIGHLIGHT_FONT_COLOR or ITEM_QUALITY_COLORS[quality - 1]) or ITEM_QUALITY_COLORS[6] -- heirloom for unknown
		tooltip:AddLine(C_PetJournal.GetOwnedBattlePetString(species), color.r, color.g, color.b)
		tooltip:SetBackdropBorderColor(color.r, color.g, color.b)
	else
		local color = tonumber(ENABLE_COLORBLIND_MODE) > 0 and HIGHLIGHT_FONT_COLOR or ITEM_QUALITY_COLORS[5]
		tooltip:AddLine(NOT_COLLECTED, color.r, color.g, color.b)
	end
	tooltip:Show()
end

------------------------------------------------------------------------
--	Item tooltips

GameTooltip:HookScript("OnTooltipSetItem", AddTooltipInfo)
ItemRefTooltip:HookScript("OnTooltipSetItem", AddTooltipInfo)

------------------------------------------------------------------------
--	Unit tooltips

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	local name, unit = GameTooltip:GetUnit()
	if unit and UnitIsWildBattlePet(unit) then
		AddTooltipInfo(self, name)
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
			local name = strtrim(gsub(text, "|T.-|t", "$"))
			AddTooltipInfo(GameTooltip, name)
		end
	else
		-- Just one
		local name = strtrim(gsub(text, "|T.-|t", ""))
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