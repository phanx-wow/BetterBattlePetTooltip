--[[--------------------------------------------------------------------
	BetterBattlePetTooltip
	Copyright (c) 2012-2014 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info21978-BetterBattlePetTooltip.html
	http://www.curse.com/addons/wow/betterbattlepettooltip
	https://github.com/Phanx/BetterBattlePetTooltip
----------------------------------------------------------------------]]
-- Add or update translations here:
-- http://wow.curseforge.com/addons/betterbattlepettooltip/localization/

local ADDON, private = ...
local L = {}
private.L = L

L.AlreadyBattled = "Already Battled%s%s"
L.ColorTooltipBorder = "Color tooltip borders"
L.ColorTooltipBorder_Tooltip = "You may want to disable this if you use another addon to style your tooltip borders."
L.NotCapturable = "Not Capturable"
L.ShowAll = "Show all collected pets"
L.ShowAll_Tooltip = "This will show all your collected pets of the same species, not just the best one."
L.ShowBreed = "Show collected breed"
L.ShowBreed_Tooltip = "This option requires LibPetBreedInfo-1.0 to be installed."
L.ShowCount = "Show collected count"
L.ShowLevel = "Show collected level"
L.ShowWildQuality = "Show wild pet rarity when possible"
L.ShowWildQuality_Tooltip = "This is only possible if you already entered a battle with the pet and forfeited, and only works for unit tooltips, not minimap tracking tooltips."

local LOCALE = GetLocale()
if strmatch(LOCALE, "^en") then return end

------------------------------------------------------------------------
--	German
--	Contributors: CanRanBan, DirtyHarryGermany
-- Last updated: 2014 Aug 24
------------------------------------------------------------------------
if LOCALE == "deDE" then

L.AlreadyBattled = "Bereits bekämpft%s%s"
L.ColorTooltipBorder = "Tooltipsränder einfärben"
L.ColorTooltipBorder_Tooltip = "Vielleicht möchtet Ihr diese Option deaktivieren, wenn Ihr ein weiteres Addon verwendet, die Tooltipsränder zu stilisieren."
L.NotCapturable = "Nicht einfangbar"
L.ShowAll = "Zeige alle eingefangenen Haustiere"
L.ShowAll_Tooltip = "Mit dieser Option werden alle eingefangenen Haustiere der gleichen Art gezeigt, anstatt nur des besten."
L.ShowBreed = "Zeige die eingefangene Rasse"
L.ShowBreed_Tooltip = "Für dieser Option muss LibPetBreedInfo-1.0 installiert sein."
L.ShowCount = "Zeige die eingefangene Anzahl"
L.ShowLevel = "Zeige die höchste eingefangene Stufe"
L.ShowWildQuality = "Zeige wenn möglich die Qualität des wilden Haustiers"
L.ShowWildQuality_Tooltip = "Dies ist nur möglich, wenn du das Haustier bereits bekämpft und aufgegeben in dieser Sitzung hast, und funktioniert nur für Einheiten-Tooltips, nicht für Minimap-Tooltips."

------------------------------------------------------------------------
--	Spanish
------------------------------------------------------------------------
elseif LOCALE:match("^es") then

L.AlreadyBattled = "Ya luchado%s%s"
L.ColorTooltipBorder = "Colorear los bordes de los descriptiones"
L.ColorTooltipBorder_Tooltip = "Quizás deseas desactivar esta opción si utilizas otro addon para estilizar los bordes de los descriptiones."
L.NotCapturable = "No se puede capturar"
L.ShowAll = "Mostrar todas mascotas capturadas"
L.ShowAll_Tooltip = "Con esta opción se muestran todas las mascotas capturadas de la misma raza, en vez de solamente la mejor."
L.ShowBreed = "Mostrar la raza capturada"
L.ShowBreed_Tooltip = "Esta opción require que está instalado LibPetBreedInfo-1.0."
L.ShowCount = "Mostrar la cantidad capturada"
L.ShowLevel = "Mostrar el mayor nivel capturado"
L.ShowWildQuality = "Mostrar la calidad de las mascotas salvajes cuando posible"
L.ShowWildQuality_Tooltip = "Esto sólo es posible si ya abandonó un duelo con la mascota exacta, y sólo para las descripciones de las unidades, no para las descripciones de seguimiento en el minimapa."

------------------------------------------------------------------------
--	French
--	Contributors: oXid_FoX
------------------------------------------------------------------------
elseif LOCALE == "frFR" then

L.AlreadyBattled = "Déjà combattu%s%s"
L.CollectedLevel = "Niveau %d"
L.NotCapturable = "Capture impossible"
L.ShowCount = "Afficher le nombre capturé"
L.ShowLevel = "Afficher le plus haut niveau capturé"
L.ShowWildQuality = "Afficher la qualité des mascottes sauvages si possible"
L.ShowWildQuality_Tooltip = "Ce n'est possible que si vous avez déjà abandonné un combat avec la mascotte, et ne fonctionne que pour les infobulles des unités, pas les infobulles sur la minicarte."

------------------------------------------------------------------------
--	Italian
------------------------------------------------------------------------
elseif LOCALE == "itIT" then

L.AlreadyBattled = "Già combattuto%s%s"
L.CollectedLevel = "Livello %d"
L.ColorTooltipBorder = "Colorare i bordi di informazioni"
L.ColorTooltipBorder_Tooltip = "Potete desiderare attivare questa opzione se si utilizza un altro addon per lo stile dei bordi di informazioni."
L.NotCapturable = "Non catturabile"
L.ShowCount = "Mostrare la quantità catturato"
L.ShowLevel = "Mostrare il livello più alto catturato"
L.ShowWildQuality = "Mostrare la qualità della mascotte selvatici, quando possibile"
L.ShowWildQuality_Tooltip = "Questo è possibile solo se si è già arreso in un duello contro la mascotte specifico, e solo per le informazioni delle unità, non per le informazioni del tracciamento sulla minimappa."

------------------------------------------------------------------------
--	Portuguese
-- Contributors: Tericoo
-- Last updated: 2015 Jan 3
------------------------------------------------------------------------
elseif LOCALE:match("^pt") then

L.AlreadyBattled = "Já luto%s%s"
L.ColorTooltipBorder = "Cor da borda do tooltip"
L.ColorTooltipBorder_Tooltip = "Talvez você deseje desativar caso use outro addon para mudar a aparência do tooltip."
L.NotCapturable = "Não capturável"
L.ShowCount = "Mostrar a quantidade capturado"
L.ShowLevel = "Mostrar a mais alto nível capturado"
L.ShowWildQuality = "Mostrar a qualidade de mascotes selvagens quando possível"
L.ShowWildQuality_Tooltip = "Apenas é possível se você já entrou em uma batalha com este mascote e perdeu, e, apenas funciona para tooltips de unidades não nos ícones do mini mapa."

------------------------------------------------------------------------
--	Russian
--	Contributors: Wetxius, Yafis
-- Last updated: 2014 Aug 18
------------------------------------------------------------------------
elseif LOCALE == "ruRU" then

L.AlreadyBattled = "Уже сражался%s%s"
L.ColorTooltipBorder = "Цвет границ подсказки"
L.ColorTooltipBorder_Tooltip = "Вы можете отключить это если используете другой аддон на Tooltip"
L.NotCapturable = "Не приручается"
L.ShowCount = "Отображать количество, которое вы поймали"
L.ShowLevel = "Отображать наивысший уровень для пойманных"
L.ShowWildQuality = "Отображать качество дикого питомца, если возможно"
L.ShowWildQuality_Tooltip = "Это возможно, если вы уже вступали в бой с питомцем и отступили. Работает только для подсказки цели, на миникарте не работает."

------------------------------------------------------------------------
--	Korean
------------------------------------------------------------------------
elseif LOCALE == "koKR" then

-- No translations yet. :(

------------------------------------------------------------------------
--	Simplified Chinese
------------------------------------------------------------------------
elseif LOCALE == "zhCN" then

-- No translations yet. :(

------------------------------------------------------------------------
--	Traditional Chinese
-- Last updated: 2014 Aug 19
------------------------------------------------------------------------
elseif LOCALE == "zhTW" then

-- No translations yet. :(

end