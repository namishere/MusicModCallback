if not REPENTANCE then return end

-- TODO:
--[[
	Update functions to leverage new API capabilities:
		Room:IsMirrorWorld()
		Room:HasCurseMist()
		Level:IsAscent()
	Mirror transition fade speed
	Jingles should use SFX:
		Treasure Room jingle
		Secret Room discover
		Strange Door jingle
	Shadow mom chase doesn't play jingle, only starts chase music when leaving room
		Fixed, but would like a NO_INTERRUPT tag
	Dark home is overriden by normal home theme
		Home theme restarts every room
]]--

include("scripts.dump")

Isaac.ConsoleOutput("Loading MusicAPI...\n")

local enums = require("scripts.musicapi.enums")
Music = enums.Music
MusicAPI = require("scripts.musicapi.api")
MusicAPI.Dev = require("scripts.musicapi.dev")
MMC = require("scripts.musicapi.legacy")

require("scripts.musicapi.gamecallbacks")

MusicAPI.ResetTracks()
MusicAPI.PreGameStart()

Isaac.ConsoleOutput("MusicAPI loaded successfully.\n")

local mod = RegisterMod("MusicAPI Debug Info", 1)

MusicAPI.ShowDebugInfo = true

mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	if MusicAPI.ShowDebugInfo then
		local current_track = MusicManager():GetCurrentMusicID()
		local queued_track = MusicManager():GetQueuedMusicID()
		local s1 = tostring(current_track)
		local s2 = tostring(queued_track)
		for a,b in pairs(Music) do
			if b == current_track then s1 = a end
			if b == queued_track then s2 = a end
		end
		local y = 50
		Isaac.RenderText("MusicManager Queue:", 50, y, 0.2, 0.2, 1.0, 1.0)
		y = y + 12
		Isaac.RenderText(s1, 50, y, 0.8, 0.8, 0.8, 1.0)
		y = y + 12
		Isaac.RenderText(s2, 50, y, 0.8, 0.8, 0.8, 1.0)
		y = y + 12
		Isaac.RenderText("MusicAPI Queue ("..#MusicAPI.Queue.."):", 50, y, 0.2, 0.2, 1.0, 1.0)
		y = y + 12
		for i=1,4 do
			local item = MusicAPI.Queue[i]
			if item then
				if type(item) ~= "string" then _G.B = item end
				Isaac.RenderText(tostring(item), 50, y, 0.8, 0.8, 0.8, 1.0)
			end
			y = y + 12
		end
		if MusicAPI.State then
			Isaac.RenderText("MusicAPI State:", 50, y, 0.2, 0.2, 1.0, 1.0)
			y = y + 12
			for a,b in pairs(MusicAPI.State) do
				Isaac.RenderText(tostring(a), 50, y, 1, 1, 1, 1.0)
				Isaac.RenderText(tostring(b), 100, y, 1, 1, 1, 1.0)
				y = y + 12
			end
		end
	end
end)

-- MusicAPI.AddOnPlayCallback(function(trigger_name, track_id)
	-- if MusicAPI.ShowDebugInfo then
		-- Isaac.ConsoleOutput("Now playing:\n Track: "..trigger_name.."\n ID: "..track_id.."\n")
	-- end
-- end)

-- MusicAPI.AddOnMusicCallback(function(track_name, music_id)
	-- if track_name == "ROOM_SHOP" then
		-- if Game():GetLevel():GetStageType() == StageType.STAGETYPE_REPENTANCE or Game():GetLevel():GetStageType() == StageType.STAGETYPE_REPENTANCE_B then
			-- return Music.MUSIC_MUSICAPI_DEMO_TRACK
		-- end
	-- end
-- end)

-- MusicAPI.TrackAddMusic("ROOM_TREASURE", Music.MUSIC_MUSICAPI_DEMO_TRACK)
-- MusicAPI.TrackAddMusic("ROOM_CURSE", Music.MUSIC_MUSICAPI_DEMO_TRACK)

-- MusicAPI.TrackAddMusic("JINGLE_TREASURE_ROOM", Music.MUSIC_MUSICAPI_DEMO_JINGLE_IN, Music.MUSIC_MUSICAPI_DEMO_JINGLE_OUT)
