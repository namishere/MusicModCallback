local MusicAPI = require("scripts.musicapi.api")
local cache = require("scripts.musicapi.cache")

local json = require("json")

MusicAPI.Mod = RegisterMod("MusicAPI", 1)
local mod = MusicAPI.Mod

mod.Manager = MusicManager()

--Callbacks that control the music flow. Callbacks assisting the actual API
--are still in api.lua.

--[[
TODO:
- Mineshaft escape
- Death cert crash
]]

-- Nami: STATE_MAUSOLEUM_HEART_KILLED isn't set fast enough.. have to hack it for now.
--		 Would be improved by giving bosses their own empty room themes too.
local earlyHeartAttack = false

local PostRender_State_JumpTable = { -- TAZ: Jump tables are used instead of having loads of elseifs. In theory, runs faster.
	Boss = function()
		if MusicAPI.State.Phase == 1 then
			if cache.Room:GetFrameCount() > 0 then
				MusicAPI.State.Phase = 2
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(2))
			end
		end
		
		if MusicAPI.State.Phase == 2 then
			if cache.CountBosses == 0 then
				local overJingle = "ROOM_BOSS_CLEAR"
				if earlyHeartAttack then
					overJingle = "ROOM_BOSS_CLEAR_NULL"
				end
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(3), overJingle)
				MusicAPI.ClearState()
			end
		end
	end,
	SatanBoss = function()
		if MusicAPI.State.Phase == 1 then
			if MusicAPI.State.Entity.StateFrame == 1 then
				MusicAPI.State.Phase = 2
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(2))
			end
		end
		
		if MusicAPI.State.Phase == 2 then
			if MusicAPI.State.Entity.StateFrame == 0 then
				MusicAPI.State.Phase = 3
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(3))
			end
		end
		
		if MusicAPI.State.Phase == 3 then
			if MusicAPI.State.Entity.StateFrame == 25 then
				MusicAPI.State.Phase = 4
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(4))
			end
		end
		
		if MusicAPI.State.Phase > 1 then
			if cache.CountBosses == 0 then
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(5), "ROOM_BOSS_CLEAR")
				MusicAPI.ClearState()
			end
		end
	end,
	MegaSatanBoss = function()
		if MusicAPI.State.Phase == 1 then
			if cache.Room:GetFrameCount() > 0 then
				MusicAPI.State.Phase = 2
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(2))
			end
		end
		
		if MusicAPI.State.Phase == 2 then
			if cache.Room:GetFrameCount() > 0 then
				for _, player in ipairs(Isaac.FindByType(1, 0)) do --TAZ: This is a bodge!
					if player.Position.Y < 540 then
						MusicAPI.State.Phase = 3
						MusicAPI.PlayTrack(MusicAPI.GetStateTrack(3))
						break
					end
				end
			end
		end
		
		if MusicAPI.State.Phase > 1 then
			if cache.CountBosses == 0 then
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(4), "ROOM_BOSS_CLEAR")
				MusicAPI.ClearState()
			end
		end
	end,
	DogmaBoss = function()
		if MusicAPI.State.Phase == 1 then
			if MusicAPI.State.Entity.State == 3 then
				MusicAPI.State.Phase = 2
			end
		end
		
		if MusicAPI.State.Phase == 2 then
			if cache.HUD:IsVisible() then
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(2))
				MusicAPI.State.Phase = 3
			end
		end
		
		if MusicAPI.State.Phase > 1 then
			if MusicAPI.State.Entity.State == 18 and MusicAPI.State.Entity.StateFrame > 80 then
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(3))
				MusicAPI.ClearState()
			end
		end
	end,
	AngelBoss = function()
		if MusicAPI.State.Phase == 1 then
			-- An angel statue has to be removed before the frame starts or
			-- the state will be cleared
			MusicAPI.ClearState()
		end
		
		if MusicAPI.State.Phase == 2 then
			if cache.CountBosses == 0 then
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(2), "ROOM_BOSS_CLEAR")
				MusicAPI.ClearState()
			end
		end
	end,
	Miniboss = function()
		if cache.CountBosses == 0 and cache.Room:IsClear() then
			MusicAPI.PlayTrack(MusicAPI.GetStateTrack(2), "ROOM_MINIBOSS_CLEAR")
			MusicAPI.ClearState()
		end
	end,
	Ambush = function()
		if MusicAPI.State.Phase == 1 then
			if cache.Room:IsAmbushActive() then
				MusicAPI.State.Phase = 2
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(1))
			end
		end
	
		if MusicAPI.State.Phase == 2 then
			if cache.Room:IsAmbushDone() then
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(2), MusicAPI.GetStateTrack(3))
				MusicAPI.ClearState()
			end
		end
	end,
	Greed = function()
		if MusicAPI.State.Phase == 0 then
			if not cache.Room:IsClear() then
				local waveNum = cache.Level.GreedModeWave
				local maxNum = cache.Game:GetGreedWavesNum()
				local bossNum = cache.Game:GetGreedBossWaveNum()
				if waveNum == maxNum then
					MusicAPI.PlayTrack(MusicAPI.GetStateTrack(5))
					MusicAPI.State.Phase = 3
				elseif waveNum >= bossNum then
					MusicAPI.PlayTrack(MusicAPI.GetStateTrack(3))
					MusicAPI.State.Phase = 2
				else
					if MusicAPI.GetStateTrack(1) then
						MusicAPI.PlayTrack(MusicAPI.GetStateTrack(1))
					end
					MusicAPI.State.Phase = 1
				end
			end
		end
		
		if MusicAPI.State.Phase == 1 then
			if cache.Room:IsClear() then
				MusicAPI.State.Phase = 0
				if MusicAPI.GetStateTrack(1) then
					MusicAPI.PlayTrack(MusicAPI.GetStateTrack(2), MusicAPI.GetStateTrack(6))
				end
			end
		end
		
		if MusicAPI.State.Phase == 2 then
			if cache.Room:IsClear() then
				MusicAPI.State.Phase = 0
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(4), MusicAPI.GetStateTrack(6))
			end
		end
		
		if MusicAPI.State.Phase == 3 then
			if cache.Room:IsClear() then
				MusicAPI.State.Phase = 0
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(6))
			end
		end
	end,
	UltraGreedPreBoss = function()
		if MusicAPI.State.Phase == 1 then
			if cache.CountBosses > 0 then
				MusicAPI.State.Phase = 2
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(1))
			end
		end
		
		if MusicAPI.State.Phase == 2 then
			if cache.CountBosses == 0 then
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(2), "ROOM_BOSS_CLEAR")
				MusicAPI.ClearState()
			end
		end
	end,
	UltraGreedBoss = function()
		if MusicAPI.State.Phase == 1 then
			if cache.Room:GetFrameCount() > 0 then
				MusicAPI.State.Phase = 2
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(2))
			end
		end
		
		if MusicAPI.State.Phase == 2 then
			if cache.Room:IsClear() then
				MusicAPI.PlayTrack(MusicAPI.GetStateTrack(3), "ROOM_BOSS_CLEAR")
				MusicAPI.ClearState()
			end
		end
	end,
}

local PostRender_MusicIDEqQueueID_JumpTable = {
	[Music.MUSIC_JINGLE_NIGHTMARE] = function()
		if cache.HUD:IsVisible() then
			MusicAPI.ReloadRoomTrack()
		end
	end,
	[Music.MUSIC_JINGLE_NIGHTMARE_ALT] = function()
		if cache.HUD:IsVisible() then
			MusicAPI.ReloadRoomTrack()
		end
	end,
}

mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	if MusicAPI.State then
		local j = PostRender_State_JumpTable[MusicAPI.State.Type]
		if j then j() end
	end
	
	if MusicAPI.Manager:GetCurrentMusicID() == MusicAPI.Manager:GetQueuedMusicID() then
		--This can happen in some situations where the game tries to control the music again
		local f = PostRender_MusicIDEqQueueID_JumpTable[MusicAPI.Manager:GetCurrentMusicID()]
		if f then
			f()
		else
			MusicAPI.Manager:Queue(Music.MUSIC_MUSICAPI_QUEUE_POP)
		end
	end
end)

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	MusicAPI.ReloadRoomTrack()

	MusicAPI.Doors = {}
	MusicAPI.Doors.Secret = {}
	MusicAPI.Doors.SuperSecret = {}
	
	for i=0,7 do
		local door = cache.Room:GetDoor(i)
		if door then
			if door.TargetRoomType == RoomType.ROOM_SECRET then
				if door:GetVariant() == DoorVariant.DOOR_HIDDEN then
					if cache.Level:GetRoomByIdx(door.TargetRoomIndex).VisitedCount == 0 then
						table.insert(MusicAPI.Doors.Secret, door)
					end
				end
			elseif door.TargetRoomType == RoomType.ROOM_SUPERSECRET then
				if door:GetVariant() == DoorVariant.DOOR_HIDDEN then
					if cache.Level:GetRoomByIdx(door.TargetRoomIndex).VisitedCount == 0 then
						table.insert(MusicAPI.Doors.SuperSecret, door)
					end
				end
			elseif door.TargetRoomType == RoomType.ROOM_ULTRASECRET then
				if cache.Level:GetRoomByIdx(door.TargetRoomIndex).VisitedCount == 0 and cache.Level:GetCurrentRoomDesc().VisitedCount == 1 then
					MusicAPI.PlayJingle("JINGLE_ULTRA_SECRET_ROOM")
				end
			elseif door.TargetRoomType == (RoomType.ROOM_SECRET_EXIT or 27) then
				if door:GetVariant() ~= DoorVariant.DOOR_UNLOCKED then
					if cache.Stage == LevelStage.STAGE3_2 and cache.StageType < StageType.STAGETYPE_REPENTANCE then
						MusicAPI.Doors.Strange = door
					end
				end
			end
		end
	end
	
	MusicAPI.MinesButton = nil
	if MusicAPI.Save.Game.MinesButtons then
		for i=1,cache.Room:GetGridSize() do
			local gridentity = cache.Room:GetGridEntity(i)
			if gridentity and gridentity:GetType() == GridEntityType.GRID_PRESSURE_PLATE and gridentity:GetVariant() == 3 then
				if gridentity.State ~= 3 then
					MusicAPI.MinesButton = gridentity
				end
				break
			end
		end
	end
end)

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, function()
	if cache.Stage == LevelStage.STAGE2_2 and (cache.StageType == StageType.STAGETYPE_REPENTANCE or cache.StageType == StageType.STAGETYPE_REPENTANCE_B) then
		MusicAPI.Save.Game.MinesButtons = {}
	else
		MusicAPI.Save.Game.MinesButtons = nil
	end
end)

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function(self)
	local doJingle = not (cache.Level:GetCanSeeEverything() or cache.COLLECTIBLE_XRAY_VISION)

	for i=#MusicAPI.Doors.Secret,1,-1 do
		local door = MusicAPI.Doors.Secret[i]
		if door:GetVariant() == DoorVariant.DOOR_UNLOCKED or door:GetVariant() == DoorVariant.DOOR_LOCKED_BARRED then
			table.remove(MusicAPI.Doors.Secret, i)
			if doJingle then
				MusicAPI.PlayJingle("JINGLE_SECRET_ROOM")
			end
		end
	end
	
	for i=#MusicAPI.Doors.SuperSecret,1,-1 do
		local door = MusicAPI.Doors.SuperSecret[i]
		if door:GetVariant() == DoorVariant.DOOR_UNLOCKED then
			table.remove(MusicAPI.Doors.SuperSecret, i)
			if doJingle then
				MusicAPI.PlayJingle("JINGLE_SUPER_SECRET_ROOM")
			end
		end
	end
	
	if MusicAPI.Doors.Strange then
		local door = MusicAPI.Doors.Strange
		if door:GetVariant() == DoorVariant.DOOR_UNLOCKED then
			MusicAPI.Doors.Strange = nil
			MusicAPI.PlayJingle("JINGLE_STRANGE_DOOR")
		end
	end
	
	if MusicAPI.MinesButton then
		if MusicAPI.MinesButton.State == 3 then
			MusicAPI.MinesButton = nil
			table.insert(MusicAPI.Save.Game.MinesButtons, cache.RoomDescriptor.SafeGridIndex)
			if #MusicAPI.Save.Game.MinesButtons == 3 then
				MusicAPI.PlayJingle("JINGLE_SECRET_ROOM")
			end
		end
	end
end)

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, function(self, ent) -- Dogma thinks
	if ent.Variant == 0 then
		if not MusicAPI.State then
			if ent.State == NpcState.STATE_APPEAR_CUSTOM then
				MusicAPI.StartDogmaBossState(true)
			end
		end
	end
end, EntityType.ENTITY_DOGMA)

mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, function(self, ent) -- Hush thinks
	if ent.Variant == 2 then
		MusicAPI.PlayTrack("BOSS_HUSH_FINAL")
	end
end, EntityType.ENTITY_ISAAC)


mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, function(self, ent) -- workaround for STATE_MAUSOLEUM_HEART_KILLED not being set early enough
	if cache.Stage == LevelStage.STAGE3_1 or cache.Stage == LevelStage.STAGE3_2
	and cache.StageType >= StageType.STAGETYPE_REPENTANCE then
		earlyHeartAttack = true
	end
end, EntityType.ENTITY_MOMS_HEART)

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function(self)
	earlyHeartAttack = false
end)

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, function(self, ent) -- Hush thinks
	if ent.I1 == 1 and ent.I2 == 0 then
		ent.I2 = 1 -- Nami: hackkkkk
		MusicAPI.PlayTrack("INTRO_MOTHERS_SHADOW")
		MusicAPI.QueueTrack("STATE_MINESHAFT_ESCAPE")
	end
end, EntityType.ENTITY_MOTHERS_SHADOW)

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, function(self, ent) -- Angel thinks
	if ent.Variant == 9 then
		if MusicAPI.State and MusicAPI.State.Type == "AngelBoss" and MusicAPI.State.Phase == 1 then
			MusicAPI.State.Phase = 2
			MusicAPI.PlayTrack(MusicAPI.GetStateTrack(1))
		end
	end
end, EntityType.ENTITY_EFFECT)

local function angelSpawnCallback(self, ent)
	if not MusicAPI.State then
		MusicAPI.StartAngelBossState()
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, angelSpawnCallback, EntityType.ENTITY_URIEL)
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, angelSpawnCallback, EntityType.ENTITY_GABRIEL)

mod:AddCallback(ModCallbacks.MC_POST_GAME_END, function(self, game_over)
	if game_over then
		MusicAPI.PlayTrack(MusicAPI.GetGameOverTrack())
	end
end)

mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, MusicAPI.PreGameStart)
