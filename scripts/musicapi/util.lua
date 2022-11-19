local util = {}

--[[
Returns the "Isaac Type" of an object. If there is none, return the Lua type.
]]
function util.type(obj)
	local mt = getmetatable(obj)
	return mt and mt.__type or type(obj)
end

--[[
Returns a function that acts like a type assert (takes object) and gives an informative error on fail.
]]
function util.assertTypeFn(accepted_types, message) --message can be number for generic function argument error
	assert(#accepted_types > 0)
	local str_accepted = accepted_types[1]
	for i=2,#accepted_types do
		if i == #accepted_types then 
			str_accepted = str_accepted .. " or "
		else
			str_accepted = str_accepted .. ", "
		end
		str_accepted = str_accepted .. accepted_types[i]
	end
	
	local str_message
	if message == nil then
		str_message = "Unexpected argument, expected " .. str_accepted .. ", got %s" 
	elseif type(message) == "number" then
		str_message = "Unexpected argument #" .. message .. ", expected " .. str_accepted .. ", got %s" 
	else
		str_message = message
	end
	
	local accepted_set = {}
	for _,t in ipairs(accepted_types) do
		accepted_set[t] = true
	end
	
	return function(obj)
		local t = util.type(obj)
		if not accepted_set[t] then
			error(string.format(str_message, t), 2)
		end
	end
end

function util.assert(bool, msg, level)
	if not bool then
		error(msg, level and (level + 1) or 2)
	end
end

function util.cout(...)
	for _, msg in ipairs{...} do
		Isaac.ConsoleOutput(tostring(msg).."\n")
	end
end

function util.capitalCase(s)
	--This MIGHT be optimisable using patterns.
	local str = s:lower():gsub("_", " ")
	local next_letter = 1
	while true do
		str = str:sub(1, next_letter - 1) .. str:sub(next_letter, next_letter):upper() .. str:sub(next_letter + 1, -1)
		next_letter = str:find(" ", next_letter + 1)
		if next_letter == nil then break end
		next_letter = next_letter + 1
	end
	return str
end

function util.shallowCopy(t)
	if type(t) ~= "table" then return t end
	local new = {}
	for a,b in pairs(t) do new[a] = b end
	setmetatable(new, getmetatable(t))
	return new
end

---- scheduling functions utils
function util.runUpdates(tab) --This is from Fiend Folio
    for i = #tab, 1, -1 do
        local f = tab[i]
        f.Delay = f.Delay - 1
        if f.Delay <= 0 then
            f.Func()
            table.remove(tab, i)
        end
    end
end

--TEST (COMMENT OUT ON RELEASE)
local myFuncAssert1 = util.assertTypeFn({"Vector", "number"}, 1)
local myFuncAssert2 = util.assertTypeFn({"string", "number"}, 1)
local function myFunc(vec_or_num, str_or_num)
	myFuncAssert1(vec_or_num) --make sure arg 1 is Vector or number
	myFuncAssert2(str_or_num) --make sure arg 2 is string or number
end
local status1, err1 = pcall(myFunc, Vector(0,0), "a")
local status2, err2 = pcall(myFunc, Vector(0,0), 1)
local status3, err3 = pcall(myFunc, "f", 1)
assert(status1 and status2 and not status3)

return util
