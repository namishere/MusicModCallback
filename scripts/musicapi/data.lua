local data = {}

local floors = {}
data.Floors = floors

floors[LevelStage.STAGE1_1] = {
	[StageType.STAGETYPE_ORIGINAL] = "STAGE_BASEMENT",
	[StageType.STAGETYPE_WOTL] = "STAGE_CELLAR",
	[StageType.STAGETYPE_AFTERBIRTH] = "STAGE_BURNING_BASEMENT",
	[StageType.STAGETYPE_REPENTANCE] = "STAGE_DOWNPOUR",
	[StageType.STAGETYPE_REPENTANCE_B] = "STAGE_DROSS",
}

local floors_default = floors[LevelStage.STAGE1_1]

floors[LevelStage.STAGE1_2] = floors[LevelStage.STAGE1_1]

floors[LevelStage.STAGE2_1] = {
	[StageType.STAGETYPE_ORIGINAL] = "STAGE_CAVES",
	[StageType.STAGETYPE_WOTL] = "STAGE_CATACOMBS",
	[StageType.STAGETYPE_AFTERBIRTH] = "STAGE_FLOODED_CAVES",
	[StageType.STAGETYPE_REPENTANCE] = "STAGE_MINES",
	[StageType.STAGETYPE_REPENTANCE_B] = "STAGE_ASHPIT",
}

floors[LevelStage.STAGE2_2] = floors[LevelStage.STAGE2_1]

floors[LevelStage.STAGE3_1] = {
	[StageType.STAGETYPE_ORIGINAL] = "STAGE_DEPTHS",
	[StageType.STAGETYPE_WOTL] = "STAGE_NECROPOLIS",
	[StageType.STAGETYPE_AFTERBIRTH] = "STAGE_DANK_DEPTHS",
	[StageType.STAGETYPE_REPENTANCE] = "STAGE_MAUSOLEUM",
	[StageType.STAGETYPE_REPENTANCE_B] = "STAGE_GEHENNA",
}	

floors[LevelStage.STAGE3_2] = floors[LevelStage.STAGE3_1]

floors[LevelStage.STAGE4_1] = {
	[StageType.STAGETYPE_ORIGINAL] = "STAGE_WOMB",
	[StageType.STAGETYPE_WOTL] = "STAGE_UTERO",
	[StageType.STAGETYPE_AFTERBIRTH] = "STAGE_SCARRED_WOMB",
	[StageType.STAGETYPE_REPENTANCE] = "STAGE_CORPSE",
	[StageType.STAGETYPE_REPENTANCE_B] = "STAGE_MORTIS",
}

floors[LevelStage.STAGE4_2] = floors[LevelStage.STAGE4_1]

floors[LevelStage.STAGE4_3] = {
	[StageType.STAGETYPE_ORIGINAL] = "STAGE_BLUE_WOMB",
}

floors[LevelStage.STAGE5] = {
	[StageType.STAGETYPE_ORIGINAL] = "STAGE_SHEOL",
	[StageType.STAGETYPE_WOTL] = "STAGE_CATHEDRAL",
	[StageType.STAGETYPE_AFTERBIRTH] = "STAGE_DARK_ROOM",
}

floors[LevelStage.STAGE6] = {
	[StageType.STAGETYPE_ORIGINAL] = "STAGE_DARK_ROOM",
	[StageType.STAGETYPE_WOTL] = "STAGE_CHEST",
}

floors[LevelStage.STAGE7] = {
	[StageType.STAGETYPE_ORIGINAL] = "STAGE_VOID",
}

floors[LevelStage.STAGE8] = {
	[StageType.STAGETYPE_ORIGINAL] = "STAGE_HOME",
	[StageType.STAGETYPE_WOTL] = "STAGE_HOME",
}

local floors_dim1 = {}
data.FloorsAlternate = floors_dim1

floors_dim1[LevelStage.STAGE1_2] = {
	[StageType.STAGETYPE_REPENTANCE] = "STAGE_MIRROR_DOWNPOUR",
	[StageType.STAGETYPE_REPENTANCE_B] = "STAGE_MIRROR_DROSS",
}

floors_dim1[LevelStage.STAGE2_2] = {
	[StageType.STAGETYPE_REPENTANCE] = "STAGE_MINESHAFT_AMBIENT",
	[StageType.STAGETYPE_REPENTANCE_B] = "STAGE_MINESHAFT_AMBIENT",
}

local floors_greed = {}
data.FloorsGreed = floors_greed

floors_greed[LevelStage.STAGE1_GREED] = floors[LevelStage.STAGE1_1]
floors_greed[LevelStage.STAGE2_GREED] = floors[LevelStage.STAGE2_1]
floors_greed[LevelStage.STAGE3_GREED] = floors[LevelStage.STAGE3_1]
floors_greed[LevelStage.STAGE4_GREED] = floors[LevelStage.STAGE4_1]
floors_greed[LevelStage.STAGE5_GREED] = floors[LevelStage.STAGE5]

floors_greed[LevelStage.STAGE6_GREED] = {
	[StageType.STAGETYPE_ORIGINAL] = "STAGE_SHOP",
}

floors_greed[LevelStage.STAGE7_GREED] = floors_greed[LevelStage.STAGE6_GREED]

local greed_themes = {}
data.GreedThemes = greed_themes

greed_themes[LevelStage.STAGE6_GREED] = "GREED_ACTIVE"

local greed_theme_outros = {}
data.GreedThemeOutros = greed_theme_outros

greed_theme_outros[LevelStage.STAGE6_GREED] = "JINGLE_GREED_CLEAR"

local bosses = {}
data.Bosses = bosses

bosses[6] = "BOSS_MOM"
bosses[8] = "BOSS_MOMS_HEART"
bosses[25] = "BOSS_IT_LIVES"
bosses[24] = "BOSS_SATAN"
bosses[39] = "BOSS_ISAAC"
bosses[40] = "BOSS_BLUE_BABY"
bosses[54] = "BOSS_LAMB"
bosses[55] = "BOSS_SATAN"
bosses[62] = "BOSS_ULTRA_GREED"
bosses[63] = "BOSS_HUSH_FIRST"
bosses[70] = "BOSS_DELIRIUM"
bosses[88] = "BOSS_MOTHER"

--SPECIAL CASES: IF TRIGGERS DIFFER PER FLOOR
-- Nami: eh. hack
bosses[8 + (LevelStage.STAGE3_1 << 16)] = "BOSS_MOMS_HEART_MAUSOLEUM"
bosses[8 + (LevelStage.STAGE3_2 << 16)] = "BOSS_MOMS_HEART_MAUSOLEUM"

local bossJingles = {}
data.BossJingles = bossJingles

local bossClearJingles = {}
data.BossClearJingles = bossClearJingles

bossClearJingles[8 + (LevelStage.STAGE3_1 << 16)] = "API_NOTHING"
bossClearJingles[8 + (LevelStage.STAGE3_2 << 16)] = "API_NOTHING"

local rooms = {}
data.Rooms = rooms

-- rooms[RoomType.ROOM_NULL] = "ROOM_NULL"
-- rooms[RoomType.ROOM_DEFAULT] = "ROOM_DEFAULT"
rooms[RoomType.ROOM_SHOP] = "ROOM_SHOP"
rooms[RoomType.ROOM_ERROR] = "ROOM_ERROR"
-- rooms[RoomType.ROOM_TREASURE] = "ROOM_TREASURE"
-- rooms[RoomType.ROOM_BOSS] = "ROOM_BOSS"
rooms[RoomType.ROOM_MINIBOSS] = "ROOM_BOSS_CLEAR"
rooms[RoomType.ROOM_SECRET] = "ROOM_SECRET"
rooms[RoomType.ROOM_SUPERSECRET] = "ROOM_SUPER_SECRET"
rooms[RoomType.ROOM_ARCADE] = "ROOM_ARCADE"
rooms[RoomType.ROOM_CURSE] = "ROOM_CURSE"
-- rooms[RoomType.ROOM_CHALLENGE] = "ROOM_CHALLENGE"
rooms[RoomType.ROOM_LIBRARY] = "ROOM_LIBRARY"
rooms[RoomType.ROOM_SACRIFICE] = "ROOM_SACRIFICE"
rooms[RoomType.ROOM_DEVIL] = "ROOM_DEVIL"
rooms[RoomType.ROOM_ANGEL] = "ROOM_ANGEL"
rooms[RoomType.ROOM_DUNGEON] = "ROOM_DUNGEON"
rooms[RoomType.ROOM_BOSSRUSH] = "ROOM_BOSSRUSH"
rooms[RoomType.ROOM_ISAACS] = "ROOM_ISAACS"
rooms[RoomType.ROOM_BARREN] = "ROOM_BARREN"
rooms[RoomType.ROOM_CHEST] = "ROOM_CHEST"
rooms[RoomType.ROOM_DICE] = "ROOM_DICE"
rooms[RoomType.ROOM_BLACK_MARKET] = "ROOM_BLACK_MARKET"
rooms[RoomType.ROOM_GREED_EXIT] = "ROOM_GREED_EXIT"
rooms[RoomType.ROOM_PLANETARIUM] = "ROOM_PLANETARIUM"
rooms[RoomType.ROOM_TELEPORTER] = "ROOM_TELEPORTER"
rooms[RoomType.ROOM_TELEPORTER_EXIT] = "ROOM_TELEPORTER_EXIT"
rooms[RoomType.ROOM_SECRET_EXIT or 27] = "ROOM_SECRET_EXIT"
rooms[RoomType.ROOM_BLUE or 28] = "ROOM_BLUE"
rooms[RoomType.ROOM_ULTRASECRET] = "ROOM_ULTRA_SECRET"

local gridrooms = {}
data.GridRooms = gridrooms

gridrooms[GridRooms.ROOM_ROTGUT_DUNGEON1_IDX] = "BOSS_REPENTANCE"
gridrooms[GridRooms.ROOM_ROTGUT_DUNGEON2_IDX] = "BOSS_REPENTANCE"

local floors_rand = {}
data.FloorsRand = floors_rand

floors_rand[1] = "STAGE_NULL"
floors_rand[2] = "STAGE_BASEMENT"
floors_rand[3] = "STAGE_CELLAR"
floors_rand[4] = "STAGE_BURNING_BASEMENT"
floors_rand[5] = "STAGE_DOWNPOUR"
floors_rand[6] = "STAGE_DROSS"
floors_rand[7] = "STAGE_CAVES"
floors_rand[8] = "STAGE_CATACOMBS"
floors_rand[9] = "STAGE_FLOODED_CAVES"
floors_rand[10] = "STAGE_MINES"
floors_rand[11] = "STAGE_ASHPIT"
floors_rand[12] = "STAGE_DEPTHS"
floors_rand[13] = "STAGE_NECROPOLIS"
floors_rand[14] = "STAGE_DANK_DEPTHS"
floors_rand[15] = "STAGE_MAUSOLEUM"
floors_rand[16] = "STAGE_GEHENNA"
floors_rand[17] = "STAGE_WOMB"
floors_rand[18] = "STAGE_UTERO"
floors_rand[19] = "STAGE_SCARRED_WOMB"
floors_rand[20] = "STAGE_CORPSE"
floors_rand[21] = "STAGE_MORTIS"
floors_rand[22] = "STAGE_BLUE_WOMB"
floors_rand[23] = "STAGE_SHEOL"
floors_rand[24] = "STAGE_CATHEDRAL"
floors_rand[25] = "STAGE_DARK_ROOM"
floors_rand[26] = "STAGE_CHEST"
floors_rand[27] = "STAGE_VOID"

return data
