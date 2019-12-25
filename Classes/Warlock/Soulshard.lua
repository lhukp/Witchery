local addon, ns = ...
local C, F, G = unpack(ns)

if not C.IsWarlock then return end
if not( C.Warlock.Enabled and C.Warlock.Soulshard.Enabled ) then return end

local L = LibStub("AceLocale-3.0"):GetLocale(addon)
local f = CreateFrame("Frame", addon..C.RealClass.."Soulshard", UIParent)

local login = true
local baginit = true
local sortnotdone = true
local onceafterbaginit = true
local soulShardItemID = 6265
local sortprogress = false
local srclist, destlist

local LAST_SLOT, FREE, TOTAL_SHARDS

local GetContainerNumFreeSlots = GetContainerNumFreeSlots
local GetContainerNumSlots = GetContainerNumSlots
local PickupContainerItem = PickupContainerItem
local GetContainerItemID = GetContainerItemID
local DeleteCursorItem = DeleteCursorItem
local CursorHasItem = CursorHasItem
local GetCursorInfo = GetCursorInfo
local GetItemFamily = GetItemFamily
local GetItemCount = GetItemCount
local ClearCursor = ClearCursor
local GetItemInfo = GetItemInfo
local GetBagName = GetBagName

local BAGS = {}

--
-- local functions
--

local function GetFirstFreePos()
	for bag=0,NUM_BAG_SLOTS,1 do
		for slot=1,GetContainerNumSlots(bag),1 do
			itemId = GetContainerItemID(bag, slot)
			if itemId == nil then
				return bag, slot
			end
		end
	end
	return nil, nil
end

local function GetSource()
	local bag, slot, srclistentry

	for bag=0,NUM_BAG_SLOTS,1 do
		for slot=1,GetContainerNumSlots(bag),1 do
			srclistentry = format("%d_%d", bag, slot)
			if( F.intable(srclist, srclistentry) == false ) then
				itemId = GetContainerItemID(bag, slot)
				if( itemId == soulShardItemID ) then
					return bag, slot
				end
			end
		end
	end
	return nil, nil

end

local function GetDestination()
	local bag, slot, destlistentry

	for bag=NUM_BAG_SLOTS,0,-1 do
		if BAGS[bag].canholdshard then
			for slot=GetContainerNumSlots(bag),1,-1 do
				destlistentry = format("%d_%d", bag, slot)
				if( F.intable(destlist, destlistentry) == false ) then
					itemId = GetContainerItemID(bag, slot)
					if itemId == nil or itemId ~= soulShardItemID then
						return bag, slot
					end
				end
			end
		end
	end
	return nil, nil
end

local function HasValidPos(srcBag, destBag)
	return (srcBag ~= nil and destBag ~= nil) and true or false
end

local function IsSamePos(srcBag, srcSlot, destBag, destSlot)
	if( srcBag == destBag and srcSlot == destSlot ) then
		return true
	else
		return false
	end
end

local function IsFollowingPos(srcBag, srcSlot, destBag, destSlot)
	if( destBag > srcBag ) then
		return true
	elseif( destBag == srcBag and destSlot > srcSlot ) then
		return true
	else
		return false
	end
end

local function AddtoList(srcBag, srcSlot, destBag, destSlot)
	srclistentry = format("%d_%d", srcBag, srcSlot)
	destlistentry = format("%d_%d", destBag, destSlot)
	table.insert(srclist, srclistentry)
	table.insert(destlist, destlistentry)
end

local function SortShards()

	if( CursorHasItem() ) then return end

	sortprogress = true
	srclist, destlist = {}, {}

	if( TOTAL_SHARDS and sortnotdone ) then

		local srcBag, srcSlot, destBag, destSlot, hasValidPos, isFollowingPos, isSamePos, srclistentry, destlistentry

		srcBag, srcSlot = GetSource()
		destBag, destSlot = GetDestination()
		hasValidPos = HasValidPos(srcBag, destBag)
		isFollowingPos = IsFollowingPos(srcBag, srcSlot, destBag, destSlot)
		isSamePos = IsSamePos(srcBag, srcSlot, destBag, destSlot)

		repeat

			if( hasValidPos and isFollowingPos and not isSamePos ) then
				AddtoList(srcBag, srcSlot, destBag, destSlot)
				-- Maybe: GetFirstFreePos
				PickupContainerItem(srcBag, srcSlot)
				PickupContainerItem(destBag, destSlot)
			end

			srcBag, srcSlot = GetSource()
			destBag, destSlot = GetDestination()
			hasValidPos = HasValidPos(srcBag, destBag)
			isFollowingPos = IsFollowingPos(srcBag, srcSlot, destBag, destSlot)
			isSamePos = IsSamePos(srcBag, srcSlot, destBag, destSlot)

		until (isSamePos or not isFollowingPos)

		srclist, destlist = nil, nil

	end

	sortprogress = false
	sortnotdone = nil

end

local function GetLastSlot()
	local b, s
	for bag = 0, NUM_BAG_SLOTS do

		if type(GetContainerNumSlots(bag)) == "number" then
			b = bag
			s = GetContainerNumSlots(bag)
			-- Calculate free slots
			local free = GetContainerNumFreeSlots(bag)
			if type(free) == "number" then
				FREE = FREE + free
			end
		end

	end

	return {b, s}
end

local function Init()

	FREE, TOTAL_SHARDS = 0, 0
	LAST_SLOT = GetLastSlot()

end

local function InitBags()

	TOTAL_SHARDS = GetItemCount(soulShardItemID)

	for i = 0, NUM_BAG_SLOTS do
		local free, total = 0, 0
		local bagName, bagType, bagSubType, isBackpack, isSoulpouchBag, canHoldSoulShard
		bagName = GetBagName(i);

		if bagName ~= nil then
			isBackpack = i == 0 and true or false
			isSoulpouchBag = F.intable(F_SOULPOUCH, bagName)
			if not isBackpack then -- not needed on player's backpack
				bagType = select(6,GetItemInfo(bagName))
				bagSubType = select(7,GetItemInfo(bagName))
			end
			if isBackpack or bagType == bagSubType or isSoulpouchBag then
				free, total = GetContainerNumFreeSlots(i), GetContainerNumSlots(i)
				canHoldSoulShard = true
			end

			BAGS[i] = {
				["name"] = bagName,
				["type"] = bagType,
				["subtype"] = bagSubType,
				["total"] = GetContainerNumSlots(i),
				["free"] = GetContainerNumFreeSlots(i),
				["bagpack"] = isBackpack,
				["canholdshard"] = canHoldSoulShard,
				["soulpouchbag"] = isSoulpouchBag
			}

			local maxBag, _ = unpack(LAST_SLOT)
			if i == maxBag then
				 baginit = nil
			end
		end
	end

end

--
-- global functions
--

F.SortShards = function(force)
	sortnotdone = true
	force = force ~= nil and true or false

	if( not sortprogress or force ) then
		SortShards()
		F.mprint(F.cYellow..L["shards sorted"])
	else
		local sout = L["shards sorted faild, use _cmd_ _cwhite_or _cmd_ to try again"]:format(F.cYellow.."/wss sort 1", F.cWhite, F.cYellow.."/wss s 1"..F.cWhite)
		F.mprint(sout)
	end
end

F.DeleteSoulshard = function(number)
	local soulShardExtinctions = 1, deleted
	local soulShardCount = GetItemCount(soulShardItemID)

	if tonumber(number) ~= nil then soulShardExtinctions = tonumber(number)	end
	if soulShardExtinctions > soulShardCount then soulShardExtinctions = soulShardCount end
	deleted = soulShardExtinctions

	-- /run ChatFrame1:Clear()
	for bag=0,NUM_BAG_SLOTS,1 do
		for slot=1,GetContainerNumSlots(bag),1 do
			soulShardCount = GetItemCount(soulShardItemID)
			itemId = GetContainerItemID(bag, slot)
			if itemId ~= nil and itemId == soulShardItemID then
				if soulShardExtinctions > 0 then
					PickupContainerItem(bag, slot)
					_, cursorItemID = GetCursorInfo()
					if cursorItemID == soulShardItemID then
						DeleteCursorItem()
						soulShardExtinctions = soulShardExtinctions - 1
					else
						ClearCursor()
					end
				end
			end
		end
	end

	if(tonumber(number) == nil) then
		local msgout = L["shards deleted"]:format(1)
		F.mprint(F.cYellow..msgout)
	else
		local msgout = L["shards deleted"]:format(tonumber(number))
		F.mprint(F.cYellow..msgout)
	end
	TOTAL_SHARDS = GetItemCount(soulShardItemID)
end

--
-- events
--

local function onevent(self, event, arg1, ...)

	if(login and ((event == "ADDON_LOADED" and addon == arg1) or (event == "PLAYER_LOGIN"))) then
		login = nil
		Init()
		f:UnregisterEvent("ADDON_LOADED")
		f:UnregisterEvent("PLAYER_LOGIN")
	end

	if(event == "BAG_UPDATE") then
		if(baginit) then
			InitBags()
		elseif(onceafterbaginit) then
			if( not sortprogress ) then
				SortShards()
			end
			onceafterbaginit = nil
		end
	end

	if(event == "PLAYER_REGEN_ENABLED") then
		local soulShardCount = GetItemCount(soulShardItemID)
		if( soulShardCount > TOTAL_SHARDS ) then
			sortnotdone = true
			if( not sortprogress ) then
				SortShards()
			end
		end
	end

end

f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("BAG_UPDATE")
f:SetScript("OnEvent", onevent)
f:Hide()
