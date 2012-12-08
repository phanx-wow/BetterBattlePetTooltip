--[[--------------------------------------------------------------------
	Based on PetCaught by Lifetapt
----------------------------------------------------------------------]]

local petCount, petLevel, petQuality = {}, {}, {}

local F_BATTLE_PET_CAGE_TOOLTIP_LEVEL = " (" .. BATTLE_PET_CAGE_TOOLTIP_LEVEL .. ")"
local S_ITEM_PET_KNOWN = ITEM_PET_KNOWN:gsub("[%(%)]", "%%%1")
local L_PET_CAPTURABLE = gsub(NOT_COLLECTED, COLLECTED, UNIT_CAPTURABLE)

------------------------------------------------------------------------

local function GetText(text, name, count, level, quality)
	if not name then return "" end
	if not count then count = petCount[name] end
	if not level then level = petLevel[name] end
	if not quality then quality = petQuality[name] end

	local level = BBPT_ShowLevel and format(F_BATTLE_PET_CAGE_TOOLTIP_LEVEL, petLevel[name]) or ""
	if BBPT_HideCount then
		text = gsub(text, "%(.+%)", "")
	end
	if tonumber(ENABLE_COLORBLIND_MODE) > 0 then
		return "%s%s (%s)", text, level, _G["BATTLE_PET_BREED_QUALITY"..quality]
	else
		return "%s%s", text, level
	end
end

------------------------------------------------------------------------

local function BattlePetTooltip_OnShow(f)
	if f.Owned then
		f:SetHeight(f:GetHeight() + 12)
	end

	local line = f.Owned or f.CollectedText

	local name = f.Name:GetText()
	local quality = name and petQuality[name]
	if quality then
		local text = strmatch(line:GetText(), S_ITEM_PET_KNOWN)
		if text then
			line:SetFormattedText(GetText(text, name, nil, nil, quality))
			if tonumber(ENABLE_COLORBLIND_MODE) == 0 then
				local color = ITEM_QUALITY_COLORS[quality - 1]
				line:SetTextColor(color.r, color.g, color.b)
				f:SetBackdropBorderColor(color.r, color.g, color.b)
			else
				line:SetTextColor(1, 1, 1)
			end
			return
		else
			-- no match, probably already modified it
		end
	elseif line:IsShown() then
		line:SetText(NOT_COLLECTED)
		line:Hide()
		line:Show()
		if tonumber(ENABLE_COLORBLIND_MODE) == 0 then
			local color = ITEM_QUALITY_COLORS[5]
			line:SetTextColor(color.r, color.g, color.b)

			local r, g, b = f.Name:GetTextColor()
			f:SetBackdropBorderColor(r, g, b)
		else
			line:SetTextColor(1, 1, 1)
		end
	else
		line:SetText(L_NOT_CAPTURABLE)
		line:SetTextColor(1, 1, 1)
		line:Show()
		f.HealthBorder:SetPoint("TOPLEFT", line, "BOTTOMLEFT", -1, -6)
		f:SetHeight(f:GetHeight() + line:GetHeight())
	end
end

local function BattlePetTooltip_OnHide(f)
	f.alreadyShowing = nil
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PET_JOURNAL_LIST_UPDATE")
f:SetScript("OnEvent", function(f, event)
	if event == "PET_JOURNAL_LIST_UPDATE" then
		wipe(petCount)
		wipe(petLevel)
		wipe(petQuality)
		for i = 1, C_PetJournal.GetNumPets(false) do
			local id, _, owned, _, level, _, _, name, _, _, _, _, _, wild = C_PetJournal.GetPetInfoByIndex(i)
			if id and name then
				if owned then
					local _, _, _, _, quality = C_PetJournal.GetPetStats(id)
					petCount[name] = 1 + (petCount[name] or 0)
					if not petLevel[name] or level > petLevel[name] then
						petLevel[name] = level
					end
					if not petQuality[name] or quality > petQuality[name] then
						petQuality[name] = quality
					end
				elseif not petCount[name] then
					petCount[name] = 0
				end
			end
		end

	elseif event == "PLAYER_LOGIN" then
		BattlePetTooltip:HookScript("OnShow", BattlePetTooltip_OnShow)
		BattlePetTooltip:HookScript("OnHide", BattlePetTooltip_OnHide)

		FloatingBattlePetTooltip:HookScript("OnShow", BattlePetTooltip_OnShow)
		FloatingBattlePetTooltip:HookScript("OnHide", BattlePetTooltip_OnHide)

		BattlePetTooltip.Name:SetFontObject(GameTooltipHeaderText)
		FloatingBattlePetTooltip.Name:SetFontObject(GameTooltipHeaderText)

	elseif PetBattlePrimaryUnitTooltip then
		hooksecurefunc(PetBattlePrimaryUnitTooltip, "Show", BattlePetTooltip_OnShow)
		hooksecurefunc(PetBattlePrimaryUnitTooltip, "Hide", BattlePetTooltip_OnHide)

		f:UnregisterEvent("ADDON_LOADED")
	end
end)

------------------------------------------------------------------------

local function AddTooltipInfo(tooltip, name)
	local count, quality = petCount[name], petQuality[name]
	if not count then
		-- not a valid pet name
		return
	end

	for i = 2, tooltip:NumLines() do
		local line = _G[tooltip:GetName().."TextLeft"..i]
		local text = line:GetText()
		if text == NOT_COLLECTED or text == UNIT_CAPTURABLE then
			line:SetText(NOT_COLLECTED)
			if tonumber(ENABLE_COLORBLIND_MODE) == 0 then
				local color = ITEM_QUALITY_COLORS[5]
				line:SetTextColor(color.r, color.g, color.b)
			else
				line:SetTextColor(1, 1, 1)
			end
			return

		elseif strmatch(text, S_ITEM_PET_KNOWN) then
			local color = ITEM_QUALITY_COLORS[quality - 1]
			line:SetFormattedText(GetText(text, name, count, nil, quality))
			if tonumber(ENABLE_COLORBLIND_MODE) == 0 then
				line:SetTextColor(color.r, color.g, color.b)
				tooltip:SetBackdropBorderColor(color.r, color.g, color.b)
			else
				line:SetTextColor(1, 1, 1)
			end
			tooltip:Show()
			return
		end
	end

	if count > 0 then
		local color = tonumber(ENABLE_COLORBLIND_MODE) > 0 and HIGHLIGHT_FONT_COLOR or ITEM_QUALITY_COLORS[quality - 1]
		tooltip:AddLine(format(GetText(BBPT_HideCount and COLLECTED or format(ITEM_PET_KNOWN, count, 3), name, count, nil, quality)), color.r, color.g, color.b)
		tooltip:SetBackdropBorderColor(color.r, color.g, color.b)
	else
		local color = tonumber(ENABLE_COLORBLIND_MODE) > 0 and HIGHLIGHT_FONT_COLOR or ITEM_QUALITY_COLORS[5]
		tooltip:AddLine(NOT_COLLECTED, color.r, color.g, color.b)
	end
	tooltip:Show()
end

------------------------------------------------------------------------

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
			local name = gsub(text, ".+|t", "")
			AddTooltipInfo(GameTooltip, name)
		end
	else
		-- Just one
		local name = gsub(text, ".+|t", "")
		AddTooltipInfo(GameTooltip, name)
	end
end)

GameTooltip:HookScript("OnShow", function(self)
	if UnitIsWildBattlePet("mouseover") then
		AddTooltipInfo(self, UnitName("mouseover"))
	elseif self:IsOwned(Minimap) then
		updater:Show()
	end
end)

GameTooltip:HookScript("OnHide", function(self)
	updater:Hide()
	current = nil
end)