local addon, ns = ...
ns[1] = {} -- C, config
ns[2] = {} -- F, functions, constants, variables
ns[3] = {} -- G, globals (Optionnal)

local C, F, G = unpack(ns)

F.hex = function(r, g, b)
	if not r then return "|cffFFFFFF" end

	if type(r) == "table" then
		if(r.r) then
			r, g, b = r.r, r.g, r.b
		else
			r, g, b = unpack(r)
		end
	end

	return ("|cff%02x%02x%02x"):format(r * 255, g * 255, b * 255)
end

-- remove all whitespace from string.
F.killws = function(s)
   return s:gsub("%s+", "")
end

-- remove trailing and leading whitespace from string.
F.trim = function(s)
  local n = s:find"%S"
  return n and s:match(".*%S", n) or ""
end

-- remove leading whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(programming)
F.ltrim = function(s)
  return (s:gsub("^%s*", ""))
end

-- remove trailing whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(programming)
F.rtrim = function(s)
  local n = #s
  while n > 0 and s:find("^%s", n) do n = n - 1 end
  return s:sub(1, n)
end

-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
F.tprint = function (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    elseif type(v) == 'boolean' then
      print(formatting .. tostring(v))
    else
      print(formatting .. v)
    end
  end
end

-- Checks if a table contains a value
F.intable = function(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

--[[
Ordered table iterator, allow to iterate on the natural order of the keys of a
table.

Example:
]]

local function __genOrderedIndex( t )
    local orderedIndex = {}
    for key in pairs(t) do
        table.insert( orderedIndex, key )
    end
    table.sort( orderedIndex )
    return orderedIndex
end

local function orderedNext(t, state)
    -- Equivalent of the next function, but returns the keys in the alphabetic
    -- order. We use a temporary ordered key table that is stored in the
    -- table being iterated.

    local key = nil
    --print("orderedNext: state = "..tostring(state) )
    if state == nil then
        -- the first time, generate the index
        t.__orderedIndex = __genOrderedIndex( t )
        key = t.__orderedIndex[1]
    else
        -- fetch the next value
        for i = 1,table.getn(t.__orderedIndex) do
            if t.__orderedIndex[i] == state then
                key = t.__orderedIndex[i+1]
            end
        end
    end

    if key then
        return key, t[key]
    end

    -- no more value to return, cleanup
    t.__orderedIndex = nil
    return
end

F.orderedPairs = function (t)
    -- Equivalent of the pairs() function on tables. Allows to iterate
    -- in order
    return orderedNext, t, nil
end
