local addon, ns = ...
local C, F, G = unpack(ns)

if not C.IsWarlock then return end
if not( C.Warlock.Enabled and C.Warlock.Macro.Enabled ) then return end

local f = CreateFrame("Frame", addon..C.RealClass.."Macro", UIParent)
local L = LibStub("AceLocale-3.0"):GetLocale(addon)
-- Get Macro config
local conf = C.Warlock.Macro
-- Only to support old code, remove pls, don´t be lazy!!!
local addonname = addon
-- Have a look on InCombatLockdown()
-- https://wowwiki.fandom.com/wiki/API_InCombatLockdown
local inCombat = false
local MINION_GUID

--Cache global variables
--WoW API / Variables
local GetPetActionInfo = GetPetActionInfo
local NUM_PET_ACTION_SLOTS = NUM_PET_ACTION_SLOTS

-- Demon localization
local DEMON_IMP, DEMON_VOIDWALKER, DEMON_SUCCUBUS, DEMON_FELHUNTER, DEMON_FELGUARD, DEMON_INFERNO, DEMON_DOOMGUARD, SOULSHARD =
  DEMON_IMP, DEMON_VOIDWALKER, DEMON_SUCCUBUS, DEMON_FELHUNTER, DEMON_FELGUARD, DEMON_INFERNO, DEMON_DOOMGUARD, SOULSHARD

local function lastChar(str)
    return str:match("[%z\1-\127\194-\244][\128-\191]*$")
end

local function GetDemonMacroName(str)
  local i, j, l, len, tbl, section, rtn, floor, lower = 0, 1, 0, 3, {}, {}, "", math.floor, string.lower

  str = F.killws(str)
  section.first = 1
  section.mid = 2
  section.last = 3

  for c in str:gmatch("[%z\1-\127\194-\244][\128-\191]*") do
    table.insert(tbl, c)
    l=l+1
  end

  if l == len then return lower(str) end
  section.mid = floor(l/2+.5)
  section.last = l

  for _, str in pairs(tbl) do
    if j == section.first or j == section.mid or j == section.last then
      rtn = rtn .. tbl[j]
    end
    j=j+1
  end

  while j<len do
    rtn = rtn .. lastChar(str)
    i=i+1
  end

  return lower(rtn)
end

local function PlaceActionMacro(macroName, slotId)
  if GetActionInfo(slotId) ~= nil then
    PickupAction(slotId)
    ClearCursor()
  end
  PickupMacro(macroName, slotId)
  PlaceAction(slotId)
  -- no macro? try fallback-macro
  if GetActionInfo(slotId) == nil then
    PickupMacro(conf.fallbackMacro .. tostring(slotId))
    PlaceAction(slotId)
  end
end

local function PlaceMinionActionMacro(macroName, slotId)
  if type(slotId) == "number" then slotId = {conf.slotId} end
  if type(slotId) == "table" then
    for k,v in pairs(slotId) do
      PlaceActionMacro(GetDemonMacroName(macroName) .. tostring(v), v)
    end
  end
end

local function PlaceMinionMacro(family)
  if inCombat == true then return end

  if family == DEMON_IMP or
     family == DEMON_VOIDWALKER or
     family == DEMON_SUCCUBUS or
     family == DEMON_FELHUNTER or
     family == DEMON_FELGUARD or
     family == DEMON_INFERNO or
     family == DEMON_DOOMGUARD then
    PlaceMinionActionMacro(string.lower(family), conf.slotId)
  end
end

local function MinionDismissedCallback()
  if inCombat == true then return end

  slotId = conf.slotId
  if type(slotId) == "number" then slotId = {conf.slotId} end
  if type(slotId) == "table" then
    for k,v in pairs(slotId) do
      PickupAction(v)
      ClearCursor()
    end
  end
end

local function ActionbarHasMacro()
  slotId = conf.slotId
  local hasMacro = false
  if type(slotId) == "number" then slotId = {conf.slotId} end
  if type(slotId) == "table" then
    for k,v in pairs(slotId) do
      PickupAction(v)
      macro, index = GetCursorInfo()
      if (macro == "macro") then hasMacro = true end;
      if macro ~= nill then
        PlaceAction(v)
      end
    end
  end
  return hasMacro == true and true or false
end

local function MinionChangedCallback(guid)
  if guid == nil then
    MinionDismissedCallback()
  else
    local family = UnitCreatureFamily("pet")
    PlaceMinionMacro(family);
  end
end

local function EnteringCombatCallback()
  inCombat = true
end

local function LeavingCombatCallback()
  inCombat = false
  MinionChangedCallback(UnitGUID("pet"))
end

F.ShowDemonMacroName = function()
  F.mprint( ""..
    "\n"..L["Macro names for your demons"]..
    "\n".."-----------------------------------------------"..
    "\n"..F.cWhite..L["for"].." "..F.cYellow..DEMON_IMP.." "..F.cWhite..
    L["use"].." "..F.cYellow..(GetDemonMacroName(DEMON_IMP))..
    "\n"..F.cWhite..L["for"].." "..F.cYellow..DEMON_VOIDWALKER.." "..F.cWhite..
    L["use"].." "..F.cYellow..(GetDemonMacroName(DEMON_VOIDWALKER))..
    "\n"..F.cWhite..L["for"].." "..F.cYellow..DEMON_SUCCUBUS.." "..F.cWhite..
    L["use"].." "..F.cYellow..(GetDemonMacroName(DEMON_SUCCUBUS))..
    "\n"..F.cWhite..L["for"].." "..F.cYellow..DEMON_FELHUNTER.." "..F.cWhite..
    L["use"].." "..F.cYellow..(GetDemonMacroName(DEMON_FELHUNTER))..
    "\n"..F.cWhite..L["for"].." "..F.cYellow..DEMON_FELGUARD.." "..F.cWhite..
    L["use"].." "..F.cYellow..(GetDemonMacroName(DEMON_FELGUARD))..
    "\n"..F.cWhite..L["for"].." "..F.cYellow..DEMON_INFERNO.." "..F.cWhite..
    L["use"].." "..F.cYellow..(GetDemonMacroName(DEMON_INFERNO))..
    "\n"..F.cWhite..L["for"].." "..F.cYellow..DEMON_DOOMGUARD.." "..F.cWhite..
    L["use"].." "..F.cYellow..(GetDemonMacroName(DEMON_DOOMGUARD))..
    "\n"..F.cWhite.."-----------------------------------------------"
  )
end

f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterUnitEvent("UNIT_PET", "player")
--f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:RegisterEvent("PLAYER_REGEN_DISABLED")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:SetScript("OnEvent", function(self, event, ...)
    self[event](self, ...)
end)
f:Hide()

function f:UNIT_PET(unit)
  local newGUID = UnitGUID("pet")
  if newGUID ~= MINION_GUID or not ActionbarHasMacro() then
    MinionChangedCallback(newGUID)
    MINION_GUID = newGUID
  end
end

function f:PLAYER_ENTERING_WORLD()
  MINION_GUID = UnitGUID("pet")
  f:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

-- function f:COMBAT_LOG_EVENT_UNFILTERED()
--     --local timestamp, eventType, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId, spellName, spellSchool = CombatLogGetCurrentEventInfo()
--     local _, eventType, _, _, sourceName, _, _, destGUID, destName, _, _, _, _, _ = CombatLogGetCurrentEventInfo()
--
--     if eventType == "UNIT_DIED" then
--         --print("--- " .. eventType)
--         --print('from ' .. tostring(destName))
--         --print('on ' .. tostring(destName))
--         --print(tostring(destGUID))
--         --print(tostring(MINION_GUID))
--         if destGUID == MINION_GUID then
--             MinionDismissedCallback()
--         end
--     end
-- end

function f:PLAYER_REGEN_DISABLED()
  EnteringCombatCallback()
end

function f:PLAYER_REGEN_ENABLED()
  LeavingCombatCallback()
end
