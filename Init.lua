local addon, ns = ...
local C, F, G = unpack(ns)

local L = LibStub("AceLocale-3.0"):GetLocale(addon)

local function WitcheryCmds(msg, editbox)
	local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")

	if cmd == nil then
		print(format(G.caF.." command list:", addon))
	elseif tonumber(cmd) ~= nil then
		print("command is:", cmd)
	else
	  print("cmd:", cmd)
	  print("args:", args)
	end
end

-- Witchery slashhandlers

SlashCmdList["WITCHERY"] = WitcheryCmds
SLASH_WITCHERY1 = "/witchery"
SLASH_WITCHERY2 = "/wry"

-- Usefull slashhandlers

SlashCmdList['WRYRL'] = function() ReloadUI() end
SLASH_WRYRL1 = '/rl'

SlashCmdList['WRYGM'] = function() ToggleHelpFrame() end
SLASH_WRYGM1 = '/gm'

SlashCmdList['WRYLP'] = function() LeaveParty() end
SLASH_WRYLP1 = '/lp'

SlashCmdList['WRYRI'] = function() ResetInstances() end
SLASH_WRYRI1 = '/ri'

print(format(G.caF.." %s.", addon, L["loaded"]))
