MusicAPI.Rooms = require "scripts.musicapi.enums.rooms"
MusicAPI.Default.Rooms = MusicAPI.Rooms

local game = MusicAPI.shared.game

local FALLBACK = "API_DO_NOTHING"

local GridRoom = {
	[GridRooms.ROOM_GIDEON_DUNGEON_IDX] = "GideonDungeon",
	[GridRooms.ROOM_GENESIS_IDX] = "GenesisRoom",
	[GridRooms.ROOM_SECRET_SHOP_IDX] = "SecretShop",
	[GridRooms.ROOM_ANGEL_SHOP_IDX] = "AngelShop"
}

--TODO: AddRoomType should also provide a function to identity the new room type to be used here!
local function _getRoomType()
	local res = (StageAPI and StageAPI.GetCurrentRoomType()) or game:GetRoom():GetType()
	if type(res) == "number" then
		if GridRoom[game:GetLevel():GetCurrentRoomIndex()] ~= nil then
			res = GridRoom[game:GetLevel():GetCurrentRoomIndex()]
		end
	end
	return res
end

--TODO: When reintegrating, make sure to return the state track if one is active
local function _getRoomTrack(id, level, stageTable, genericTable)
	if stageTable[level] == nil then
		MusicAPI.LogMajor("_getRoomTrack(): Stage \"".. tostring(level).."\" not registered!")
		if genericTable[id] then
			if genericTable[id] == "API_STAGE" then
				MusicAPI.LogMajor("_getRoomTrack(): RoomType \"".. tostring(id).."\" uses the stage track, but this stage is unregistered... nothing to return!")
				return FALLBACK
			else
				MusicAPI.LogMinor("_getRoomTrack(): Defaulting to generic track \"".. dump(genericTable[id]).."\" for RoomType \"".. tostring(id).."\"")
				return genericTable[id]
			end
		else
			MusicAPI.LogMajor("_getRoomTrack(): RoomType \"".. tostring(id).."\" not registered either... nothing to return!")
			return FALLBACK
		end
	elseif stageTable[level].Tracks.Rooms then
		if type(stageTable[level].Tracks.Rooms["AllRooms"]) == "string" then
			MusicAPI.LogMinor("_getRoomTrack(): Stage has AllRooms set, returning \"".. dump(stageTable[level].Tracks.Rooms["AllRooms"]).."\" for RoomType \"".. tostring(id).."\"")
			return stageTable[level].Tracks.Rooms["AllRooms"]
		elseif stageTable[level].Tracks.Rooms[id] then
			if stageTable[level].Tracks.Rooms[id] == "API_STAGE" then
				MusicAPI.LogMinor("_getRoomTrack(): Stage defined track for RoomType  \""..tostring(id).."\" is default stage track ".. dump(stageTable[level].Tracks.Stage))
				return stageTable[level].Tracks.Stage
			end
			MusicAPI.LogMinor("_getRoomTrack(): Using stage track \""..stageTable[level].Tracks.Rooms[id].."\" for RoomType \"".. tostring(id).."\"")
			return stageTable[level].Tracks.Rooms[id]
		end
	end

	if genericTable[id] then
		if genericTable[id] == "API_STAGE" then
			MusicAPI.LogMinor("_getRoomTrack(): Returning current stage track ".. dump(stageTable[level].Tracks.Stage).." for RoomType \"".. tostring(id).."\"")
			return stageTable[level].Tracks.Stage
		end
		MusicAPI.LogMinor("_getRoomTrack(): Using generic track ".. dump(genericTable[id]).." for RoomType \"".. tostring(id).."\"")
		return genericTable[id]
	end

	MusicAPI.LogMajor("_getRoomTrack(): RoomType \"".. tostring(id).."\" not registered!")
	return stageTable[level].Tracks.Stage or FALLBACK
end

local function _addToRoomTracks(id, track, table)
	local ret = {}
	if type(table[id]) == "string" then
		ret = { table[id], track }
	elseif type(table[id]) == "table" then
		ret = table[id]
		ret[#ret+1] = track
	end
	return ret
end

local function _addToState(state, track)
	local ret = {}
	if type(state) == "string" then
		ret = { state, track }
	elseif type(state) == "table" then
		ret = state
		ret[#ret+1] = track
	end
	return ret
end

function MusicAPI.GetDefaultRoomTrack(id, level)
	if id == nil then id = _getRoomType() end
	if level == nil then level = MusicAPI.GetStageName() end

	return _getRoomTrack(id, level, MusicAPI.Default.Stages, MusicAPI.Default.Rooms.GenericRooms)
end

function MusicAPI.GetRoomTrack(id, level)
	if id == nil then id = _getRoomType() end
	if level == nil then level = MusicAPI.GetStageName() end

	return _getRoomTrack(id, level, MusicAPI.Stages, MusicAPI.Rooms.GenericRooms)
end

local function _handleStateTrackGet(level, stageTable, genericTable)
	if MusicAPI.Test then --TODO: cache.RoomDescriptor.ChallengeDone
		return stageTable and stageTable.Empty or genericTable.Empty
	else
		return stageTable and stageTable.Inactive or genericTable.Inactive
	end
end

function MusicAPI.GetChallengeRoomTrack(level)
	if level == nil then level = MusicAPI.GetStageName() end
	MusicAPI.assert(MusicAPI.Stages[level], "MusicAPI.GetChallengeRoomTrack(): Stage \"".. tostring(level).."\" not registered!")
	return _handleStateTrackGet(level, MusicAPI.Stages[level].Tracks.Challenge, MusicAPI.Rooms.GenericChallenge)
end

function MusicAPI.GetBossChallengeRoomTrack(level)
	if level == nil then level = MusicAPI.GetStageName() end
	MusicAPI.assert(MusicAPI.Stages[level], "MusicAPI.GetBossChallengeRoomTrack(): Stage \"".. tostring(level).."\" not registered!")
	return _handleStateTrackGet(level, MusicAPI.Stages[level].Tracks.BossChallenge, MusicAPI.Rooms.GenericBossChallenge)
end

function MusicAPI.GetBossRushTrack(level)
	if level == nil then level = MusicAPI.GetStageName() end
	MusicAPI.assert(MusicAPI.Stages[level], "MusicAPI.GetBossRushTrack(): Stage \"".. tostring(level).."\" not registered!")
	return _handleStateTrackGet(level, MusicAPI.Stages[level].Tracks.BossRush, MusicAPI.Rooms.GenericBossRush)
end

function MusicAPI.GetDefaultChallengeRoomTrack(level)
	if level == nil then level = MusicAPI.GetStageName() end
	MusicAPI.assert(MusicAPI.Stages[level], "MusicAPI.GetChallengeRoomTrack(): Stage \"".. tostring(level).."\" not registered!")
	return _handleStateTrackGet(level, MusicAPI.Default.Stages[level].Tracks.Challenge, MusicAPI.Default.Rooms.GenericChallenge)
end

function MusicAPI.GetDefaultBossChallengeRoomTrack(level)
	if level == nil then level = MusicAPI.GetStageName() end
	MusicAPI.assert(MusicAPI.Stages[level], "MusicAPI.GetBossChallengeRoomTrack(): Stage \"".. tostring(level).."\" not registered!")
	return _handleStateTrackGet(level, MusicAPI.Default.Stages[level].Tracks.BossChallenge, MusicAPI.Default.Rooms.GenericBossChallenge)
end

function MusicAPI.GetDefaultBossRushTrack(level)
	if level == nil then level = MusicAPI.GetStageName() end
	MusicAPI.assert(MusicAPI.Stages[level], "MusicAPI.GetBossRushTrack(): Stage \"".. tostring(level).."\" not registered!")
	return _handleStateTrackGet(level, MusicAPI.Default.Stages[level].Tracks.BossRush, MusicAPI.Default.Rooms.GenericBossRush)
end

local function _handleStateTrackAdd(table, state, track)
	if table[state]  == nil then
		table[state] = track
	else
		table[state] = _addToState(table[state], track)
	end
end

local function _handleStateTrackSet(table, state, track)
	if not table then
		table = { state = track }
	else
		table[state] = track
	end
end

local function _handleStageStateTrackReset(stageTable, genericTable, state, track)
	if stageTable then
		if stageTable[state] then
			stageTable[state] = genericTable[state]
		end
	end
end

local function _handleStageRoomReset(stageTable, genericTable)
	if stageTable then
		stageTable = genericTable
	end
end

-- TODO: move
MusicAPI.ChallengeStates = {
	["Inactive"] = 1,
	["Active"] = 2,
	["OverJingle"] = 3,
	["Empty"] = 4
}

function MusicAPI.AddTrackToChallengeRoom(state, track, stage)
	MusicAPI.assert(MusicAPI.ChallengeStates[state], "MusicAPI.AddTrackToChallengeRoom(): State \"".. tostring(state).."\" is invalid!")

	if stage then
		MusicAPI.assert(MusicAPI.Stages[stage], "MusicAPI.AddTrackToChallengeRoom(): Stage \"".. tostring(stage).."\" is unregisted!")
		_handleStateTrackAdd(MusicAPI.Stages[stage].Tracks.Challenge, state, track)
	else
		_handleStateTrackAdd(MusicAPI.Rooms.GenericChallenge, state, track)
	end
end

function MusicAPI.AddTrackToBossChallengeRoom(state, track, stage)
	MusicAPI.assert(MusicAPI.ChallengeStates[state], "MusicAPI.AddTrackToBossChallengeRoom(): State \"".. tostring(state).."\" is invalid!")

	if stage then
		MusicAPI.assert(MusicAPI.Stages[stage], "MusicAPI.AddTrackToChallengeRoom(): Stage \"".. tostring(stage).."\" is unregisted!")
		_handleStateTrackAdd(MusicAPI.Stages[stage].Tracks.BossChallenge, state, track)
	else
		_handleStateTrackAdd(MusicAPI.Rooms.GenericBossChallenge, state, track)
	end
end

function MusicAPI.AddTrackToBossRush(state, track, stage)
	MusicAPI.assert(MusicAPI.ChallengeStates[state], "MusicAPI.AddTrackToBossRush(): State \"".. tostring(state).."\" is invalid!")

	if stage then
		MusicAPI.assert(MusicAPI.Stages[stage], "MusicAPI.AddTrackToChallengeRoom(): Stage \"".. tostring(stage).."\" is unregisted!")
		_handleStateTrackAdd(MusicAPI.Stages[stage].Tracks.BossRush, state, track)
	else
		_handleStateTrackAdd(MusicAPI.Rooms.GenericBossRush, state, track)
	end
end

function MusicAPI.SetChallengeRoomTrack(state, track, stage)
	MusicAPI.assert(MusicAPI.ChallengeStates[state], "MusicAPI.SetChallengeRoomTrack(): State \"".. tostring(state).."\" is invalid!")

	if stage then
		MusicAPI.assert(MusicAPI.Stages[stage], "MusicAPI.SetChallengeRoomTrack(): Stage \"".. tostring(stage).."\" is unregisted!")
		_handleStateTrackSet(MusicAPI.Stages[stage].Tracks.Challenge, state, track)
		end
	else
		MusicAPI.Rooms.GenericChallenge[state] = track
	end
end

function MusicAPI.SetBossChallengeRoomTrack(state, track, stage)
	MusicAPI.assert(MusicAPI.ChallengeStates[state], "MusicAPI.SetBossChallengeRoomTrack(): State \"".. tostring(state).."\" is invalid!")

	if stage then
		MusicAPI.assert(MusicAPI.Stages[stage], "MusicAPI.SetBossChallengeRoomTrack(): Stage \"".. tostring(stage).."\" is unregisted!")
		_handleStateTrackSet(MusicAPI.Stages[stage].Tracks.BossChallenge, state, track)
	else
		MusicAPI.Rooms.GenericBossChallenge[state] = track
	end
end

function MusicAPI.SetBossRushTrack(state, track, stage)
	MusicAPI.assert(MusicAPI.ChallengeStates[state], "MusicAPI.SetBossRushTrack(): State \"".. tostring(state).."\" is invalid!")

	if stage then
		MusicAPI.assert(MusicAPI.Stages[stage], "MusicAPI.SetBossRushTrack(): Stage \"".. tostring(stage).."\" is unregisted!")
		_handleStateTrackSet(MusicAPI.Stages[stage].Tracks.BossRush, state, track)
	else
		MusicAPI.Rooms.GenericBossRush[state] = track
	end
end

function MusicAPI.ResetChallengeRoomStateTrack(state, stage)
	MusicAPI.assert(MusicAPI.ChallengeStates[state], "MusicAPI.ResetChallengeRoomStateTrack(): State \"".. tostring(state).."\" is invalid!")

	if stage then
		MusicAPI.assert(MusicAPI.Stages[stage], "MusicAPI.ResetChallengeRoomStateTrack(): Stage \"".. tostring(stage).."\" is unregisted!")
		_handleStageStateTrackReset(MusicAPI.Stages[stage].Tracks.Challenge, MusicAPI.Default.Stages[stage].Tracks.Challenge, state, track)
	else
		MusicAPI.Rooms.GenericChallenge[state] = MusicAPI.Default.Rooms.GenericChallenge[state]
	end
end

function MusicAPI.ResetBossChallengeRoomStateTrack(state, stage)
	MusicAPI.assert(MusicAPI.ChallengeStates[state], "MusicAPI.ResetBossChallengeRoomStateTrack(): State \"".. tostring(state).."\" is invalid!")

	if stage then
		MusicAPI.assert(MusicAPI.Stages[stage], "MusicAPI.ResetBossChallengeRoomStateTrack(): Stage \"".. tostring(stage).."\" is unregisted!")
		_handleStageStateTrackReset(MusicAPI.Stages[stage].Tracks.BossChallenge, MusicAPI.Default.Stages[stage].Tracks.BossChallenge, state, track)
	else
		MusicAPI.Rooms.GenericChallenge[state] = MusicAPI.Default.Rooms.GenericBossChallenge[state]
	end
end

function MusicAPI.ResetBossRushStateTrack(state, stage)
	MusicAPI.assert(MusicAPI.ChallengeStates[state], "MusicAPI.ResetBossRushStateTrack(): State \"".. tostring(state).."\" is invalid!")

	if stage then
		MusicAPI.assert(MusicAPI.Stages[stage], "MusicAPI.ResetBossRushStateTrack(): Stage \"".. tostring(stage).."\" is unregisted!")
		_handleStageStateTrackReset(MusicAPI.Stages[stage].Tracks.BossRush, MusicAPI.Default.Stages[stage].Tracks.BossRush, state, track)
	else
		MusicAPI.Rooms.GenericBossRush[state] = MusicAPI.Default.Rooms.GenericBossRush[state]
	end
end

function MusicAPI.ResetChallengeRoom(stage)
	if stage then
		MusicAPI.assert(MusicAPI.Stages[stage], "MusicAPI.ResetChallengeRoom(): Stage \"".. tostring(stage).."\" is unregisted!")
		_handleStageRoomReset(MusicAPI.Stages[stage].Tracks.Challenge, MusicAPI.Default.Stages[stage].Tracks.Challenge)
	else
		MusicAPI.Rooms.GenericChallenge = MusicAPI.Default.Rooms.GenericChallenge
	end
end

function MusicAPI.ResetBossChallengeRoom(stage)
	if stage then
		MusicAPI.assert(MusicAPI.Stages[stage], "MusicAPI.ResetBossChallengeRoom(): Stage \"".. tostring(stage).."\" is unregisted!")
		_handleStageRoomReset(MusicAPI.Stages[stage].Tracks.BossChallenge, MusicAPI.Default.Stages[stage].Tracks.BossChallenge)
	else
		MusicAPI.Rooms.GenericBossChallenge = MusicAPI.Default.Rooms.GenericBossChallenge
	end
end

function MusicAPI.ResetBossRush(stage)
	if stage then
		MusicAPI.assert(MusicAPI.Stages[stage], "MusicAPI.ResetBossRush(): Stage \"".. tostring(stage).."\" is unregisted!")
		_handleStageRoomReset(MusicAPI.Stages[stage].Tracks.BossRush, MusicAPI.Default.Stages[stage].Tracks.BossRush)
	else
		MusicAPI.Rooms.GenericBossRush = MusicAPI.Default.Rooms.GenericBossRush
	end
end

function MusicAPI.AddRoomType(id, track)
	MusicAPI.assert(MusicAPI.Rooms[id] == nil, "MusicAPI.AddRoomType(): RoomType \"".. tostring(stage).."\" is already registered!")
	MusicAPI.Rooms[id] = track
	if MusicAPI.Default.Rooms[id] == nil then
		MusicAPI.Default.Rooms[id] = track
	end
end

function MusicAPI.AddTrackToRoom(id, track, stage)
	if stage then
		MusicAPI.assert(MusicAPI.Stages[stage], "MusicAPI.AddTrackToRoom(): Stage \"".. tostring(stage).."\" is unregisted!")
		if MusicAPI.Stages[stage].Tracks.Rooms[id] then
			MusicAPI.Stages[stage].Tracks.Rooms[id] = _addToRoomTracks(id, track, MusicAPI.Stages[stage].Tracks.Rooms)
		else
			MusicAPI.Stages[stage].Tracks.Rooms[id] = track
		end
	elseif MusicAPI.Rooms.GenericRooms[id] == nil or type(MusicAPI.Rooms.GenericRooms[id]) == "string" and string.match(MusicAPI.Rooms.GenericRooms[id],"API_") then
		MusicAPI.Rooms.GenericRooms[id] = track
	else
		MusicAPI.Rooms.GenericRooms[id] = _addToRoomTracks(id, track, MusicAPI.Rooms.GenericRooms)
	end
end

function MusicAPI.SetRoomTrack(id, track, stage)
	if stage then
		MusicAPI.assert(MusicAPI.Stages[stage], "MusicAPI.SetRoomTrack(): Stage \"".. tostring(stage).."\" is unregisted!")
		if not MusicAPI.Stages[stage].Tracks.Rooms then
			MusicAPI.Stages[stage].Tracks.Rooms = { id = track }
		else
			MusicAPI.Stages[stage].Tracks.Rooms[id] = track
		end
	else
		MusicAPI.Rooms.GenericRooms[id] = track
	end
end

function MusicAPI.ResetRoom(id, stage)
	if stage then
		MusicAPI.assert(MusicAPI.Stages[stage], "MusicAPI.ResetRoom(): Stage \"".. tostring(stage).."\" is unregisted!")
		if MusicAPI.Stages[stage].Tracks.Rooms and MusicAPI.Stages[stage].Tracks.Rooms[id] then
			if MusicAPI.Default.Stages[stage].Tracks.Rooms then
				MusicAPI.Stages[stage].Tracks.Rooms[id] = MusicAPI.Default.Stages[stage].Tracks.Rooms[id]
			else
				MusicAPI.Default.Stages[stage].Tracks.Rooms = nil
			end
		end
	else
		MusicAPI.Rooms.GenericRooms[id] = MusicAPI.Default.Rooms.GenericRooms[id]
	end
end

function MusicAPI._priv.ResetRooms()
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
