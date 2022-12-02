--local shared = require("scripts.MusicAPI.shared")

-- Classes

-- Classes doc annotations for constructors are done
-- using a placeholder function that will be replaced
-- immediately after by the actual class object, to make
-- the job of the Lua language server easier

---@param Type string
---@param AllowMultipleInit? boolean
---@return MusicAPIClass
function MusicAPI.Class(Type, AllowMultipleInit)
end

---@class MusicAPIClass
---@field Type string
---@field private AllowMultipleInit number
---@field private Initialized boolean
---@field protected Init fun(self: MusicAPIClass, ...: any)
---@field protected PostInit fun(self: MusicAPIClass, ...: any)
---@field protected InheritInit fun(self: MusicAPIClass, ...: any)
MusicAPI.Class = {}

function MusicAPI.ClassInit(tbl, ...)
    local inst = {}
    setmetatable(inst, tbl)
    tbl.__index = tbl
    tbl.__call = MusicAPI.ClassInit

    if inst.AllowMultipleInit or not inst.Initialized then
        inst.Initialized = true
        if inst.Init then
            inst:Init(...)
        end

        if inst.PostInit then
            inst:PostInit(...)
        end
    else
        if inst.InheritInit then
            inst:InheritInit(...)
        end
    end

    return inst
end

function MusicAPI.Class:Init(Type, AllowMultipleInit)
    self.Type = Type
    self.AllowMultipleInit = AllowMultipleInit
    self.Initialized = false
end

setmetatable(MusicAPI.Class, {
    ---@generic C : MusicAPIClass
    ---@param self C
    ---@return C
    __call = MusicAPI.ClassInit
})

MusicAPI.TrackDefault = {}
MusicAPI.Track = MusicAPI.Class("Track")
function MusicAPI.Track:Init(tbl)
	self.Id = tbl.Id
	self.Name = tbl.Name
	self.Music = tbl.Music
	self.Sound = tbl.Sound
	self.Persistence = tbl.Persistence
	self.Tags = tbl.Tags
	self.FadeSpeed = tbl.FadeSpeed or 0.08
	self.FadeLength = tbl.FadeLength or 0
end

--[[
local LevelTracksGeneric = {
	Stage = "STAGE_NULL",
	Rooms = MusicAPI.RoomTracksGeneric,
	Challenge = MusicAPI.ChallengeGeneric,
	BossChallenge = MusicAPI.BossChallengeGeneric,
	Boss = MusicAPI.BossGeneric,
	Miniboss = MusicAPI.MinibossGeneric
}
]]--

MusicAPI.Stages = {}
MusicAPI.Stage = MusicAPI.Class("Stage")
function MusicAPI.Stage:Init(name, stageFunc, tracks)
	MusicAPI.assert(name, "MusicAPI.Stage:Init(): Must provide a name to init a stage!")

	self.IsCurrentStage = stageFunc or function() return false end
	self.Tracks = {}
	if tracks ~= nil then
		self.Tracks = tracks
	end
	MusicAPI.Default.Stages[name] = self
end
