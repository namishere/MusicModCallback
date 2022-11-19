local MusicAPI = require "scripts.musicapi.api"

local legacy = {} --DON'T USE ANY FUNCTIONS IN THIS FILE: FOR VERSION 1,2 BACKWARDS COMPATABILITY ONLY!

legacy.AddMusicCallback = MusicAPI.AddLegacyCallback

function legacy.GetMusicTrack()
	return MusicAPI.GetTrackMusic(MusicAPI.GetRoomTrack())
end

function legacy.GetBossTrack()
	return MusicAPI.GetTrackMusic(MusicAPI.GetBossTrack())
end

function legacy.GetGenericBossTrack()
	return MusicAPI.GetTrackMusic(MusicAPI.GetGenericBossTrack())
end

function legacy.GetStageTrack()
	return MusicAPI.GetTrackMusic(MusicAPI.GetStageTrack())
end

function legacy.Manager()
	return MusicAPI.Manager
end

legacy.Initialised = true

return legacy
