local addon, ns = ...
local C, F, G = unpack(ns)

if not(  C.IsWarlock and C.Warlock.Enabled ) then return end

local conf = C.Warlock

local L = LibStub("AceLocale-3.0"):GetLocale(addon)

local function WarlockCmd(msg, editbox)
 	-- pattern matching that skips leading whitespace and whitespace between cmd and args
	-- any whitespace at end of args is retained
 	local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
  if cmd == nil then cmd = "" end

	if (cmd == "dmn" ) then
		F.ShowDemonMacroName()
	else
    F.mprint( "command list:"..
    "\n"..F.cYellow.."\/wwl"..F.cWhite.." to show this list."..
    "\n"..F.cYellow.."\/wwl dmn"..F.cWhite.." to show the demon macro names." )
	end
end

local function SsWarlockCmd(msg, editbox)
 	-- pattern matching that skips leading whitespace and whitespace between cmd and args
	-- any whitespace at end of args is retained
 	local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
  if cmd == nil then cmd = "" end

  if (cmd == "d" or cmd == "dell") then
    if tonumber(args) ~= nil then
      F.DeleteSoulshard(tonumber(args))
    else
      F.DeleteSoulshard()
    end
  elseif (cmd == "s" or cmd == "sort") then
    if tonumber(args) ~= nil then
      F.SortShards(tonumber(args))
    else
      F.SortShards()
    end
	else
    F.mprint( "command list:"..
      "\n"..F.cYellow.."\/wss"..F.eoc.." to show this list."..
      "\n"..F.cYellow.."\/wss sort"..F.cWhite.." or "..F.cYellow.."\/wss s"..F.cWhite.." to sort soulshards."..
      "\n"..F.cYellow.."\/wss dell"..F.cWhite.." or "..F.cYellow.."\/wss d"..F.cWhite.." to delete one soulshard."..
      "\n"..F.cYellow.."\/wss dell \{n\}"..F.cWhite.." or "..F.cYellow.."\/wss d \{n\}"..F.cWhite.." to delete \{n\} soulshards."..
      "\n"..F.strTab..F.strTab.."\{n\} stands for a number, the amount of soulshards you like to delete." )
  end

end

-- Class slashhandlers

local cmdstring, strClass = "", F.cClass..C.LocalizedClass..F.eoc

if conf.Soulshard.Enabled then
  SlashCmdList["SSWARLOCK"] = SsWarlockCmd
  SLASH_SSWARLOCK1 = "/wss"
  cmdstring = SLASH_SSWARLOCK1
end

if conf.Macro.Enabled then
  SlashCmdList["WARLOCK"] = WarlockCmd
  SLASH_WARLOCK1 = "/wwl"
  cmdstring = SLASH_WARLOCK1
end

if conf.Soulshard.Enabled and conf.Macro.Enabled then
  cmdstring = SLASH_SSWARLOCK1..F.cWhite.." "..L["and"].." "..F.cYellow..SLASH_WARLOCK1
end

print(format(G.caF.." "..L["module for _class_ loaded"]..".", addon, strClass))
F.mprint(format(L["type _cmd_ for command list"], cmdstring))
