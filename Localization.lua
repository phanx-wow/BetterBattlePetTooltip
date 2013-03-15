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

L.AlreadyBattled = "Already Battled%s%s"
L.NotCapturable = "Not Capturable"
L.Parentheses = " (%s)"
L.PetString = "%s%s%s|r"                        -- color, COLLECTED|NOT_COLLECTED, colorblindText
L.PetStringCount = "%s%s/%s %s%s|r"             -- color, count, maxCount, COLLECTED, colorblindText
L.PetStringCountLevel = "%s%s/%s %s (Level %d%s)|r"  -- color, count, maxCount, COLLECTED, level, colorblindText
L.PetStringLevel = "%s%s (Level %d)%s|r"             -- color, COLLECTED, level, colorblindText
L.ShowCount = "Show collected count"
L.ShowLevel = "Show highest collected level"
L.ShowWildQuality = "Show wild pet rarity when possible"
L.ShowWildQuality_Tooltip = "This is only possible if you already entered a battle with the pet and forfeited, and only works for unit tooltips, not minimap tracking tooltips."

local LOCALE = GetLocale()
if strmatch(LOCALE, "^en") then return end

------------------------------------------------------------------------
--	German
------------------------------------------------------------------------
if LOCALE == "deDE" then
	L.AlreadyBattled = "Bereits kämpften%s%s"
	L.NotCapturable = "Nicht abfangbar"
	--L.Parentheses = " (%s)"
	--L.PetString = "%s%s%s|r"
	--L.PetStringCount = "%s%s/%s %s%s|r"
	L.PetStringCountLevel = "%s%s/%s %s: @ S%d%s|r"
	L.PetStringLevel = "%s%s: S%d%s|r"
	L.ShowCount = "Zeigt die Menge, die Ihr habt gefangen"
	L.ShowLevel = "Zeigt die höchste Stufe, die Ihr habt gefangen"
	L.ShowWildQuality = "Qualität der wilden Kampftieren anzeigen, wenn möglich ist"
	--L.ShowWildQuality_Tooltip = ""

------------------------------------------------------------------------
--	Spanish
------------------------------------------------------------------------
elseif LOCALE:match("^es") then
	L.AlreadyBattled = "Ya luchado%s%s"
	L.NotCapturable = "No se puede capturar"
	--L.Parentheses = " (%s)"
	--L.PetString = "%s%s%s|r"
	--L.PetStringCount = "%s%s/%s %s%s|r"
	L.PetStringCountLevel = "%s%s/%s %s: N%d%s|r"
	L.PetStringLevel = "%s%s: N%d%s|r"
	L.ShowCount = "Mostrar la cantidad que ha capturado"
	L.ShowLevel = "Mostrar el mayor nivel que ha capturado"
	L.ShowWildQuality = "Mostrar la calidad de las mascotas salvajes cuando posible"
	L.ShowWildQuality_Tooltip = "Esto sólo es posible si ya ha entrado en y abandonó un duelo con la mascota exacta, y sólo para las descripciones de las unidades, no para las descripciones de seguimiento en el minimapa."

------------------------------------------------------------------------
--	French
------------------------------------------------------------------------
elseif LOCALE == "frFR" then
	L.AlreadyBattled = "Déjà battu%s%s"
	L.NotCapturable = "Capture impossible"
	--L.Parentheses = " (%s)"
	--L.PetString = "%s%s%s|r"
	--L.PetStringCount = "%s%s/%s %s%s|r"
	L.PetStringCountLevel = "%s%s/%s %s: N%d%s|r"
	L.PetStringLevel = "%s%s: N%d%s|r"
	L.ShowCount = "Afficher le montant qui a capturé"
	L.ShowLevel = "Afficher le plus haut niveau qui a capturé"
	L.ShowWildQuality = "Afficer la qualité des mascottes sauvages si possible"
	--L.ShowWildQuality_Tooltip = ""

------------------------------------------------------------------------
--	Italian
------------------------------------------------------------------------
elseif LOCALE == "itIT" then
	L.AlreadyBattled = "Già combattuto%s%s"
	L.NotCapturable = "Non catturabile"
	--L.Parentheses = " (%s)"
	--L.PetString = "%s%s%s|r"
	--L.PetStringCount = "%s%s/%s %s%s|r"
	L.PetStringCountLevel = "%s%s/%s %s: L%d%s|r"
	L.PetStringLevel = "%s%s: L%d%s|r"
	L.ShowCount = "Mostrare la quantità che ha catturato"
	L.ShowLevel = "Mostrare il livello più alto che hai catturato"
	L.ShowWildQuality = "Mostrare la qualità della mascotte selvatici quando possibile"
	--L.ShowWildQuality_Tooltip = ""

------------------------------------------------------------------------
--	Portuguese
------------------------------------------------------------------------
elseif LOCALE:match("^pt") then
	L.AlreadyBattled = "Já luto%s%s"
	L.NotCapturable = "Não capturável"
	--L.Parentheses = " (%s)"
	--L.PetString = "%s%s%s|r"
	--L.PetStringCount = "%s%s/%s %s%s|r"
	L.PetStringCountLevel = "%s%s/%s %s: N%d%s|r"
	L.PetStringLevel = "%s%s: N%d%s|r"
	L.ShowCount = "Mostrar a quantidade que tem capturado"
	L.ShowLevel = "Mostrar a mais alto nível que tem capturado"
	L.ShowWildQuality = "Mostrar a qualidade de mascotes selvagens quando possível"
	--L.ShowWildQuality_Tooltip = ""

------------------------------------------------------------------------
--	Russian
------------------------------------------------------------------------
elseif LOCALE == "ruRU" then
	L.AlreadyBattled = "Уже сражался%s%s"
	L.NotCapturable = "Не может приручить"
	--L.Parentheses = " (%s)"
	--L.PetString = "%s%s%s|r"
	--L.PetStringCount = "%s%s/%s %s%s|r"
	L.PetStringCountLevel = "%s%s/%s %s: у%d%s|r"
	L.PetStringLevel = "%s%s: у%d%s|r"
	L.ShowCount = "Отображать количество, которое вы поймали"
	L.ShowLevel = "Отображать высшее уровень, которое вы поймали"
	L.ShowWildQuality = "Отображать качество дикий боевой питомца, щхен возможно"
	--L.ShowWildQuality_Tooltip = ""

------------------------------------------------------------------------
--	Korean
------------------------------------------------------------------------
elseif LOCALE == "koKR" then
	--L.AlreadyBattled = ""
	--L.NotCapturable = ""
	L.Parentheses = "(%s)"
	--L.PetString = "%s%s%s|r"
	L.PetStringCount = "%s%s/%s%s%s|r"
	L.PetStringCountLevel = "%s%s/%s%s: %d레벨%s|r"
	L.PetStringLevel = "%s%s: %d레벨%s|r"
	--L.ShowCount = ""
	--L.ShowLevel = ""
	--L.ShowWildQuality = ""
	--L.ShowWildQuality_Tooltip = ""

------------------------------------------------------------------------
--	Simplified Chinese
------------------------------------------------------------------------
elseif LOCALE == "zhCN" then
	--L.AlreadyBattled = ""
	--L.NotCapturable = ""
	L.Parentheses = "（%s）"
	--L.PetString = "%s%s%s|r"
	L.PetStringCount = "%s%s：%s/%s%s|r"
	L.PetStringCountLevel = "%s%s：%s/%s 等级%d%s|r"
	--L.ShowCount = ""
	--L.ShowLevel = ""
	--L.ShowWildQuality = ""
	--L.ShowWildQuality_Tooltip = ""

------------------------------------------------------------------------
--	Traditional Chinese
------------------------------------------------------------------------
elseif LOCALE == "zhTW" then
	--L.AlreadyBattled = ""
	--L.NotCapturable = ""
	L.Parentheses = "(%s)"
	--L.PetString = "%s%s%s|r"
	L.PetStringCount = "%s%s:%s/%s%s|r"
	L.PetStringCountLevel = "%s%s:%s/%s 等級%d%s|r"
	--L.ShowCount = ""
	--L.ShowLevel = ""
	--L.ShowWildQuality = ""
	--L.ShowWildQuality_Tooltip = ""

end