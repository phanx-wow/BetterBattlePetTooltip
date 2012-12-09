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

local L_HIDE_COUNT_ON  = "Collected count hidden."
local L_HIDE_COUNT_OFF = "Collected count shown."

local L_SHOW_LEVEL_ON  = "Highest collected level shown."
local L_SHOW_LEVEL_OFF = "Highest collected level hidden."

------------------------------------------------------------------------

if GetLocale():match("^es") then
	L_HIDE_COUNT = "Ocultar la cantidad recogida"
	L_HIDE_COUNT_ON = "Cantidad recogida está oculta."
	L_HIDE_COUNT_OFF = "Cantidad recogida está mostrada."
	L_SHOW_LEVEL = "Mostrar el mayor nivel recogido"
	L_SHOW_LEVEL_ON = "Mayor nivel está mostrado."
	L_SHOW_LEVEL_OFF = "Mayor nivel está oculto."
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
	BBPT_HideCount = not not this:GetChecked()
end)

local ShowLevel = CreateFrame("CheckButton", "$parentShowLevel", Options, "InterfaceOptionsCheckButtonTemplate")
ShowLevel:SetPoint("TOPLEFT", HideCount, "BOTTOMLEFT", 0, -8)
ShowLevel.Text:SetText(L_SHOW_LEVEL)
ShowLevel:SetScript("OnClick", function(this)
	BBPT_ShowLevel = not not this:GetChecked()
end)

Options.Title = Title
Options.SubText = SubText
Options.HideCount = HideCount
Options.ShowLevel = ShowLevel

-- Options.About = LibStub("LibAboutPanel").new(Options.name, ADDON)

Options.refresh = function()
	HideCount:SetChecked(BBPT_HideCount)
	ShowLevel:SetChecked(BBPT_ShowLevel)
end

SLASH_BBPT1 = "/bbpt"
SlashCmdList.BBPT = function(cmd)
	cmd = cmd and strlower(strtrim(cmd))
	if cmd == "count" then
		BBPT_HideCount = not BBPT_HideCount
		print("|cff88ff88BetterBattlePetTooltip:|r", BBPT_HideCount and L_HIDE_COUNT_ON or L.HIDE_COUNT_OFF)
	elseif cmd == "level" then
		BBPT_ShowLevel = not BBPT_ShowLevel
		print("|cff88ff88BetterBattlePetTooltip:|r", BBPT_ShowLevel and L_SHOW_LEVEL_ON or L_SHOW_LEVEL_OFF)
	else
		-- InterfaceOptionsFrame_OpenToCategory(Options.About)
		InterfaceOptionsFrame_OpenToCategory(Options)
	end
end