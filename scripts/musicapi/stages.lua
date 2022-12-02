local stagetable = require "scripts.musicapi.enums.stages"
local leveltable = require "scripts.musicapi.enums.levels"
print("I exist!")

function MusicAPI._priv.IsBaseStage(stageType, ...)
	local level = MusicAPI.shared.game:GetLevel()
	local stage = level:GetStage()
	local stages = {...}
	if level:GetStageType() == stageType and not (StageAPI and StageAPI.InNewStage()) then
		for i=1, #stages do
			if stages[1] == stage then return true end
		end
	end
	return false
end

function MusicAPI._priv.IsCustomStage(name)
	return StageAPI and StageAPI.GetCurrentStage() == name
end

function MusicAPI.GetStageName(stage, stageType)
    if StageAPI and StageAPI.GetCurrentStage() ~= nil then
		return StageAPI.GetCurrentStage().Name
    else
		local level = MusicAPI.shared.game:GetLevel()
		if stage == nil then stage = level:GetAbsoluteStage() end
		if stageType == nil then stageType = level:GetStageType() end
		if leveltable[stage][stageType] ~= nil then
			return leveltable[stage][stageType]
		end
	end
	MusicAPI.error("MusicAPI.GetStageName(): couldn't find a Stage with LevelStage "..stage.." and StageType "..stageType.."!")
end

function MusicAPI.GetStage(arg1, arg2)
	local string = nil
	if type(arg1) == "number" and type(arg2) == number then
		string = MusicAPI.GetStageName(arg1, arg2)
	elseif type(arg1) == "string" then
		string = arg1
	elseif arg1 == nil then
		string = MusicAPI.GetStageName()
	end

	if MusicAPI.Stages[string] ~= nil then
		return MusicAPI.Stages[string]
	end

	MusicAPI.error("MusicAPI.GetStage(): Stage \"".. tostring(string).."\" not registered!")
end

function MusicAPI._priv.RegisterStages()
	for k,v in pairs(stagetable) do
		MusicAPI.Stages[k] = MusicAPI.Stage(k, v.IsCurrentStage, v.Tracks)
	end
end

function MusicAPI.RegisterStage(name, func, tracks)
	MusicAPI.Stages[name] = MusicAPI.Stage(name, func, tracks)
end

function MusicAPI.ResetStage(arg1, arg2)
	local string = nil
	if type(arg1) == "number" and type(arg2) == number then
		string = MusicAPI.GetStageName(arg1, arg2)
	elseif type(arg1) == "string" then
		string = arg1
	elseif arg1 == nil then
		string = MusicAPI.GetStageName()
	end

	if MusicAPI.Stages[string] ~= nil then
		MusicAPI.Stages[name] = MusicAPI.Default.Stages[name]
	end

	MusicAPI.error("MusicAPI.ResetStage(): Stage \"".. tostring(string).."\" not registered!")
end

function MusicAPI.ResetStages()
	MusicAPI.Stages = MusicAPI.Default.Stages
end
