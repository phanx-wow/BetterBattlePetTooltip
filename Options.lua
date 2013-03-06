--[[--------------------------------------------------------------------
	BetterBattlePetTooltip
	A World of Warcraft user interface addon
	Copyright (c) 2012-2013 A. Kinley (Phanx)

	This addon is freely available, and its source code freely viewable,
	but it is not "open source software" and you may not distribute it,
	with or without modifications, without permission from its author.

	See the included README and LICENSE files for more information!
----------------------------------------------------------------------]]

local ADDON = ...

local L_ShowCount = "Hide collected count"
local L_ShowLevel = "Show highest collected level"

if GetLocale() == "deDE" then
	L_ShowCount = "Zeigt die Menge, die Ihr habt gefangen"
	L_ShowLevel = "Zeigt die höchste Stufe, die Ihr habt gefangen"

elseif GetLocale():match("^es") then
	L_ShowCount = "Mostrar la cantidad que ha capturado"
	L_ShowLevel = "Mostrar el mayor nivel que ha capturado"

elseif GetLocale() == "frFR" then
	L_ShowCount = "Afficher le montant qui a capturé"
	L_ShowLevel = "Afficher le plus haut niveau qui a capturé"

elseif GetLocale() == "itIT" then
	L_ShowCount = "Mostrare la quantità che ha catturato"
	L_ShowLevel = "Mostrare il livello più alto che hai catturato"

elseif GetLocale():match("^pt") then
	L_ShowCount = "Mostrar a quantidade que tem capturado"
	L_ShowLevel = "Mostrar mais alto nível que tem capturado"

elseif GetLocale() == "ruRU" then
	L_ShowCount = "Отображать количество, которое вы поймали"
	L_ShowLevel = "Отображать высшее уровень, которое вы поймали"
end

------------------------------------------------------------------------

local Options = CreateFrame("Frame", "BBPTOptions", InterfaceOptionsFramePanelContainer)
Options.name = GetAddOnMetadata(ADDON, "Title") or ADDON
InterfaceOptions_AddCategory(Options)

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
ShowCount.Text:SetText(L_ShowCount)
ShowCount:SetScript("OnClick", function(this)
	local checked = not not this:GetChecked()
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainmenuOptionCheckBoxOff")
	BBPT_COUNT = checked
end)
Options.ShowCount = ShowCount

local ShowLevel = CreateFrame("CheckButton", "$parentShowLevel", Options, "InterfaceOptionsCheckButtonTemplate")
ShowLevel:SetPoint("TOPLEFT", ShowCount, "BOTTOMLEFT", 0, -8)
ShowLevel.Text:SetText(L_ShowLevel)
ShowLevel:SetScript("OnClick", function(this)
	local checked = not not this:GetChecked()
	PlaySound(checked and "igMainMenuOptionCheckBoxOn" or "igMainmenuOptionCheckBoxOff")
	BBPT_LEVEL = checked
end)
Options.ShowLevel = ShowLevel

Options.refresh = function()
	ShowCount:SetChecked(BBPT_COUNT)
	ShowLevel:SetChecked(BBPT_LEVEL)
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