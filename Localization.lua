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
local L = {}
private.L = L

L.AlreadyBattled = "Already Battled (%s%s|r)"
L.NotCapturable = "Not Capturable"
L.ShowCount = "Show collected count"
L.ShowLevel = "Show highest collected level"
L.ShowWildQuality = "Show wild pet rarity when possible"
L.ShowWildQuality_Tooltip = "This is only possible if you already entered a battle with the pet and forfeited, and only works for unit tooltips, not minimap tracking tooltips."

local LOCALE = GetLocale()
if LOCALE == "deDE" then
	L.AlreadyBattled = "Bereits kämpften (%s%s|r)"
	L.NotCapturable = "Nicht abfangbar"
	L.ShowCount = "Zeigt die Menge, die Ihr habt gefangen"
	L.ShowLevel = "Zeigt die höchste Stufe, die Ihr habt gefangen"

elseif LOCALE:match("^es") then
	L.AlreadyBattled = "Ya luchado (%s%s|r)"
	L.NotCapturable = "No se puede capturar"
	L.ShowCount = "Mostrar la cantidad que ha capturado"
	L.ShowLevel = "Mostrar el mayor nivel que ha capturado"

elseif LOCALE == "frFR" then
	L.AlreadyBattled = "Déjà battu (%s%s|r)"
	L.NotCapturable = "Capture impossible"
	L.ShowCount = "Afficher le montant qui a capturé"
	L.ShowLevel = "Afficher le plus haut niveau qui a capturé"

elseif LOCALE == "itIT" then
	L.AlreadyBattled = "Già combattuto (%s%s|r)"
	L.NotCapturable = "Non catturabile"
	L.ShowCount = "Mostrare la quantità che ha catturato"
	L.ShowLevel = "Mostrare il livello più alto che hai catturato"

elseif LOCALE:match("^pt") then
	L.AlreadyBattled = "Já lutou (%s%s|r)"
	L.NotCapturable = "Não capturável"
	L.ShowCount = "Mostrar a quantidade que tem capturado"
	L.ShowLevel = "Mostrar mais alto nível que tem capturado"

elseif LOCALE == "ruRU" then
	L.ShowCount = "Отображать количество, которое вы поймали"
	L.ShowLevel = "Отображать высшее уровень, которое вы поймали"

end
LOCALE = nil