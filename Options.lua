--[[--------------------------------------------------------------------
	BetterBattlePetTooltip
	A World of Warcraft user interface addon
	Copyright (c) 2012-2014 A. Kinley (Phanx)

	This addon is freely available, and its source code freely viewable,
	but it is not "open source software" and you may not distribute it,
	with or without modifications, without permission from its author.

	See the included README and LICENSE files for more information!
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
Options.Title = Title

local SubText = Options:CreateFontString("$parentSubText", "ARTWORK", "GameFontHighlightSmall")
SubText:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 0, -8)
SubText:SetPoint("RIGHT", -32, 0)
SubText:SetHeight(32)
SubText:SetJustifyH("LEFT")
SubText:SetJustifyV("TOP")
SubText:SetText(GetAddOnMetadata(ADDON, "Notes"))
Options.SubText = SubText

local ShowCount = CreateFrame("CheckButton", "$parentCount", Options, "InterfaceOptionsCheckButtonTemplate")
ShowCount:SetPoint("TOPLEFT", SubText, "BOTTOMLEFT", -2, -8)
ShowCount.Text:SetText(L.ShowCount)
ShowCount:SetScript("OnClick", function(this)
	local checked = not not this:GetChecked()
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainmenuOptionCheckBoxOff")
	BBPTDB.count = checked
	Addon.EventFrame:PET_JOURNAL_LIST_UPDATE()
end)
Options.ShowCount = ShowCount

local ShowLevel = CreateFrame("CheckButton", "$parentLevel", Options, "InterfaceOptionsCheckButtonTemplate")
ShowLevel:SetPoint("TOPLEFT", ShowCount, "BOTTOMLEFT", 0, -8)
ShowLevel.Text:SetText(L.ShowLevel)
ShowLevel:SetScript("OnClick", function(this)
	local checked = not not this:GetChecked()
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainmenuOptionCheckBoxOff")
	BBPTDB.showLevel = checked
	Addon.EventFrame:PET_JOURNAL_LIST_UPDATE()
end)
Options.ShowLevel = ShowLevel

local ShowWildQuality = CreateFrame("CheckButton", "$parentWildQuality", Options, "InterfaceOptionsCheckButtonTemplate")
ShowWildQuality:SetPoint("TOPLEFT", ShowLevel, "BOTTOMLEFT", 0, -8)
ShowWildQuality.Text:SetText(L.ShowWildQuality)
ShowWildQuality.tooltipText = L.ShowWildQuality_Tooltip
ShowWildQuality:SetScript("OnClick", function(this)
	local checked = not not this:GetChecked()
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainmenuOptionCheckBoxOff")
	BBPTDB.wildQuality = checked
end)
Options.ShowWildQuality = ShowWildQuality

local ColorTooltipBorder = CreateFrame("CheckButton", "$parentTooltipColor", Options, "InterfaceOptionsCheckButtonTemplate")
ColorTooltipBorder:SetPoint("TOPLEFT", ShowWildQuality, "BOTTOMLEFT", 0, -8)
ColorTooltipBorder.Text:SetText(L.ColorTooltipBorder)
ColorTooltipBorder.tooltipText = L.ColorTooltipBorder_Tooltip
ColorTooltipBorder:SetScript("OnClick", function(this)
	local checked = not not this:GetChecked()
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainmenuOptionCheckBoxOff")
	BBPTDB.tooltipColor = checked
end)
Options.ColorTooltipBorder = ColorTooltipBorder

Options.refresh = function()
	ShowCount:SetChecked(BBPTDB.count)
	ShowLevel:SetChecked(BBPTDB.level)
	ShowWildQuality:SetChecked(BBPTDB.wildQuality)
	ColorTooltipBorder:SetChecked(BBPTDB.tooltipColor)

	ShowCount:SetHitRectInsets(0, -16 - ShowCount.Text:GetWidth(), 0, 0)
	ShowLevel:SetHitRectInsets(0, -16 - ShowLevel.Text:GetWidth(), 0, 0)
	ShowWildQuality:SetHitRectInsets(0, -16 - ShowWildQuality.Text:GetWidth(), 0, 0)
	ColorTooltipBorder:SetHitRectInsets(0, -16 - ColorTooltipBorder.Text:GetWidth(), 0, 0)
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