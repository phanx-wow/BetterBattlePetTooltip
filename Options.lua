--[[--------------------------------------------------------------------
	BetterBattlePetTooltip
	Copyright (c) 2012-2014 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info21978-BetterBattlePetTooltip.html
	http://www.curse.com/addons/wow/betterbattlepettooltip
	https://github.com/Phanx/BetterBattlePetTooltip
----------------------------------------------------------------------]]

local ADDON, Addon = ...
local L = Addon.L

local Options = CreateFrame("Frame", ADDON.."Options", InterfaceOptionsFramePanelContainer)
Options.name = GetAddOnMetadata(ADDON, "Title") or ADDON
InterfaceOptions_AddCategory(Options)
Addon.OptionsPanel = Options

local Title = Options:CreateFontString("$parentTitle", "ARTWORK", "GameFontNormalLarge")
Title:SetPoint("TOPLEFT", 16, -16)
Title:SetText(Options.name)

local SubText = Options:CreateFontString("$parentSubText", "ARTWORK", "GameFontHighlightSmall")
SubText:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 0, -8)
SubText:SetPoint("RIGHT", -32, 0)
SubText:SetHeight(32)
SubText:SetJustifyH("LEFT")
SubText:SetJustifyV("TOP")
SubText:SetText(GetAddOnMetadata(ADDON, "Notes"))

local options = {}
local function SetOption(self)
	local checked = self:GetChecked()
	BBPTDB[options[self]] = checked
	Addon.EventFrame:PET_JOURNAL_LIST_UPDATE()
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainmenuOptionCheckBoxOff")
end

local ShowCount = CreateFrame("CheckButton", "$parentCount", Options, "InterfaceOptionsCheckButtonTemplate")
ShowCount:SetPoint("TOPLEFT", SubText, "BOTTOMLEFT", -2, -8)
ShowCount:SetScript("OnClick", SetOption)
ShowCount.Text:SetText(L.ShowCount)
options[ShowCount] = "count"

local ShowLevel = CreateFrame("CheckButton", "$parentLevel", Options, "InterfaceOptionsCheckButtonTemplate")
ShowLevel:SetPoint("TOPLEFT", ShowCount, "BOTTOMLEFT", 0, -8)
ShowCount:SetScript("OnClick", SetOption)
ShowLevel.Text:SetText(L.ShowLevel)
options[ShowLevel] = "level"

local ShowBreed = CreateFrame("CheckButton", "$parentBreeds", Options, "InterfaceOptionsCheckButtonTemplate")
ShowBreed:SetPoint("TOPLEFT", ShowLevel, "BOTTOMLEFT", 0, -8)
ShowCount:SetScript("OnClick", SetOption)
ShowBreed:SetMotionScriptsWhileDisabled(true)
ShowBreed.Text:SetText(L.ShowBreed)
options[ShowBreed] = "breed"

local ShowAll = CreateFrame("CheckButton", "$parentAll", Options, "InterfaceOptionsCheckButtonTemplate")
ShowAll:SetPoint("TOPLEFT", ShowBreed, "BOTTOMLEFT", 0, -8)
ShowAll:SetScript("OnClick", SetOption)
ShowAll.Text:SetText(L.ShowAll)
ShowAll.tooltipText = L.ShowAll_Tooltip
options[ShowAll] = "all"

local ShowWildQuality = CreateFrame("CheckButton", "$parentWildQuality", Options, "InterfaceOptionsCheckButtonTemplate")
ShowWildQuality:SetPoint("TOPLEFT", ShowAll, "BOTTOMLEFT", 0, -8)
ShowWildQuality:SetScript("OnClick", SetOption)
ShowWildQuality.Text:SetText(L.ShowWildQuality)
ShowWildQuality.tooltipText = L.ShowWildQuality_Tooltip
options[ShowWildQuality] = "wildQuality"

local ColorTooltipBorder = CreateFrame("CheckButton", "$parentTooltipColor", Options, "InterfaceOptionsCheckButtonTemplate")
ColorTooltipBorder:SetPoint("TOPLEFT", ShowWildQuality, "BOTTOMLEFT", 0, -8)
ColorTooltipBorder:SetScript("OnClick", SetOption)
ColorTooltipBorder.Text:SetText(L.ColorTooltipBorder)
ColorTooltipBorder.tooltipText = L.ColorTooltipBorder_Tooltip
options[ColorTooltipBorder] = "tooltipColor"

Options.refresh = function()
	for checkbox, key in pairs(options) do
		checkbox:SetChecked(BBPTDB[key])
		checkbox:SetHitRectInsets(0, -16 - checkbox.Text:GetWidth(), 0, 0)
	end
	if LibStub("LibPetBreedInfo-1.0", true) then
		ShowBreed:SetEnabled(true)
		ShowBreed.tooltipText = nil
	else
		ShowBreed:SetEnabled(false)
		ShowBreed.tooltipText = RED_FONT_COLOR_CODE .. L.ShowBreed_TooltipDisabled
	end
end

if LibStub and LibStub("LibAboutPanel", true) then
	Options.About = LibStub("LibAboutPanel").new(Options.name, ADDON)
end

SLASH_BBPT1 = "/bbpt"
SlashCmdList.BBPT = function()
	if Options.About then
		InterfaceOptionsFrame_OpenToCategory(Options.About)
	end
	InterfaceOptionsFrame_OpenToCategory(Options)
end