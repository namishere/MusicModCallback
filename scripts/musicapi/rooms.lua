MusicAPI.Rooms = require "scripts.musicapi.enums.rooms"
MusicAPI.Default.Rooms = MusicAPI.Rooms

local FALLBACK = "API_DO_NOTHING"

local function GetRoomType()
	if StageAPI then
		print("current roomtype: "..StageAPI.GetCurrentRoomType())
		return StageAPI.GetCurrentRoomType()
	end
	return MusicAPI.shared.game():GetRoom():GetType()
end

local function _getRoomTrack(id, level, stageTable, genericTable)
	if stageTable[level] == nil then
		MusicAPI.LogMajor("_getRoomTrack(): Stage \"".. tostring(level).."\" not registered!")
		if genericTable[id] then
			MusicAPI.LogMinor("_getRoomTrack(): Defaulting to generic track \""..genericTable[id].."\" for RoomType \"".. tostring(id).."\"")
			return genericTable[id]
		else
			MusicAPI.LogMajor("_getRoomTrack(): RoomType \"".. tostring(id).."\" not registered either... nothing to return!")
			return FALLBACK
		end
	elseif stageTable[level].Tracks.Rooms then
		if type(stageTable[level].Tracks.Rooms["AllRooms"]) == "string" then
			MusicAPI.LogMinor("_getRoomTrack(): Stage has AllRooms set, returning \"".. stageTable[level].Tracks.Rooms["AllRooms"].."\" for RoomType \"".. tostring(id).."\"")
			return stageTable[level].Tracks.Rooms["AllRooms"]
		elseif stageTable[level].Tracks.Rooms[id] then
			MusicAPI.LogMinor("_getRoomTrack(): Using stage track \""..stageTable[level].Tracks.Rooms[id].."\" for RoomType \"".. tostring(id).."\"")
			return stageTable[level].Tracks.Rooms[id]
		end
	end

	if genericTable[id] then
		MusicAPI.LogMinor("_getRoomTrack(): Using generic track \""..genericTable[id].."\" for RoomType \"".. tostring(id).."\"")
		return genericTable[id]
	end

	MusicAPI.LogMajor("_getRoomTrack(): RoomType \"".. tostring(id).."\" not registered!")
	return stageTable[level].Tracks.Stage or FALLBACK
end

function MusicAPI.GetDefaultRoomTrack(id, level)
	if id == nil then id = GetRoomType() end
	if level == nil then level = MusicAPI.GetStageName() end

	return _getRoomTrack(id, level, MusicAPI.Default.Stages, MusicAPI.Default.Rooms.GenericRooms)
end

function MusicAPI.GetRoomTrack(id, level)
	if id == nil then id = GetRoomType() end
	if level == nil then level = MusicAPI.GetStageName() end

	return _getRoomTrack(id, level, MusicAPI.Stages, MusicAPI.Rooms.GenericRooms)
end

function MusicAPI.AddRoomType(id, track)
	MusicAPI.Rooms[id] = track
	if MusicAPI.Default.Rooms[id] == nil then
		MusicAPI.Default.Rooms[id] = track
	end
end

local function _addToRoomTracks(id, track, table)
	local ret = {}
	if type(table[id]) == "number" then
		ret = { table[id], track }
	elseif type(table[id]) == "table" then
		ret = table[id]
		ret[#ret+1] = track
	end
	return ret
end

function MusicAPI.AddTrackToRoom(id, track, stage)
	if stage then
		if MusicAPI.Stages[stage].Tracks.Rooms[id] then
			MusicAPI.Stages[stage].Tracks.Rooms[id] = _addToRoomTracks(id, track, MusicAPI.Stages[stage].Tracks.Rooms)
		else
			MusicAPI.Stages[stage].Tracks.Rooms[id] = track
		end
	else
		if MusicAPI.Rooms[id] then
			_addToRoomTracks(id, track, MusicAPI.Rooms)
		else
			MusicAPI.Rooms[id] = track
		end
	end
end

function MusicAPI.SetRoomTrack(id, track, stage)
	if stage then
		if not MusicAPI.Stages[stage] and MusicAPI.Stages[stage].Tracks.Rooms then
			MusicAPI.Stages[stage].Tracks.Rooms = { id = track }
		else
			MusicAPI.Stages[stage].Tracks.Rooms[id] = track
		end
	else
		MusicAPI.Rooms[id] = track
	end
end

function MusicAPI.ResetRoom(id)
	if MusicAPI.Rooms[id] ~= nil and MusicAPI.Default.Rooms[id] then
		MusicAPI.Rooms[id] = MusicAPI.Default.Rooms[id]
	end
end

function MusicAPI.ResetRooms()
--[[
	Not needed anymore, registering a room also puts it in Default.Rooms

	-- merge default into current room table to keep custom rooms
	-- may or may not be the best option
	for k, v in pairs(MusicAPI.Default.Rooms) do
		MusicAPI[k] = v
	end
]]
	MusicAPI.Rooms = MusicAPI.Default.Rooms
end
