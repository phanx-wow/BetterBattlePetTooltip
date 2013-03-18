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

local Options = CreateFrame("Frame", "BBPTOptions", InterfaceOptionsFramePanelContainer)
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

local ShowCount = CreateFrame("CheckButton", "$parentShowCount", Options, "InterfaceOptionsCheckButtonTemplate")
ShowCount:SetPoint("TOPLEFT", SubText, "BOTTOMLEFT", -2, -8)
ShowCount.Text:SetText(L.ShowCount)
ShowCount:SetScript("OnClick", function(this)
	local checked = not not this:GetChecked()
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainmenuOptionCheckBoxOff")
	BBPT_COUNT = checked
	Addon.EventFrame:PET_JOURNAL_LIST_UPDATE()
end)
Options.ShowCount = ShowCount

local ShowLevel = CreateFrame("CheckButton", "$parentShowLevel", Options, "InterfaceOptionsCheckButtonTemplate")
ShowLevel:SetPoint("TOPLEFT", ShowCount, "BOTTOMLEFT", 0, -8)
ShowLevel.Text:SetText(L.ShowLevel)
ShowLevel:SetScript("OnClick", function(this)
	local checked = not not this:GetChecked()
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainmenuOptionCheckBoxOff")
	BBPT_LEVEL = checked
	Addon.EventFrame:PET_JOURNAL_LIST_UPDATE()
end)
Options.ShowLevel = ShowLevel

local ShowWildQuality = CreateFrame("CheckButton", "$parentShowWildQuality", Options, "InterfaceOptionsCheckButtonTemplate")
ShowWildQuality:SetPoint("TOPLEFT", ShowLevel, "BOTTOMLEFT", 0, -8)
ShowWildQuality.Text:SetText(L.ShowWildQuality)
ShowWildQuality.tooltipText = L.ShowWildQuality_Tooltip
ShowWildQuality:SetScript("OnClick", function(this)
	local checked = not not this:GetChecked()
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainmenuOptionCheckBoxOff")
	BBPT_WILD_QUALITY = checked
end)
Options.ShowWildQuality = ShowWildQuality

Options.refresh = function()
	ShowCount:SetChecked(BBPT_COUNT)
	ShowLevel:SetChecked(BBPT_LEVEL)
	ShowWildQuality:SetChecked(BBPT_WILD_QUALITY)
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