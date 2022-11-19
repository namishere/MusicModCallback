local enums = include "scripts.musicapi.enums"
local Music = enums.Music
local Sound = enums.Sound

--[[
Music tracks will replace (or supplement) normal Music ids.

With the current API, you can only check for a Music id and replace it without any context.
This should rectify that, making Music replacements for specific scenarios easier, (Eg. Mega
Satan, Hush stage 1) especially where Music is reused. This also allows mods to simply disable
Music Tags, for example JINGLE_BOSS, so that no boss jingles ever play, jumping straight into
the boss theme (TODO). 

This mostly affects Soundtrack Menu. As of right now, it has a special case for Mega Satan, but
this update should make it so that no special cases are needed at all.

If you have a surplus of Music from another source to put into Isaac, you can use this Music
system to add separate tracks to Basement I and Basement II for example rather than add it to
the entire Basement, if you want.
Conversely, if you do not have enough Music, you can make tracks simply not play or redirect to
other tracks. For example: Have one track cover all boss Music by looking for the "BOSS" tag.

The "REPENTANCE" tag is added to all repentance tracks. If there was a Music mod from Afterbirth+
that you would like to convert into a repentance soundtrack, you can use this tag to determine
if the Music will be replaced successfully or not, and it can be redirected.

Persistence:
1 - If a Persistence 1 jingle is playing with a track queued after it, and you attempt to play
the track again, then the track will not override the jingle.
2 - If a Persistence 2 jingle is playing, any Music to be played will be queued after it.

For example if the game start theme is playing, and the player enters a planetarium, the planetarium Music
will be queued after the game start jingle is finished.
]]

local track_table = {
	--Don't add callbacks to API tracks
	["API_NOTHING"] = {
		Music = Music.MUSIC_MUSICAPI_NOTHING,
		Tags = {"API"},
	},
	["API_GAME_START"] = {
		Tags = {"API", "JINGLE"},
		Persistence = 2,
	},
	["API_STAGE_TRANSITION"] = {
		Tags = {"API", "JINGLE"},
		Persistence = 2,
	},

	["STAGE_NULL"] = {
		Music = Music.MUSIC_MUSICAPI_NOTHING,
		Tags = {"STAGE"},
	},
	
	["STAGE_BASEMENT"] = {
		Music = Music.MUSIC_BASEMENT,
		Tags = {"STAGE"},
	},
	["STAGE_CELLAR"] = {
		Music = Music.MUSIC_CELLAR,
		Tags = {"STAGE"}
	},
	["STAGE_BURNING_BASEMENT"] = {
		Music = Music.MUSIC_BURNING_BASEMENT,
		Tags = {"STAGE"}
	},
	["STAGE_DOWNPOUR"] = {
		Music = Music.MUSIC_DOWNPOUR,
		Tags = {"STAGE", "REPENTANCE"}
	},
	["STAGE_DROSS"] = {
		Music = Music.MUSIC_DROSS,
		Tags = {"STAGE", "REPENTANCE"}
	},
	["STAGE_MIRROR_DOWNPOUR"] = {
		Music = Music.MUSIC_DOWNPOUR_REVERSE,
		Tags = {"STAGE", "REPENTANCE", "MIRROR"},
		-- FadeSpeed = 0.01,
	},
	["STAGE_MIRROR_DROSS"] = {
		Music = Music.MUSIC_DROSS_REVERSE,
		Tags = {"STAGE", "REPENTANCE", "MIRROR"},
		-- FadeSpeed = 0.01,
	},
	
	["STAGE_CAVES"] = {
		Music = Music.MUSIC_CAVES,
		Tags = {"STAGE"}
	},
	["STAGE_CATACOMBS"] = {
		Music = Music.MUSIC_CATACOMBS,
		Tags = {"STAGE"}
	},
	["STAGE_FLOODED_CAVES"] = {
		Music = Music.MUSIC_FLOODED_CAVES,
		Tags = {"STAGE"}
	},
	["STAGE_MINES"] = {
		Music = Music.MUSIC_MINES,
		Tags = {"STAGE", "REPENTANCE"}
	},
	["STAGE_ASHPIT"] = {
		Music = Music.MUSIC_ASHPIT,
		Tags = {"STAGE", "REPENTANCE"}
	},
	["STAGE_MINESHAFT_AMBIENT"] = {
		Music = Music.MUSIC_MINESHAFT_AMBIENT,
		Tags = {"STAGE", "REPENTANCE", "MINESHAFT"}
	},
	
	["STAGE_DEPTHS"] = {
		Music = Music.MUSIC_DEPTHS,
		Tags = {"STAGE"}
	},
	["STAGE_NECROPOLIS"] = {
		Music = Music.MUSIC_NECROPOLIS,
		Tags = {"STAGE"}
	},
	["STAGE_DANK_DEPTHS"] = {
		Music = Music.MUSIC_DANK_DEPTHS,
		Tags = {"STAGE"}
	},
	["STAGE_MAUSOLEUM"] = {
		Music = Music.MUSIC_MAUSOLEUM,
		Tags = {"STAGE"}
	},
	["STAGE_GEHENNA"] = {
		Music = Music.MUSIC_GEHENNA,
		Tags = {"STAGE", "REPENTANCE"}
	},
	
	["STAGE_WOMB"] = {
		Music = Music.MUSIC_WOMB_UTERO,
		Tags = {"STAGE"}
	},
	["STAGE_UTERO"] = {
		Music = Music.MUSIC_UTERO,
		Tags = {"STAGE", "REPENTANCE"}
	},
	["STAGE_SCARRED_WOMB"] = {
		Music = Music.MUSIC_SCARRED_WOMB,
		Tags = {"STAGE"}
	},
	["STAGE_CORPSE"] = {
		Music = Music.MUSIC_CORPSE,
		Tags = {"STAGE", "REPENTANCE"}
	},
	["STAGE_MORTIS"] = {
		Music = Music.MUSIC_MORTIS,
		Tags = {"STAGE", "REPENTANCE"}
	},
	
	["STAGE_BLUE_WOMB"] = {
		Music = Music.MUSIC_BLUE_WOMB,
		Tags = {"STAGE"}
	},
	
	["STAGE_SHEOL"] = {
		Music = Music.MUSIC_SHEOL,
		Tags = {"STAGE"}
	},
	["STAGE_CATHEDRAL"] = {
		Music = Music.MUSIC_CATHEDRAL,
		Tags = {"STAGE"}
	},
	
	["STAGE_DARK_ROOM"] = {
		Music = Music.MUSIC_DARK_ROOM,
		Tags = {"STAGE"}
	},
	["STAGE_CHEST"] = {
		Music = Music.MUSIC_CHEST,
		Tags = {"STAGE"}
	},
	["STAGE_SHOP"] = {
		Music = Music.MUSIC_SHOP_ROOM,
		Tags = {"STAGE"}
	},
	
	["STAGE_VOID"] = {
		Music = Music.MUSIC_VOID,
		Tags = {"STAGE"}
	},
	["STAGE_ULTRA_GREED"] = {
		Music = Music.MUSIC_SHOP_ROOM,
		Tags = {"STAGE"}
	},
	
	["STAGE_HOME"] = {
		Music = Music.MUSIC_ISAACS_HOUSE,
		Tags = {"STAGE", "REPENTANCE"}
	},
	["STAGE_DARK_HOME"] = {
		Music = Music.MUSIC_ISAACS_HOUSE,
		Tags = {"STAGE", "REPENTANCE"},
		FadeSpeed = 1,
	},
	
	["BOSS_REBIRTH"] = {
		Music = Music.MUSIC_BOSS,
		Tags = {"BOSS", "BOSS_GENERIC"}
	},
	["BOSS_AFTERBIRTH"] = {
		Music = Music.MUSIC_BOSS2,
		Tags = {"BOSS", "BOSS_GENERIC"}
	},
	["BOSS_REPENTANCE"] = {
		Music = Music.MUSIC_BOSS3,
		Tags = {"BOSS", "BOSS_GENERIC", "REPENTANCE"}
	},
	["BOSS_MOM"] = {
		Music = Music.MUSIC_MOM_BOSS,
		Tags = {"BOSS"}
	},
	["BOSS_MOMS_HEART"] = {
		Music = Music.MUSIC_MOMS_HEART_BOSS,
		Tags = {"BOSS"}
	},
	["BOSS_IT_LIVES"] = {
		Music = Music.MUSIC_MOMS_HEART_BOSS,
		Tags = {"BOSS"}
	},
	["BOSS_ANGEL"] = {
		Tags = {"BOSS"}
	},
	-- ["BOSS_MOMS_HEART_MAUSOLEUM"] = {
		-- Music = Music.MUSIC_MOMS_HEART_BOSS,
		-- Tags = {"BOSS", "REPENTANCE"}
	-- },
	["BOSS_ISAAC"] = {
		Music = Music.MUSIC_ISAAC_BOSS,
		Tags = {"BOSS"}
	},
	["BOSS_SATAN_INACTIVE"] = {
		Music = Music.MUSIC_DEVIL_ROOM,
		Tags = {"BOSS"}
	},
	["BOSS_SATAN"] = {
		Music = Music.MUSIC_SATAN_BOSS,
		Tags = {"BOSS"}
	},
	["BOSS_MEGA_SATAN_INACTIVE"] = {
		Music = Music.MUSIC_DEVIL_ROOM,
		Tags = {"BOSS"}
	},
	["BOSS_MEGA_SATAN"] = {
		Music = Music.MUSIC_SATAN_BOSS,
		Tags = {"BOSS"}
	},
	["BOSS_GREED_STAGE_FINAL"] = {
		Music = Music.MUSIC_SATAN_BOSS,
		Tags = {"BOSS"}
	},
	["BOSS_LAMB"] = {
		Music = Music.MUSIC_DARKROOM_BOSS,
		Tags = {"BOSS"}
	},
	["BOSS_BLUE_BABY"] = {
		Music = Music.MUSIC_BLUEBABY_BOSS,
		Tags = {"BOSS"}
	},
	["BOSS_HUSH_FIRST"] = {
		Music = Music.MUSIC_BLUEBABY_BOSS,
		Tags = {"BOSS", "BOSS_HUSH"}
	},
	["BOSS_HUSH_FINAL"] = {
		Music = Music.MUSIC_HUSH_BOSS,
		Tags = {"BOSS", "BOSS_HUSH"}
	},
	["BOSS_ULTRA_GREED"] = {
		Music = Music.MUSIC_ULTRAGREED_BOSS,
		Tags = {"BOSS"}
	},
	-- ["BOSS_ULTRA_GREEDIER"] = {
		-- Music = Music.MUSIC_ULTRAGREED_BOSS,
		-- Tags = {"BOSS", "STAGE7_GREED", "BOSS_ULTRA_GREED"}
	-- },
	["BOSS_DELIRIUM"] = {
		Music = Music.MUSIC_VOID_BOSS,
		Tags = {"BOSS"}
	},
	["BOSS_MOTHER"] = {
		Music = Music.MUSIC_MOTHER_BOSS,
		Tags = {"BOSS", "REPENTANCE"}
	},
	["BOSS_DOGMA"] = {
		Music = Music.MUSIC_DOGMA_BOSS,
		Tags = {"BOSS", "REPENTANCE"},
		FadeSpeed = 1,
	},
	["BOSS_BEAST"] = {
		Music = Music.MUSIC_BEAST_BOSS,
		Tags = {"BOSS", "REPENTANCE"}
	},
	["ROOM_SHOP"] = {
		Music = Music.MUSIC_SHOP_ROOM,
		Tags = {},
	},
	["ROOM_TREASURE"] = {
		Tags = {},
	},
	["ROOM_BOSS_CLEAR"] = {
		Music = Music.MUSIC_BOSS_OVER,
		Tags = {"BOSS_CLEAR"},
	},
	["ROOM_BOSS_CLEAR_NULL"] = {
		Music = Music.MUSIC_NULL,
		Tags = {"REPENTANCE"},
	},
	["ROOM_BOSS_CLEAR_TWISTED"] = {
		Music = Music.MUSIC_BOSS_OVER_TWISTED,
		Tags = {"REPENTANCE"},
	},
	["ROOM_MINIBOSS_ACTIVE"] = {
		Music = Music.MUSIC_CHALLENGE_FIGHT,
		Tags = {},
	},
	["ROOM_MINIBOSS_CLEAR"] = {
		Music = Music.MUSIC_BOSS_OVER,
		Tags = {"BOSS_CLEAR"},
	},
	["ROOM_SECRET"] = {
		Music = Music.MUSIC_SECRET_ROOM,
		Tags = {"ROOM_SECRET"}
	},
	["ROOM_SUPER_SECRET"] = {
		Music = Music.MUSIC_SECRET_ROOM2,
		Tags = {"ROOM_SECRET"}
	},
	["ROOM_ULTRA_SECRET"] = {
		Music = Music.MUSIC_SECRET_ROOM_ALT_ALT,
		Tags = {"ROOM_SECRET", "REPENTANCE"}
	},
	["ROOM_ARCADE"] = {
		Music = Music.MUSIC_ARCADE_ROOM,
		Tags = {}
	},
	["ROOM_CURSE"] = {
		Tags = {}
	},
	["ROOM_CHALLENGE_NORMAL_INACTIVE"] = {
		Tags = {"ROOM_CHALLENGE_INACTIVE"}
	},
	["ROOM_CHALLENGE_NORMAL_ACTIVE"] = {
		Music = Music.MUSIC_CHALLENGE_FIGHT,
		Tags = {"ROOM_CHALLENGE_ACTIVE"}
	},
	["ROOM_CHALLENGE_NORMAL_CLEAR"] = {
		Music = Music.MUSIC_BOSS_OVER,
		Tags = {"ROOM_CHALLENGE_CLEAR", "BOSS_CLEAR"}
	},
	["ROOM_CHALLENGE_BOSS_INACTIVE"] = {
		Tags = {"ROOM_CHALLENGE_INACTIVE"}
	},
	["ROOM_CHALLENGE_BOSS_ACTIVE"] = {
		Music = Music.MUSIC_CHALLENGE_FIGHT,
		Tags = {"ROOM_CHALLENGE_ACTIVE"}
	},
	["ROOM_CHALLENGE_BOSS_CLEAR"] = {
		Music = Music.MUSIC_BOSS_OVER,
		Tags = {"ROOM_CHALLENGE_CLEAR", "BOSS_CLEAR"}
	},
	["ROOM_LIBRARY"] = {
		Music = Music.MUSIC_LIBRARY_ROOM,
		Tags = {}
	},
	["ROOM_SACRIFICE"] = {
		Tags = {}
	},
	["ROOM_DEVIL"] = {
		Music = Music.MUSIC_DEVIL_ROOM,
		Tags = {}
	},
	["ROOM_ANGEL"] = {
		Music = Music.MUSIC_ANGEL_ROOM,
		Tags = {}
	},
	["ROOM_DUNGEON"] = {
		Music = Music.MUSIC_DUNGEON,
		Tags = {}
	},
	["ROOM_BOSS_RUSH_INACTIVE"] = {
		Tags = {}
	},
	["ROOM_BOSS_RUSH_ACTIVE"] = {
		Music = Music.MUSIC_BOSS_RUSH,
		Tags = {}
	},
	["ROOM_BOSS_RUSH_CLEAR"] = {
		Music = Music.MUSIC_BOSS_OVER,
		Tags = {"BOSS_CLEAR"}
	},
	["ROOM_ISAACS"] = {
		Tags = {"ROOM_BEDROOM"}
	},
	["ROOM_BARREN"] = {
		Tags = {"ROOM_BEDROOM"}
	},
	["ROOM_CHEST"] = {
		Tags = {"ROOM_DOUBLE_KEY"},
	},
	["ROOM_DICE"] = {
		Tags = {"ROOM_DOUBLE_KEY"},
	},
	["ROOM_BLACK_MARKET"] = {
		Tags = {},
	},
	["ROOM_GREED_EXIT"] = {
		Tags = {},
	},
	["ROOM_PLANETARIUM"] = {
		Music = Music.MUSIC_PLANETARIUM,
		Tags = {"REPENTANCE"},
	},
	["ROOM_TELEPORTER"] = {
		Tags = {"REPENTANCE"},
	},
	["ROOM_TELEPORTER_EXIT"] = {
		Tags = {"REPENTANCE"},
	},
	["ROOM_SECRET_EXIT"] = {
		Music = Music.MUSIC_BOSS_OVER,
		Tags = {"REPENTANCE", "BOSS_CLEAR"},
	},
	["ROOM_BLUE"] = {
		Tags = {"REPENTANCE"},
	},
	
	["JINGLE_BOSS"] = {
		Music = Music.MUSIC_JINGLE_BOSS,
		Tags = {"JINGLE"},
	},
	["JINGLE_BOSS_CLEAR_REBIRTH"] = {
		Music = Music.MUSIC_JINGLE_BOSS_OVER,
		Tags = {"JINGLE", "JINGLE_BOSS_CLEAR"},
	},
	["JINGLE_BOSS_CLEAR_AFTERBIRTH"] = {
		Music = Music.MUSIC_JINGLE_BOSS_OVER2,
		Tags = {"JINGLE", "JINGLE_BOSS_CLEAR"},
	},
	["JINGLE_BOSS_CLEAR_REPENTANCE"] = {
		Music = Music.MUSIC_JINGLE_BOSS_OVER3,
		Tags = {"JINGLE", "JINGLE_BOSS_CLEAR", "REPENTANCE"},
	},
	["JINGLE_MINIBOSS_CLEAR"] = {
		Music = Music.MUSIC_JINGLE_CHALLENGE_OUTRO,
		Tags = {"JINGLE"},
	},
	["JINGLE_CHALLENGE_NORMAL_CLEAR"] = {
		Music = Music.MUSIC_JINGLE_CHALLENGE_OUTRO,
		Tags = {"JINGLE", "JINGLE_CHALLENGE_CLEAR"},
	},
	["JINGLE_CHALLENGE_BOSS_CLEAR"] = {
		Music = Music.MUSIC_JINGLE_CHALLENGE_OUTRO,
		Tags = {"JINGLE", "JINGLE_CHALLENGE_CLEAR"},
	},
	["JINGLE_ANGEL_ROOM"] = {
		Music = Music.MUSIC_JINGLE_HOLYROOM_FIND,
		Tags = {"JINGLE", "JINGLE_POST_BOSS_DEAL"},
	},
	["JINGLE_SECRET_ROOM"] = {
		Music = Music.MUSIC_JINGLE_SECRETROOM_FIND,
		Tags = {"JINGLE", "JINGLE_SECRET"},
		Persistence = 1
	},
	["JINGLE_SUPER_SECRET_ROOM"] = {
		Music = Music.MUSIC_JINGLE_SECRETROOM_FIND,
		Tags = {"JINGLE", "JINGLE_SECRET"},
		Persistence = 1
	},
	["JINGLE_ULTRA_SECRET_ROOM"] = {
		Music = Music.MUSIC_JINGLE_SECRETROOM_FIND,
		Tags = {"JINGLE", "JINGLE_SECRET"},
		Persistence = 1
	},
	["JINGLE_TREASURE_ROOM"] = {
		Music = {
			Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_0,
			Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_1,
			Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_2,
			Music.MUSIC_JINGLE_TREASUREROOM_ENTRY_3
		},
		Sound = {
			Sound.SOUND_TREASUREROOM_ENTRY_0,
			Sound.SOUND_TREASUREROOM_ENTRY_1,
			Sound.SOUND_TREASUREROOM_ENTRY_2,
			Sound.SOUND_TREASUREROOM_ENTRY_3
		},
		Tags = {"JINGLE", "SFX"},
		Persistence = 1,
		FadeLength = 135
	},
	["JINGLE_GAME_OVER"] = {
		Music = Music.MUSIC_JINGLE_GAME_OVER,
		Tags = {"JINGLE"},
		Persistence = 1,
	},
	["JINGLE_DEVIL_ROOM"] = {
		Music = Music.MUSIC_JINGLE_DEVILROOM_FIND,
		Tags = {"JINGLE", "JINGLE_POST_BOSS_DEAL"},
	},
	["JINGLE_BOSS_RUSH_OUTRO"] = {
		Music = Music.MUSIC_JINGLE_BOSS_OVER, --check
		Tags = {"JINGLE", "JINGLE_BOSS_CLEAR"},
	},
	["JINGLE_BOSS_DOGMA_CLEAR"] = {
		Music = Music.MUSIC_JINGLE_DOGMA_OVER,
		Tags = {"JINGLE", "REPENTANCE"},
		FadeSpeed = 1,
	},
	["JINGLE_STRANGE_DOOR"] = {
		Music = Music.MUSIC_STRANGE_DOOR_JINGLE,
		Tags = {"JINGLE", "REPENTANCE"},
		FadeSpeed = 1,
	},
	
	["INTRO_MOTHERS_SHADOW"] = {
		Music = Music.MUSIC_MOTHERS_SHADOW_INTRO,
		Tags = {"INTRO", "REPENTANCE"},
		FadeSpeed = 1,
	},
	["INTRO_DOGMA"] = {
		Music = Music.MUSIC_DOGMA_INTRO,
		Tags = {"INTRO", "REPENTANCE"},
	},
	
	["STATE_GAME_OVER"] = {
		Music = Music.MUSIC_GAME_OVER,
		Tags = {},
	},
	["STATE_ASCENT"] = {
		Music = Music.MUSIC_REVERSE_GENESIS,
		Tags = {"REPENTANCE"},
	},
	["STATE_MINESHAFT_ESCAPE"] = {
		Music = Music.MUSIC_MINESHAFT_ESCAPE,
		Tags = {"STAGE", "REPENTANCE", "DIMENSION_ALTERNATE", "STAGETYPE_REPENTANCE", "STAGETYPE_REPENTANCE_B", "STAGE2_2", "STAGE2", "MINESHAFT"}
	},
	
	["MENU_MAIN_MENU_REBIRTH"] = {
		Music = Music.MUSIC_TITLE,
		Tags = {"MENU", "MENU_MAIN_MENU"},
	},
	["MENU_MAIN_MENU_AFTERBIRTH"] = {
		Music = Music.MUSIC_TITLE_AFTERBIRTH,
		Tags = {"MENU", "MENU_MAIN_MENU"},
	},
	["MENU_MAIN_MENU_REPENTANCE"] = {
		Music = Music.MUSIC_TITLE_REPENTANCE,
		Tags = {"MENU", "MENU_MAIN_MENU"},
	},
	
	["DIMENSION_DEATH_CERTIFICATE"] = {
		Music = Music.MUSIC_DARK_CLOSET,
		Tags = {"REPENTANCE"},
	},
	
	-- Extra greed themes for The Shop floor
	["GREED_INACTIVE"] = {
		Tags = {"GREED"}
	},
	["GREED_ACTIVE"] = {
		Music = Music.MUSIC_CHALLENGE_FIGHT,
		Tags = {"GREED"}
	},
	["GREED_CLEAR"] = {
		Music = Music.MUSIC_BOSS_OVER,
		Tags = {"GREED", "BOSS_CLEAR"}
	},
	["JINGLE_GREED_CLEAR"] = {
		Music = Music.MUSIC_JINGLE_CHALLENGE_OUTRO,
		Tags = {"JINGLE"},
	},
}

return track_table 
