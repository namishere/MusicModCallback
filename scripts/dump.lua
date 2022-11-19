--  oatmealine's EVERYTHING FUNCTION v1.0 revision 1
--
-- (o: any) => string
--
--  this function will take in any type, any Isaac class and any vanilla lua type
--  and format it as a readable, comprehensible string you can shove in a print().
--  it will try to its best ability to format Isaac types, even the more obscure
--  ones, and if it fails itll fall back to listing all of its keys accessible
--  from getmetatable. it recurses through anything it finds, and makes sure to
--  mark circular elements as such, avoiding potential lag.
--
-- examples:
--
--  > print(dump(Isaac.GetPlayer(0)))
--  EntityPlayer: 1.0.7
--
--  > print(dump(Color(0.5, 0.25, 0.75)))
--  Color(0.5, 0.25, 0.75)
--
--  > print(dump(Isaac.GetRoomEntities()))
--  {
--    Entity: 1.0.42,
--    Entity: 1000.21.0,
--    Entity: 1000.21.0,
--    Entity: 1000.21.0,
--    Entity: 1000.68.0,
--    -- ...
--    Entity: 1000.121.0,
--    Entity: 1000.121.0
--  }
--
--  > print(dump(Isaac))
--  {
--    "DebugString" = function: 01223D68,
--    "GetCurseIdByName" = function: 01224D40,
--    "GetItemConfig" = function: 01224548,
--    -- ...
--  }
--
--  > print(dump({{{dumb_nested_stuff = "works!"}}}))
--  {
--    {
--      {
--        "dumb_nested_stuff": "works!"
--      }
--    }
--  }
--
--
-- this code is licensed under a [copyleft](https://en.wikipedia.org/wiki/Copyleft) license: this code is completely okay to modify, copy, redistribute and improve upon, as long as you keep this license notice
-- ↄↄ⃝ Jill "oatmealine" Monoids 2021

local function shallowCopy(tab)
  return {table.unpack(tab)}
end

local function includes(tab, val)
  for _, v in pairs(tab) do
    if val == v then return true end
  end
  return false
end

function dump(o, depth, seen)
  depth = depth or 0
  seen = seen or {}

  if depth > 50 then return '' end -- prevent infloops

  if type(o) == 'userdata' then -- handle custom isaac types
    if includes(seen, tostring(o)) then return '(circular)' end
    if not getmetatable(o) then return tostring(o) end
    local t = getmetatable(o).__type

    if t == 'Entity' or t == 'EntityBomb' or t == 'EntityEffect' or t == 'EntityFamiliar' or t == 'EntityKnife' or t == 'EntityLaser' or t == 'EntityNPC' or t == 'EntityPickup' or t == 'EntityPlayer' or t == 'EntityProjectile' or t == 'EntityTear' then
      return t .. ': ' .. (o.Type or '0') .. '.' .. (o.Variant or '0') .. '.' .. (o.SubType or '0')
    elseif t == 'EntityRef' then
      return t .. ' -> ' .. dump(o.Ref, depth, seen)
    elseif t == 'EntityPtr' then
      return t .. ' -> ' .. dump(o.Entity, depth, seen)
    elseif t == 'GridEntity' or t == 'GridEntityDoor' or t == 'GridEntityPit' or t == 'GridEntityPoop' or t == 'GridEntityPressurePlate' or t == 'GridEntityRock' or t == 'GridEntitySpikes' or t == 'GridEntityTNT' then
      return t .. ': ' .. o:GetType() .. '.' .. o:GetVariant() .. '.' .. o.VarData .. ' at ' .. dump(o.Position, depth, seen)
    elseif t == 'GridEntityDesc' then
      return t .. ' -> ' .. o.Type .. '.' .. o.Variant .. '.' .. o.VarData
    elseif t == 'Vector' then
      return string.format("Vector(%.2f, %.2f)", o.X, o.Y)
    elseif t == 'Color' then
      return t .. '(' .. o.R .. ', ' .. o.G .. ', ' .. o.B .. ', ' .. o.RO .. ', ' .. o.GO .. ', ' .. o.BO .. ')'
    elseif t == 'Level' then
      return t .. ': ' .. o:GetName()
    elseif t == 'RNG' then
      return t .. ': ' .. o:GetSeed()
    elseif t == 'Sprite' then
      return t .. ': ' .. o:GetFilename() .. ' - ' .. (o:IsPlaying(o:GetAnimation()) and 'playing' or 'stopped at') .. ' ' .. o:GetAnimation() .. ' f' .. o:GetFrame()
    elseif t == 'TemporaryEffects' then
      local list = o:GetEffectsList()
      local tab = {}
      for i = 0, #list - 1 do
        table.insert(tab, list:Get(i))
      end
      return dump(tab, depth, seen)
    else
      local newt = {}
      for k,v in pairs(getmetatable(o)) do
        if type(k) ~= 'userdata' and k:sub(1, 2) ~= '__' then newt[k] = v end
      end

      return 'userdata ' .. dump(newt, depth, seen)
    end
  elseif type(o) == 'table' then -- handle tables
    if includes(seen, tostring(o)) then return '(circular)' end
    table.insert(seen, tostring(o))
    local s = '{\n'
    local first = true
    for k,v in pairs(o) do
      if not first then
        s = s .. ',\n'
      end
      s = s .. string.rep('  ', depth + 1)

      if type(k) ~= 'number' then
        table.insert(seen, tostring(v))
        s = s .. dump(k, depth + 1, shallowCopy(seen)) .. ' = ' .. dump(v, depth + 1, shallowCopy(seen))
      else
        s = s .. dump(v, depth + 1, shallowCopy(seen))
      end
      first = false
    end
    if first then return '{}' end
    return s .. '\n' .. string.rep('  ', depth) .. '}'
  elseif type(o) == 'string' then -- anything else resolves pretty easily
    return '"' .. o .. '"'
  else
    return tostring(o)
  end
end
