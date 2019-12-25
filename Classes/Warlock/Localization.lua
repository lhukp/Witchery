local addon, ns = ...
local C, F, G = unpack(ns)

if not(  C.IsWarlock and C.Warlock.Enabled ) then return end

----------------------------------
-- Version : en
----------------------------------

-- Demons
DEMON_IMP = "Imp"
DEMON_VOIDWALKER = "Voidwalker"
DEMON_SUCCUBUS = "Succubus"
DEMON_FELHUNTER = "Felhunter"
DEMON_FELGUARD = "Felguard"
DEMON_INFERNO = "Inferno"
DEMON_DOOMGUARD = "Doomguard"
-- Stuff
SOULSHARD = "Soulshard"
-- Functions
F_SOULPOUCH = {"Soul Pouch", "Small Soul Pouch", "Box of Souls", "Felcloth Bag", "Ebon Shadowbag", "Core Felcloth Bag", "Abyssal Bag"}

----------------------------------
-- Version : zhCN
----------------------------------

if ( GetLocale() == "zhCN" ) then
    -- Demons
    DEMON_IMP = "小鬼"
    DEMON_VOIDWALKER = "虚空行者"
    DEMON_SUCCUBUS = "魅魔"
    DEMON_FELHUNTER = "地狱猎犬"
    DEMON_FELGUARD = "地狱火"
    DEMON_INFERNO = "末日守卫"
    DEMON_DOOMGUARD = "厄运守卫"
    -- Stuff
    SOULSHARD = "灵魂碎片"
    -- Functions
    F_SOULPOUCH = {"灵魂袋", "恶魔布包", "熔火恶魔布包"}
end

----------------------------------
-- Version : deDE
----------------------------------

if ( GetLocale() == "deDE" ) then
    -- Demons
    DEMON_IMP = "Wichtel"
    DEMON_VOIDWALKER = "Leerwandler"
    DEMON_SUCCUBUS = "Sukkubus"
    DEMON_FELHUNTER = "Teufelsj\195\164ger"
    DEMON_FELGUARD = "Teufelswache"
    DEMON_INFERNO = "H\195\182llenbestie"
    DEMON_DOOMGUARD = "Verdammniswache"
    -- Stuff
    SOULSHARD = "Seelensplitter"
    -- Functions
    F_SOULPOUCH = {"Kleiner Seelenbeutel", "Seelenkasten", "Seelenbeutel", "Teufelsstofftasche", "Abgr\195\188ndige Tasche", "Kernteufelsstofftasche", "Schwarzschattentasche"}
end

----------------------------------
-- Version : esES, esMX
----------------------------------

if ( GetLocale() == "esES" ) or ( GetLocale() == "esMX" ) then
    -- Demons
    DEMON_IMP = "Diablillo"
    DEMON_VOIDWALKER = "Abisario"
    DEMON_SUCCUBUS = "S\195\186cubo"
    DEMON_FELHUNTER = "Man\195\161fago"
    DEMON_FELGUARD = "Guardia maldito"
    DEMON_INFERNO = "Inferno"
    DEMON_DOOMGUARD = "Guardia apocal\195\173ptico"
    -- Stuff
    SOULSHARD = "Fragmento de Alma"
    -- Functions
    F_SOULPOUCH = {"Faltriquera de almas", "Faltriquera de almas", "Caja de almas", "Bolsa de tela vil", "Bolsa de tela vil del N\195\186cleo", "Bolsa abisal", "Bolsa de las Sombras de \195\169bano"}
end

----------------------------------
-- Version : frFR
----------------------------------

if ( GetLocale() == "frFR" ) then
    -- Demons
    DEMON_IMP = "Diablotin"
    DEMON_VOIDWALKER = "Marcheur du Vide"
    DEMON_SUCCUBUS = "Succube"
    DEMON_FELHUNTER = "Chasseur corrompu"
    DEMON_FELGUARD = "Gangregarde"
    DEMON_INFERNO = "Infernal"
    DEMON_DOOMGUARD = "Garde funeste"
    -- Stuff
    SOULSHARD = "Fragment d'\195\162me"
    -- Functions
    F_SOULPOUCH = {"Bourse d'\195\162me", "Bourse d'\195\162me", "Bo\195\174te d'\192\162mes", "Sac en gangr\195\169toffe", "Sac en gangr\195\169toffe du Magma", "Sac abyssal", "Ombresac d'\195\169b\195\168ne"}
end

----------------------------------
-- Version : ruRU
----------------------------------

if ( GetLocale() == "ruRU" ) then
    -- Demons
    DEMON_IMP = "Бес"
    DEMON_VOIDWALKER = "Демон Бездны"
    DEMON_SUCCUBUS = "Суккуба"
    DEMON_FELHUNTER = "Охотник Скверны"
    DEMON_FELGUARD = "Страж Скверны"
    DEMON_INFERNO = "Инферно"
    DEMON_DOOMGUARD = "Привратник Скверны"
    -- Stuff
    SOULSHARD = "Осколок души"
    -- Functions
    F_SOULPOUCH = {"Мешок душ", "Сума душ", "Коробка душ", "Сумка из ткани Скверны", "Черная сумка теней", "Сумка Бездны", "Черная сумка теней", "Сумка из сердцевинной ткани Скверны"}
end

----------------------------------
-- Version : zhTW
----------------------------------

if ( GetLocale() == "zhTW" ) then
    -- Demons
    DEMON_IMP = "小鬼"
    DEMON_VOIDWALKER = "虛無行者"
    DEMON_SUCCUBUS = "魅魔"
    DEMON_FELHUNTER = "惡魔獵犬"
    DEMON_FELGUARD = "惡魔守衛"
    DEMON_INFERNO = "地獄火"
    DEMON_DOOMGUARD = "末日守衛"
    -- Stuff
    SOULSHARD = "靈魂裂片"
    -- Functions
    F_SOULPOUCH = {"靈魂袋", "惡魔布包", "熔火惡魔布包"}
end
