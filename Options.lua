--[[--------------------------------------------------------------------
	BetterBattlePetTooltip
	A World of Warcraft user interface addon
	Copyright (c) 2012 Akkorian, Phanx

	This addon is freely available, and its source code freely viewable,
	but it is not "open source software" and you may not distribute it,
	with or without modifications, without permission from its author.

	See the included README and LICENSE files for more information!
----------------------------------------------------------------------]]

local ADDON = ...

local L_HIDE_COUNT = "Hide collected count"
local L_SHOW_LEVEL = "Show highest collected level"

------------------------------------------------------------------------

if GetLocale():match("^es") then
	L_HIDE_COUNT = "Ocultar la cantidad recogida"
	L_SHOW_LEVEL = "Mostrar el mayor nivel recogido"
end

------------------------------------------------------------------------

local Options = CreateFrame("Frame", "BBPTOptions", InterfaceOptionsFramePanelContainer)
Options.name = GetAddOnMetadata(ADDON, "Title") or ADDON
InterfaceOptions_AddCategory(Options)

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

local HideCount = CreateFrame("CheckButton", "$parentHideCount", Options, "InterfaceOptionsCheckButtonTemplate")
HideCount:SetPoint("TOPLEFT", SubText, "BOTTOMLEFT", -2, -8)
HideCount.Text:SetText(L_HIDE_COUNT)
HideCount:SetScript("OnClick", function(this)
	local checked = not not this:GetChecked()
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainmenuOptionCheckBoxOff")
	BBPT_HideCount = checked
end)

local ShowLevel = CreateFrame("CheckButton", "$parentShowLevel", Options, "InterfaceOptionsCheckButtonTemplate")
ShowLevel:SetPoint("TOPLEFT", HideCount, "BOTTOMLEFT", 0, -8)
ShowLevel.Text:SetText(L_SHOW_LEVEL)
ShowLevel:SetScript("OnClick", function(this)
	local checked = not not this:GetChecked()
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainmenuOptionCheckBoxOff")
	BBPT_ShowLevel = checked
end)

Options.Title = Title
Options.SubText = SubText
Options.HideCount = HideCount
Options.ShowLevel = ShowLevel

Options.refresh = function()
	HideCount:SetChecked(BBPT_HideCount)
	ShowLevel:SetChecked(BBPT_ShowLevel)
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