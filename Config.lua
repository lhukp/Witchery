local addon, ns = ...
local C, F, G = unpack(ns)

--[[
None = 0
Warrior = 1
Paladin = 2
Hunter = 3
Rogue = 4
Priest = 5
DeathKnight = 6
Shaman = 7
Mage = 8
Warlock = 9
Monk = 10
Druid = 11
Demon Hunter = 12
]]
local localizedClass, englishClass, classIndex = UnitClass("player");

G.caF = "|cff00FFFF%s|r"
G.Ccolors = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[englishClass] -- Class color

C.LocalizedClass = localizedClass
C.EnglishClass = englishClass
C.ClassIndex = classIndex

C.IsWarrior = C.ClassIndex == 1 and true or false
C.IsPaladin = C.ClassIndex == 2 and true or false
C.IsHunter = C.ClassIndex == 3 and true or false
C.IsRogue = C.ClassIndex == 4 and true or false
C.IsPriest = C.ClassIndex == 5 and true or false
C.IsShaman = C.ClassIndex == 7 and true or false
C.IsMage = C.ClassIndex == 8 and true or false
C.IsWarlock = C.ClassIndex == 9 and true or false
C.IsDruid = C.ClassIndex == 11 and true or false

F.strTab = "    "

F.cWhite = "|cffffffff"
F.cYellow = "|cffffff00"
F.cGreen = "|cff00ff00"
F.cClass = F.hex(G.Ccolors)
F.cAddon = "|cff00ffff"

F.eoc = "|r"
