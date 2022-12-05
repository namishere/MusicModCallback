local baseMod = RegisterMod("MusicAPI", 1)

MusicAPI = { _priv = {} }
MusicAPI.shared = { mod = baseMod, game = Game() }
MusicAPI.debug = true
MusicAPI.echoLog = true
MusicAPI.Default = {
	Stages = {},
	Rooms = {},
	Tracks = {}
}

function MusicAPI.LogMajor(string)
	print("[MusicAPI] "..string)
	Isaac.DebugString(string)
end

function MusicAPI.LogMinor(string)
	Isaac.DebugString(string)
	if MusicAPI.echoLog then
		print("[MusicAPI] "..string)
	end
end

function MusicAPI.DeepCopy(tbl)
    local t = {}
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            t[k] = MusicAPI.DeepCopy(v)
        else
            t[k] = v
        end
    end

    return t
end

require "scripts.dump"
--require "scripts.musicapi.class"
require "scripts.musicapi.stages"
require "scripts.musicapi.rooms"
