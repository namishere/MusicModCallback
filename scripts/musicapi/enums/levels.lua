local LevelTable = {
	[LevelStage.STAGE1_1] = {
		[StageType.STAGETYPE_ORIGINAL] = "Basement",
		[StageType.STAGETYPE_WOTL] = "Cellar",
		[StageType.STAGETYPE_AFTERBIRTH] = "Burning Basement",
		[StageType.STAGETYPE_REPENTANCE] = "Downpour",
		[StageType.STAGETYPE_REPENTANCE_B] = "Dross"
	},
	[LevelStage.STAGE2_1] = {
		[StageType.STAGETYPE_ORIGINAL] = "Caves",
		[StageType.STAGETYPE_WOTL] = "Catacombs",
		[StageType.STAGETYPE_AFTERBIRTH] = "Flooded Caves",
		[StageType.STAGETYPE_REPENTANCE] = "Mines",
		[StageType.STAGETYPE_REPENTANCE_B] = "Ashpit"
	},
	[LevelStage.STAGE3_1] = {
		[StageType.STAGETYPE_ORIGINAL] = "Depths",
		[StageType.STAGETYPE_WOTL] = "Necropolis",
		[StageType.STAGETYPE_AFTERBIRTH] = "Dank Depths",
		[StageType.STAGETYPE_REPENTANCE] = "Mausoleum",
		[StageType.STAGETYPE_REPENTANCE_B] = "Gehenna"
	},
	[LevelStage.STAGE4_1] = {
		[StageType.STAGETYPE_ORIGINAL] = "Womb",
		[StageType.STAGETYPE_WOTL] = "Utero",
		[StageType.STAGETYPE_AFTERBIRTH] = "Scarred Womb",
		[StageType.STAGETYPE_REPENTANCE] = "Corpse",
		[StageType.STAGETYPE_REPENTANCE_B] = "Mortis" --don't know if this will actually be useful
	},
	[LevelStage.STAGE4_3] = {
		[StageType.STAGETYPE_ORIGINAL] = "Blue Womb" --for identification purposes
	},
	[LevelStage.STAGE5] = {
		[StageType.STAGETYPE_ORIGINAL] = "Sheol",
		[StageType.STAGETYPE_WOTL] = "Cathedral"
	},
	[LevelStage.STAGE6] = {
		[StageType.STAGETYPE_ORIGINAL] = "Dark Room",
		[StageType.STAGETYPE_WOTL] = "Chest"
	},
	[LevelStage.STAGE7] = {
		[StageType.STAGETYPE_ORIGINAL] = "The Void"
	},
	[LevelStage.STAGE8] = {
		[StageType.STAGETYPE_ORIGINAL] = "Home",
		[StageType.STAGETYPE_WOTL] = "Home"
	},

	[LevelStage.STAGE5_GREED] = {
		[StageType.STAGETYPE_ORIGINAL] = "Sheol"
	},
	[LevelStage.STAGE6_GREED] = {
		[StageType.STAGETYPE_ORIGINAL] = "The Shop"
	},
	[LevelStage.STAGE7_GREED] = {
		[StageType.STAGETYPE_ORIGINAL] = "Ultra Greed"
	}
}
LevelTable[LevelStage.STAGE1_2] = LevelTable[LevelStage.STAGE1_1]
LevelTable[LevelStage.STAGE2_2] = LevelTable[LevelStage.STAGE2_1]
LevelTable[LevelStage.STAGE3_2] = LevelTable[LevelStage.STAGE3_1]
LevelTable[LevelStage.STAGE4_2] = LevelTable[LevelStage.STAGE4_1]
LevelTable[LevelStage.STAGE1_GREED] = LevelTable[LevelStage.STAGE1_1]
LevelTable[LevelStage.STAGE2_GREED] = LevelTable[LevelStage.STAGE2_1]
LevelTable[LevelStage.STAGE3_GREED] = LevelTable[LevelStage.STAGE3_1]
LevelTable[LevelStage.STAGE4_GREED] = LevelTable[LevelStage.STAGE4_1]

return LevelTable
