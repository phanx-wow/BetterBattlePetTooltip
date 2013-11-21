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
L.PetString = "%s"								-- COLLECTED|NOT_COLLECTED
L.PetStringCount = "%s/%s %s"					-- count, maxCount, COLLECTED
L.PetStringCountLevel = "%s/%s %s (Level %d)"	-- count, maxCount, COLLECTED, level
L.PetStringLevel = "%s (Level %d)"				-- COLLECTED, level
L.ShowCount = "Show collected count"
L.ShowLevel = "Show highest collected level"
L.ShowWildQuality = "Show wild pet rarity when possible"
L.ShowWildQuality_Tooltip = "This is only possible if you already entered a battle with the pet and forfeited, and only works for unit tooltips, not minimap tracking tooltips."

local LOCALE = GetLocale()
if strmatch(LOCALE, "^en") then return end

------------------------------------------------------------------------
--	German
--	Contributors: CanRanBan
------------------------------------------------------------------------
if LOCALE == "deDE" then
	L.AlreadyBattled = "Bereits bekämpft%s%s"
	L.NotCapturable = "Nicht einfangbar"
	--L.Parentheses = " (%s)"
	--L.PetString = "%s"
	--L.PetStringCount = "%s/%s %s"
	L.PetStringCountLevel = "%s/%s %s (Stufe %d)"
	L.PetStringLevel = "%s (Stufe %d)"
	L.ShowCount = "Zeige eingefangene Anzahl"
	L.ShowLevel = "Zeige höchste eingefangene Stufe"
	L.ShowWildQuality = "Zeige Qualität des wilden Haustiers, wenn möglich"
	L.ShowWildQuality_Tooltip = "Dies ist nur möglich, wenn du das Haustier bereits bekämpft und aufgegeben hast, und funktioniert nur für Einheiten-Tooltips, nicht für Minimap-Tooltips."

------------------------------------------------------------------------
--	Spanish
------------------------------------------------------------------------
elseif LOCALE:match("^es") then
	L.AlreadyBattled = "Ya luchado%s%s"
	L.NotCapturable = "No se puede capturar"
	--L.Parentheses = " (%s)"
	--L.PetString = "%s"
	--L.PetStringCount = "%s/%s %s"
	L.PetStringCountLevel = "%s/%s %s (Nivel %d)"
	L.PetStringLevel = "%s (Nivel %d)"
	L.ShowCount = "Mostrar la cantidad capturado"
	L.ShowLevel = "Mostrar el mayor nivel capturado"
	L.ShowWildQuality = "Mostrar la calidad de las mascotas salvajes cuando posible"
	L.ShowWildQuality_Tooltip = "Esto sólo es posible si ya abandonó un duelo con la mascota exacta, y sólo para las descripciones de las unidades, no para las descripciones de seguimiento en el minimapa."

------------------------------------------------------------------------
--	French
--	Contributors: oXid_FoX
------------------------------------------------------------------------
elseif LOCALE == "frFR" then
	L.AlreadyBattled = "Déjà combattu%s%s"
	L.NotCapturable = "Capture impossible"
	--L.Parentheses = " (%s)"
	--L.PetString = "%s"
	--L.PetStringCount = "%s/%s %s"
	L.PetStringCountLevel = "%s/%s %s (Niveau %d)"
	L.PetStringLevel = "%s (Niveau %d)"
	L.ShowCount = "Afficher le nombre capturé"
	L.ShowLevel = "Afficher le plus haut niveau capturé"
	L.ShowWildQuality = "Afficher la qualité des mascottes sauvages si possible"
	L.ShowWildQuality_Tooltip = "Ce n'est possible que si vous avez déjà abandonné un combat avec la mascotte, et ne fonctionne que pour les infobulles des unités, pas les infobulles sur la minicarte."

------------------------------------------------------------------------
--	Italian
------------------------------------------------------------------------
elseif LOCALE == "itIT" then
	L.AlreadyBattled = "Già combattuto%s%s"
	L.NotCapturable = "Non catturabile"
	--L.Parentheses = " (%s)"
	--L.PetString = "%s"
	--L.PetStringCount = "%s/%s %s"
	L.PetStringCountLevel = "%s/%s %s (Livello %d)"
	L.PetStringLevel = "%s (Livello %d)"
	L.ShowCount = "Mostrare la quantità catturato"
	L.ShowLevel = "Mostrare il livello più alto catturato"
	L.ShowWildQuality = "Mostrare la qualità della mascotte selvatici quando possibile"
	--L.ShowWildQuality_Tooltip = ""

------------------------------------------------------------------------
--	Portuguese
------------------------------------------------------------------------
elseif LOCALE:match("^pt") then
	L.AlreadyBattled = "Já luto%s%s"
	L.NotCapturable = "Não capturável"
	--L.Parentheses = " (%s)"
	--L.PetString = "%s"
	--L.PetStringCount = "%s/%s %s"
	L.PetStringCountLevel = "%s/%s %s (Nível %d)"
	L.PetStringLevel = "%s (Nível %d)"
	L.ShowCount = "Mostrar a quantidade capturado"
	L.ShowLevel = "Mostrar a mais alto nível capturado"
	L.ShowWildQuality = "Mostrar a qualidade de mascotes selvagens quando possível"
	--L.ShowWildQuality_Tooltip = ""

------------------------------------------------------------------------
--	Russian
--	Contributors: Wetxius
------------------------------------------------------------------------
elseif LOCALE == "ruRU" then
	L.AlreadyBattled = "Уже сражался%s%s"
	L.NotCapturable = "Не приручается"
	-- L.Parentheses = " (%s)"
	-- L.PetString = "%s"
	-- L.PetStringCount = "%s/%s %s"
	L.PetStringCountLevel = "%s/%s %s (%d-й уровень)"
	L.PetStringLevel = "%s (%d-й уровень)"
	L.ShowCount = "Отображать количество, которое вы поймали"
	L.ShowLevel = "Отображать наивысший уровень для пойманных"
	L.ShowWildQuality = "Отображать качество дикого питомца, если возможно"
	L.ShowWildQuality_Tooltip = "Это возможно, если вы уже вступали в бой с питомцем и отступили. Работает только для подсказки цели, на миникарте не работает."

------------------------------------------------------------------------
--	Korean
------------------------------------------------------------------------
elseif LOCALE == "koKR" then
	--L.AlreadyBattled = ""
	--L.NotCapturable = ""
	--L.Parentheses = " (%s)"
	--L.PetString = "%s"
	--L.PetStringCount = "%s/%s %s"
	L.PetStringCountLevel = "%s/%s %s (%d 레벨)"
	L.PetStringLevel = "%s (%d 레벨)"
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
	--L.PetString = "%s"
	L.PetStringCount = "%s/%s%s"
	L.PetStringCountLevel = "%s/%s%s（等级%d）"
	L.PetStringLevel = "%s（等级%d）"
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
	--L.PetString = "%s"
	L.PetStringCount = "%s/%s%s"
	L.PetStringCountLevel = "%s/%s%s(等級%d)"
	L.PetStringLevel = "%s(等級%d)"
	--L.ShowCount = ""
	--L.ShowLevel = ""
	--L.ShowWildQuality = ""
	--L.ShowWildQuality_Tooltip = ""

end