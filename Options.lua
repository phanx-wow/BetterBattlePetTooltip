--[[--------------------------------------------------------------------
	BetterBattlePetTooltip
	Copyright (c) 2012-2018 Phanx <addons@phanx.net>. All rights reserved.
	https://www.wowinterface.com/downloads/info21978-BetterBattlePetTooltip.html
	https://www.curseforge.com/wow/addons/betterbattlepettooltip
	https://github.com/phanx-wow/BetterBattlePetTooltip
----------------------------------------------------------------------]]

local ADDON, Addon = ...
local L = Addon.L

local Options = CreateFrame("Frame", ADDON.."Options", InterfaceOptionsFramePanelContainer)
Options.name = GetAddOnMetadata(ADDON, "Title") or ADDON
InterfaceOptions_AddCategory(Options)
Addon.OptionsPanel = Options

SLASH_BBPT1 = "/bbpt"
SlashCmdList.BBPT = function()
	InterfaceOptionsFrame_OpenToCategory(Options)
end

do
	local title = Options:CreateFontString("$parentTitle", "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(Options.name)

	local notes = Options:CreateFontString("$parentSubText", "ARTWORK", "GameFontHighlightSmall")
	notes:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	notes:SetPoint("RIGHT", -32, 0)
	notes:SetHeight(32)
	notes:SetJustifyH("LEFT")
	notes:SetJustifyV("TOP")
	notes:SetText(GetAddOnMetadata(ADDON, "Notes"))

	local chex = {}
	local function click(self)
		local checked = self:GetChecked()
		PlaySound(checked and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF)
		BBPTDB[self.key] = checked
		Addon.EventFrame:PET_JOURNAL_LIST_UPDATE() -- wipe text cache
		Options:refresh() -- update enabled state of dependencies etc.
	end
	local function disable(self) self.Text:SetFontObject(GameFontDisable) end
	local function enable(self) self.Text:SetFontObject(GameFontHighlightLeft) end

	local function new(key, text, tooltipText, dependsOn)
		local box = CreateFrame("CheckButton", nil, Options, "InterfaceOptionsCheckButtonTemplate")
		box:SetScript("OnClick", click)
		box:SetScript("OnDisable", disable)
		box:SetScript("OnEnable", enable)
		box:SetMotionScriptsWhileDisabled(true)
		box.Text:SetText(text)
		box.tooltipText = tooltipText
		box.dependsOn = dependsOn
		box.key = key
		chex[key] = box
		tinsert(chex, box)

		local prev = chex[#chex-1]
		if not prev then
			box:SetPoint("TOPLEFT", notes, "BOTTOMLEFT", -2, -8)
		elseif dependsOn and not prev.dependsOn then
			box:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 24, -8)
		elseif prev.dependsOn and not dependsOn then
			box:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", -24, -8)
		else
			box:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 0, -8)
		end

		return box
	end

	new("showAll",      L.ShowAll, L.ShowAll_Tooltip)
	new("showCount",    L.ShowCount)
	new("showLevel",    L.ShowLevel)
	new("compactLevel", L.CompactLevel, nil, "showLevel")
	new("showBreed",    L.ShowBreed)
	new("showSource",   L.ShowSource)
	new("showSourceOnlyMissing", L.ShowSourceOnlyMissing, nil, "showSource")
	new("showWildQuality",       L.ShowWildQuality, L.ShowWildQuality_Tooltip)
	new("colorTooltipBorder",    L.ColorTooltipBorder, L.ColorTooltipBorder_Tooltip)

	Options.refresh = function()
		for i = 1, #chex do
			local box = chex[i]
			box:SetChecked(BBPTDB[box.key])
			box:SetHitRectInsets(0, -16 - box.Text:GetWidth(), 0, 0)
			if box.dependsOn then
				box:SetEnabled(BBPTDB[box.dependsOn])
			end
		end
		if BBPTDB.showAll then
			chex.showCount:SetEnabled(false)
			chex.showCount.tooltipText = L.ShowCount_Tooltip
		else
			chex.showCount:SetEnabled(true)
			chex.showCount.tooltipText = nil
		end
		if GetBreedID_Battle or PetTracker or LibStub("LibPetBreedInfo-1.0", true) then
			chex.showBreed:SetEnabled(true)
			chex.showBreed.tooltipText = nil
		else
			chex.showBreed:SetEnabled(false)
			chex.showBreed.tooltipText = RED_FONT_COLOR_CODE .. L.ShowBreed_Tooltip
		end
	end
end
