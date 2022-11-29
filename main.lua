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

if MusicAPI.debug then
	require "scripts.dump"
end

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

function MusicAPI.Error(string)
	error("[MusicAPI] "..string)
end

function MusicAPI.Merged(...)
    local t = {}
    for _, tbl in ipairs({...}) do
        local orderedIndices = {}
        for i, v in ipairs(tbl) do
            orderedIndices[i] = true
            t[#t + 1] = v
        end

        for k, v in pairs(tbl) do
            if not orderedIndices[k] then
                t[k] = v
            end
        end
    end

    return t
end

require "scripts.musicapi.class"
require "scripts.musicapi.stages"
require "scripts.musicapi.rooms"
