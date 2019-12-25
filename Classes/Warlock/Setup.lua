local addon, ns = ...
local C, F, G = unpack(ns)

if not C.IsWarlock then return end

C.Warlock = {}
-- Enables the warlock module
C.Warlock.Enabled = true
-- Enables warlock: soulshard
C.Warlock.Soulshard = {}
C.Warlock.Soulshard.Enabled = true
-- Enables warlock: macro
C.Warlock.Macro = {}
C.Warlock.Macro.Enabled = true

-- SlotId that holds the pet macro/s
-- This could be either a number, if you want to place 1 macro, or a table to
-- place multiple macros.
--
-- ActionBar page 1: slots 1 to 12
-- ActionBar page 2: slots 13 to 24
-- ActionBar page 3 (Right ActionBar): slots 25 to 36
-- ActionBar page 4 (Right ActionBar 2): slots 37 to 48
-- ActionBar page 5 (Bottom Right ActionBar): slots 49 to 60
-- ActionBar page 6 (Bottom Left ActionBar): slots 61 to 72
C.Warlock.Macro.slotId = {61, 62}
-- Fallback macro name for a specific slot, if no pet-specific macro is available.
-- For example: `pet61` for a macro used by all pets, placed in slot 61.
C.Warlock.Macro.fallbackMacro = "pet"

local upper, gsub = string.upper, string.gsub

F.mprint = function(str)
  local strClass = F.cClass..C.LocalizedClass..F.eoc
  str = gsub(str, "^%l", upper)
  print(format(G.caF.."\[%s\] %s", addon, strClass, str))
end
