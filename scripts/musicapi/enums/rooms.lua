local rooms = {
	["AllRooms"] = -1,
	--[RoomType.ROOM_NULL] = "ROOM_NULL",
	[RoomType.ROOM_DEFAULT] = "API_STAGE",
	[RoomType.ROOM_SHOP] = "ROOM_SHOP",
	[RoomType.ROOM_ERROR] = "ROOM_ERROR",
	[RoomType.ROOM_TREASURE] = "ROOM_TREASURE",
	[RoomType.ROOM_BOSS] = "API_BOSS",
	[RoomType.ROOM_MINIBOSS] = "API_BOSS",
	[RoomType.ROOM_SECRET] = "ROOM_SECRET",
	[RoomType.ROOM_SUPERSECRET] = "ROOM_SUPERSECRET",
	[RoomType.ROOM_ARCADE] = "ROOM_ARCADE",
	[RoomType.ROOM_CURSE] = "ROOM_CURSE",
	[RoomType.ROOM_CHALLENGE] = "API_STAGE",
	[RoomType.ROOM_LIBRARY] = "ROOM_LIBRARY",
	[RoomType.ROOM_SACRIFICE] = "ROOM_SACRIFICE",
	[RoomType.ROOM_DEVIL] = "ROOM_DEVIL",
	[RoomType.ROOM_ANGEL] = "ROOM_ANGEL",
	[RoomType.ROOM_DUNGEON] = "ROOM_DUNGEON",
	[RoomType.ROOM_BOSSRUSH] = "API_STAGE",
	[RoomType.ROOM_ISAACS] = "ROOM_ISAACS",
	[RoomType.ROOM_BARREN] = "ROOM_BARREN",
	[RoomType.ROOM_CHEST] = "ROOM_CHEST",
	[RoomType.ROOM_DICE] = "ROOM_DICE",
	[RoomType.ROOM_BLACK_MARKET] = "ROOM_BLACK_MARKET",
	[RoomType.ROOM_GREED_EXIT] = "ROOM_GREED_EXIT",
	[RoomType.ROOM_PLANETARIUM] = "ROOM_PLANETARIUM",
	[RoomType.ROOM_TELEPORTER] = "ROOM_TELEPORTER",
	[RoomType.ROOM_TELEPORTER_EXIT] = "ROOM_TELEPORTER_EXIT",
	[RoomType.ROOM_SECRET_EXIT] = "ROOM_SECRET_EXIT",
	[RoomType.ROOM_BLUE] = "ROOM_BLUE",
	[RoomType.ROOM_ULTRASECRET] = "ROOM_ULTRA_SECRET",

	-- Grid Rooms
	["GideonDungeon"] = "ROOM_GIDEON_DUNGEON",
	["GenesisRoom"] = "ROOM_GENESIS",
	["SecretShop"] = "ROOM_SECRET_SHOP",
	["AngelShop"] = "ROOM_ANGEL_SHOP"
}

local challenge = {
	Inactive = "ROOM_CHALLENGE_NORMAL_INACTIVE",
	Active = "ROOM_CHALLENGE_ACTIVE",
	OverJingle = "JINGLE_CHALLENGE_BOSS_CLEAR",
	Empty = "ROOM_CHALLENGE_NORMAL_CLEAR"
}
local bosschallenge = {
	Inactive = "ROOM_CHALLENGE_BOSS_INACTIVE",
	Active = "ROOM_CHALLENGE_BOSS_ACTIVE",
	OverJingle = "JINGLE_CHALLENGE_BOSS_CLEAR",
	Empty = "ROOM_CHALLENGE_BOSS_CLEAR"
}
local boss = {
	StartJingle = "JINGLE_BOSS_GENERIC",
	Active = "BOSS_GENERIC",
	OverJingle = "JINGLE_BOSS_GENERIC_OVER",
	Empty = "BOSS_GENERIC_EMPTY"
}
local bossRepentance = {
	StartJingle = "JINGLE_BOSS_REPENTANCE",
	Active = "BOSS_REPENTANCE",
	OverJingle = "JINGLE_BOSS_REPENTANCE_OVER",
	Empty = "BOSS_REPENTANCE_EMPTY"
}
local miniboss = {
	Active = "MINIBOSS_GENERIC",
	OverJingle = "JINGLE_MINIBOSS_GENERIC_OVER",
	Empty = "MINIBOSS_GENERIC_EMPTY"
}
local bossrush = {
	Inactive = "ROOM_BOSS_RUSH_INACTIVE",
	Active = "ROOM_BOSS_RUSH_ACTIVE",
	Empty = "ROOM_BOSS_RUSH_CLEAR"
}

return {GenericRooms = rooms, GenericChallenge = challenge, GenericBossChallenge = bosschallenge, GenericBoss = boss, GenericBossRepentance = bossRepentance, GenericMiniboss = miniboss, GenericBossRush = bossrush}
