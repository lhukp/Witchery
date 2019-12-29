local bit_and = bit.band
local RaidIconMaskToIcon = {
    [COMBATLOG_OBJECT_RAIDTARGET1] = format(TEXT_MODE_A_STRING_DEST_ICON, COMBATLOG_OBJECT_RAIDTARGET1, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1.blp:0|t"),
    [COMBATLOG_OBJECT_RAIDTARGET2] = format(TEXT_MODE_A_STRING_DEST_ICON, COMBATLOG_OBJECT_RAIDTARGET2, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2.blp:0|t"),
    [COMBATLOG_OBJECT_RAIDTARGET3] = format(TEXT_MODE_A_STRING_DEST_ICON, COMBATLOG_OBJECT_RAIDTARGET3, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3.blp:0|t"),
    [COMBATLOG_OBJECT_RAIDTARGET4] = format(TEXT_MODE_A_STRING_DEST_ICON, COMBATLOG_OBJECT_RAIDTARGET4, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4.blp:0|t"),
    [COMBATLOG_OBJECT_RAIDTARGET5] = format(TEXT_MODE_A_STRING_DEST_ICON, COMBATLOG_OBJECT_RAIDTARGET5, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5.blp:0|t"),
    [COMBATLOG_OBJECT_RAIDTARGET6] = format(TEXT_MODE_A_STRING_DEST_ICON, COMBATLOG_OBJECT_RAIDTARGET6, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6.blp:0|t"),
    [COMBATLOG_OBJECT_RAIDTARGET7] = format(TEXT_MODE_A_STRING_DEST_ICON, COMBATLOG_OBJECT_RAIDTARGET7, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7.blp:0|t"),
    [COMBATLOG_OBJECT_RAIDTARGET8] = format(TEXT_MODE_A_STRING_DEST_ICON, COMBATLOG_OBJECT_RAIDTARGET8, "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8.blp:0|t")
}
local msgTags = {}

function ezInterrupt:COMBAT_LOG_EVENT_UNFILTERED(_,_,event,sourceGUID,_,sourceFlags,_,destName,destFlags,spellID,_,_,extraID, ...)
    if event == "SPELL_INTERRUPT" and bit_and(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 then
        local raidIcon = RaidIconMaskToIcon[bit_and(destFlags, COMBATLOG_OBJECT_RAIDTARGET_MASK)]
        if raidIcon then destName = string.format("%s%s", raidIcon, destName) end
        msgTags["[spell]"] = GetSpellLink(extraID)
        msgTags["[target]"] = destName
        msgTags["[interrupt]"] = GetSpellLink(spellID)
        local msg = string.gsub(self.db.profile.customMessage, "%[%a+%]", msgTags)
        if self.db.profile.enableWhispering and self.db.profile.whisperTarget ~= nil then SendChatMessage(msg, "WHISPER", nil, self.db.profile.whisperTarget ) end
        if self.db.profile.enableCustomChannel and self.db.profile.customChannel ~= nil then SendChatMessage(msg, "CHANNEL", nil, self.db.profile.customChannel ) end
        if self.db.profile.enableSystemMessage then LAST_ACTIVE_CHAT_EDIT_BOX:GetParent():AddMessage(msg) end
        if outputChannel then SendChatMessage(msg, outputChannel) end
    end
end


local prefix = "[DX-LostMobs]";
local outputChannel =  "SAY";

SLASH_DX_LM_1 = "/lm";
SLASH_DX_LM_2 = "/lostmobs";

--SlashCmdList["DX_LOST_MOBS"] = function(msg)
--  print(prefix..msg);
-- end;

local LostMobs = {};
guidtounit = {};
guidtomob = {};
untanked = {};
local srcGuid,srcName,tarGuid,tarName;

function onEvent(self,event,...)
  local temp,_  = select(2,...);
  if event == "COMBAT_LOG_EVENT_UNFILTERED" then
    if temp == "UNIT_DIED" then
      --return onEvent(self,select(2,...),...);
      print("Some unit died - checking moblist....");
      UnitDied(event,...);
    else
      return ParseCombatLog(select(3,...));
    end;
  elseif event == "PARTY_MEMBERS_CHANGED" then
    return PartyMembersChanged();
  end;
end;

function ParseCombatLog(...)

  srcGuid,srcName,_,tarGuid,tarName,_ = ...;
  if (not IsRaidOrPartyMember(srcGuid)) and IsRaidOrPartyMember(tarGuid) then
    if not guidtomob[srcGuid] then
      guidtomob[srcGuid] = srcName;
    end;
    print(prefix..srcName.." is attacking "..tarName);
  end;
end;

function IsRaidOrPartyMember(id)
  if guidtounit[id] or guidtounit[UnitGUID(id)] then
    return 1;
  else
    return nil;
  end;
end;


function UnitDied(event,...)

  local guid,name,_ = select(6,...);

  if not (UnitPlayerOrPetInRaid(guid) or UnitPlayerOrPetInParty(guid)) then
    print(guidtomob);
    tremoveKey(guidtomob,guid);
    print(guidtomob);
  end;
end;


function PartyMembersChanged()
  print("Something changed within the group!");
  wipe(guidtounit);
  guidtounit[UnitGUID('player')] = 'player';
  if UnitExists('pet') then
      guidtounit[UnitGUID('pet')] = 'pet';
  end;
  for i= 1, GetNumPartyMembers() do
      guidtounit[UnitGUID('party'..i)] = 'party'..i;
      if UnitExists('party'..i..'pet') then
          guidtounit[UnitGUID('party'..i..'pet')] = 'party'..i..'pet';
      end;
  end;
  print(prefix.."Party-Data updated - "..#guidtounit.." Members in list");
end;

function tremoveKey(table,key)
  local element = table[key];
  table[key] = nil;
  return element;
end;


local frame = CreateFrame("Frame");
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
frame:RegisterEvent("PARTY_MEMBERS_CHANGED");
frame:SetScript("onEvent",onEvent);
