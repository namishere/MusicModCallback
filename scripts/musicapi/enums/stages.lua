return {
	["Basement"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_ORIGINAL, LevelStage.STAGE1_1, LevelStage.STAGE1_2) end,
		Tracks = {
			Stage = "STAGE_BASEMENT"
		}
	},
	["Cellar"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_WOTL, LevelStage.STAGE1_1, LevelStage.STAGE1_2) end,
		Tracks = {
			Stage = "STAGE_CELLAR"
		}
	},
	["Burning Basement"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_AFTERBIRTH, LevelStage.STAGE1_1, LevelStage.STAGE1_2) end,
		Tracks = {
			Stage = "STAGE_BURNING_BASEMENT"
		}
	},
	["Downpour"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_REPENTANCE, LevelStage.STAGE1_1, LevelStage.STAGE1_2) end,
		Tracks = {
			Stage = "STAGE_DOWNPOUR",
			Boss = BossRepentanceGeneric
		}
	},
	["Dross"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_REPENTANCE_B, LevelStage.STAGE1_1, LevelStage.STAGE1_2) end,
		Tracks = {
			Stage = "STAGE_DROSS",
			Boss = BossRepentanceGeneric
		}
	},

	["Caves"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_ORIGINAL, LevelStage.STAGE2_1, LevelStage.STAGE2_2) end,
		Tracks = {
			Stage = "STAGE_CAVES"
		}
	},
	["Catacombs"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_WOTL, LevelStage.STAGE2_1, LevelStage.STAGE2_2) end,
		Tracks = {
			Stage = "STAGE_CATACOMBS"
		}
	},
	["Flooded Caves"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_AFTERBIRTH, LevelStage.STAGE2_1, LevelStage.STAGE2_2) end,
		Tracks = {
			Stage = "STAGE_FLOODED_CAVES"
		}
	},
	["Mines"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_REPENTANCE, LevelStage.STAGE2_1, LevelStage.STAGE2_2) end,
		Tracks = {
			Stage = "STAGE_MINES",
			Boss = BossRepentanceGeneric
		}
	},
	["Ashpit"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_REPENTANCE_B, LevelStage.STAGE2_1, LevelStage.STAGE2_2) end,
		Tracks = {
			Stage = "STAGE_ASHPIT",
			Boss = BossRepentanceGeneric
		}
	},

	["Depths"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_ORIGINAL, LevelStage.STAGE3_1, LevelStage.STAGE3_2) end,
		Tracks = {
			Stage = "STAGE_DEPTHS"
		}
	},
	["Necropolis"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_WOTL, LevelStage.STAGE3_1, LevelStage.STAGE3_2) end,
		Tracks = {
			Stage = "STAGE_NECROPOLIS"
		}
	},
	["Dank Depths"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_AFTERBIRTH, LevelStage.STAGE3_1, LevelStage.STAGE3_2) end,
		Tracks = {
			Stage = "STAGE_DANK_DEPTHS"
		}
	},
	["Mausoleum"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_REPENTANCE, LevelStage.STAGE3_1, LevelStage.STAGE3_2) end,
		Tracks = {
			Stage = "STAGE_MAUSOLEUM",
			Boss = BossRepentanceGeneric
		}
	},
	["Gehenna"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_REPENTANCE_B, LevelStage.STAGE3_1, LevelStage.STAGE3_2) end,
		Tracks = {
			Stage = "STAGE_GEHENNA",
			Boss = BossRepentanceGeneric
		}
	},

	["Womb"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_ORIGINAL, LevelStage.STAGE4_1, LevelStage.STAGE4_2) end,
		Tracks = {
			Stage = "STAGE_WOMB"
		}
	},
	["Utero"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_WOTL, LevelStage.STAGE4_1, LevelStage.STAGE4_2) end,
		Tracks = {
			Stage = "STAGE_UTERO"
		}
	},
	["Scarred Womb"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_AFTERBIRTH, LevelStage.STAGE4_1, LevelStage.STAGE4_2) end,
		Tracks = {
			Stage = "STAGE_SCARRED_WOMB"
		}
	},
	["Corpse"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_REPENTANCE, LevelStage.STAGE4_1, LevelStage.STAGE4_2) end,
		Tracks = {
			Stage = "STAGE_CORPSE",
			Boss = BossRepentanceGeneric
		}
	},
	["Mortis"] = {
		IsCurrentStage = function() return StageAPI and StageAPI.GetCurrentStage() == "Mortis" end,
		Tracks = {
			Stage = "STAGE_MORTIS",
			Boss = BossRepentanceGeneric
		}
	},

	["Blue Womb"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_ORIGINAL, LevelStage.STAGE4_3) end,
		Tracks = {
			Stage = "STAGE_BLUE_WOMB",
			Rooms = { ["AllRooms"] = "STAGE_BLUE_WOMB" }
		}
	},

	["Sheol"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_ORIGINAL, LevelStage.STAGE5) end,
		Tracks = {
			Stage = "STAGE_SHEOL"
		}
	},
	["Cathedral"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_WOTL, LevelStage.STAGE5) end,
		Tracks = {
			Stage = "STAGE_CATHEDRAL"
		}
	},

	["Dark Room"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_ORIGINAL, LevelStage.STAGE6) end,
		Tracks = {
			Stage = "STAGE_DARK_ROOM"
		}
	},
	["Chest"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_WOTL, LevelStage.STAGE6) end,
		Tracks = {
			Stage = "STAGE_CHEST"
		}
	},

	["The Void"] = {
		IsCurrentStage = function() return MusicAPI._priv.IsBaseStage(StageType.STAGETYPE_ORIGINAL, LevelStage.STAGE7) end,
		Tracks = {
			Stage = "STAGE_VOID"
		}
	},

	["Home"] = {
		IsCurrentStage = function()
					return game:GetLevel():GetStage() == LevelStage.STAGE8
					and not (StageAPI and StageAPI.InNewStage())
				  end,
		Tracks = {
			Stage = "STAGE_HOME"
		}
	},

	["The Shop"] = {
		IsCurrentStage = function()
					return game:GetLevel():GetStage() == LevelStage.STAGE6_GREED
					and game:IsGreedMode() and not (StageAPI and StageAPI.InNewStage())
				  end,
		Tracks = {
			Stage = "STAGE_SHOP"
		}
	},

	["Ultra Greed"] = {
		IsCurrentStage = function()
					return game:GetLevel():GetStage() == LevelStage.STAGE7_GREED
					and game:IsGreedMode() and not (StageAPI and StageAPI.InNewStage())
				  end,
		Tracks = {
			Stage = "STAGE_SHOP"
		}
	}
}
