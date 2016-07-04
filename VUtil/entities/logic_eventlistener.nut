//=======================================//
//VUtil.EVENTsTable - Table of all EVENTs and they order
//Became usable after CSGO update 28.06.2016
//=======================================//

//=========== (C) Copyright 1999 Valve, L.L.C. All rights reserved. ===========
//
// The copyright to the contents herein is the property of Valve, L.L.C.
// The contents may be used and/or copied only with the written permission of
// Valve, L.L.C., or in accordance with the terms and conditions stipulated in
// the agreement/contract under which the contents have been supplied.
//=============================================================================

// No spaces in EVENT names, max length 32
// All strings are case sensitive
// total game EVENT byte length must be < 1024
//
// valid data key types are:
//   none   : value is not networked
//   string : a zero terminated string
//   wstring: a zero terminated wide char string
//   bool   : unsigned int, 1 bit
//   byte   : unsigned int, 8 bit
//   short  : signed int, 16 bit
//   long   : signed int, 32 bit
//   float  : float, 32 bit

//Translated from valve key value with gmod lua function util.KeyValuesToTable

EVENT_PLAYER_DEATH<-0;
EVENT_OTHER_DEATH<-1;
EVENT_PLAYER_HURT<-2;
EVENT_ITEM_PURCHASE<-3;
EVENT_BOMB_BEGINPLANT<-4;
EVENT_BOMB_ABORTPLANT<-5;
EVENT_BOMB_PLANTED<-6;
EVENT_BOMB_DEFUSED<-7;
EVENT_BOMB_EXPLODED<-8;
EVENT_BOMB_DROPPED<-9;
EVENT_BOMB_PICKUP<-10;
EVENT_DEFUSER_DROPPED<-11;
EVENT_DEFUSER_PICKUP<-12;
EVENT_ANNOUNCE_PHASE_END<-13;
EVENT_CS_INTERMISSION<-14;
EVENT_BOMB_BEGINDEFUSE<-15;
EVENT_BOMB_ABORTDEFUSE<-16;
EVENT_HOSTAGE_FOLLOWS<-17;
EVENT_HOSTAGE_HURT<-18;
EVENT_HOSTAGE_KILLED<-19;
EVENT_HOSTAGE_RESCUED<-20;
EVENT_HOSTAGE_STOPS_FOLLOWING<-21;
EVENT_HOSTAGE_RESCUED_ALL<-22;
EVENT_HOSTAGE_CALL_FOR_HELP<-23;
EVENT_VIP_ESCAPED<-24;
EVENT_VIP_KILLED<-25;
EVENT_PLAYER_RADIO<-26;
EVENT_BOMB_BEEP<-27;
EVENT_WEAPON_FIRE<-28;
EVENT_WEAPON_FIRE_ON_EMPTY<-29;
EVENT_WEAPON_OUTOFAMMO<-30;
EVENT_WEAPON_RELOAD<-31;
EVENT_WEAPON_ZOOM<-32;
EVENT_SILENCER_DETACH<-33;
EVENT_INSPECT_WEAPON<-34;
EVENT_WEAPON_ZOOM_RIFLE<-35;
EVENT_PLAYER_SPAWNED<-36;
EVENT_ITEM_PICKUP<-37;
EVENT_AMMO_PICKUP<-38;
EVENT_ITEM_EQUIP<-39;
EVENT_ENTER_BUYZONE<-40;
EVENT_EXIT_BUYZONE<-41;
EVENT_BUYTIME_ENDED<-42;
EVENT_ENTER_BOMBZONE<-43;
EVENT_EXIT_BOMBZONE<-44;
EVENT_ENTER_RESCUE_ZONE<-45;
EVENT_EXIT_RESCUE_ZONE<-46;
EVENT_SILENCER_OFF<-47;
EVENT_SILENCER_ON<-48;
EVENT_BUYMENU_OPEN<-49;
EVENT_BUYMENU_CLOSE<-50;
EVENT_ROUND_PRESTART<-51;
EVENT_ROUND_POSTSTART<-52;
EVENT_ROUND_START<-53;
EVENT_ROUND_END<-54;
EVENT_GRENADE_BOUNCE<-55;
EVENT_HEGRENADE_DETONATE<-56;
EVENT_FLASHBANG_DETONATE<-57;
EVENT_SMOKEGRENADE_DETONATE<-58;
EVENT_SMOKEGRENADE_EXPIRED<-59;
EVENT_MOLOTOV_DETONATE<-60;
EVENT_DECOY_DETONATE<-61;
EVENT_DECOY_STARTED<-62;
EVENT_TAGRENADE_DETONATE<-63;
EVENT_INFERNO_STARTBURN<-64;
EVENT_INFERNO_EXPIRE<-65;
EVENT_INFERNO_EXTINGUISH<-66;
EVENT_DECOY_FIRING<-67;
EVENT_BULLET_IMPACT<-68;
EVENT_PLAYER_FOOTSTEP<-69;
EVENT_PLAYER_JUMP<-70;
EVENT_PLAYER_BLIND<-71;
EVENT_PLAYER_FALLDAMAGE<-72;
EVENT_DOOR_MOVING<-73;
EVENT_ROUND_FREEZE_END<-74;
EVENT_MB_INPUT_LOCK_SUCCESS<-75;
EVENT_MB_INPUT_LOCK_CANCEL<-76;
EVENT_NAV_BLOCKED<-77;
EVENT_NAV_GENERATE<-78;
EVENT_PLAYER_STATS_UPDATED<-79;
EVENT_ACHIEVEMENT_INFO_LOADED<-80;
EVENT_SPEC_TARGET_UPDATED<-81;
EVENT_SPEC_MODE_UPDATED<-82;
EVENT_HLTV_CHANGED_MODE<-83;
EVENT_CS_GAME_DISCONNECTED<-84;
EVENT_CS_WIN_PANEL_ROUND<-85;
EVENT_CS_WIN_PANEL_MATCH<-86;
EVENT_CS_MATCH_END_RESTART<-87;
EVENT_CS_PRE_RESTART<-88;
EVENT_SHOW_FREEZEPANEL<-89;
EVENT_HIDE_FREEZEPANEL<-90;
EVENT_FREEZECAM_STARTED<-91;
EVENT_PLAYER_AVENGED_TEAMMATE<-92;
EVENT_ACHIEVEMENT_EARNED<-93;
EVENT_ACHIEVEMENT_EARNED_LOCAL<-94;
EVENT_ITEM_FOUND<-95;
EVENT_ITEMS_GIFTED<-96;
EVENT_REPOST_XBOX_ACHIEVEMENTS<-97;
EVENT_MATCH_END_CONDITIONS<-98;
EVENT_ROUND_MVP<-99;
EVENT_PLAYER_DECAL<-100;
EVENT_TEAMPLAY_ROUND_START<-101;
EVENT_CLIENT_DISCONNECT<-102;
EVENT_GG_PLAYER_LEVELUP<-103;
EVENT_GGTR_PLAYER_LEVELUP<-104;
EVENT_ASSASSINATION_TARGET_KILLED<-105;
EVENT_GGPROGRESSIVE_PLAYER_LEVELUP<-106;
EVENT_GG_KILLED_ENEMY<-107;
EVENT_GG_FINAL_WEAPON_ACHIEVED<-108;
EVENT_GG_BONUS_GRENADE_ACHIEVED<-109;
EVENT_SWITCH_TEAM<-110;
EVENT_GG_LEADER<-111;
EVENT_GG_TEAM_LEADER<-112;
EVENT_GG_PLAYER_IMPENDING_UPGRADE<-113;
EVENT_WRITE_PROFILE_DATA<-114;
EVENT_TRIAL_TIME_EXPIRED<-115;
EVENT_UPDATE_MATCHMAKING_STATS<-116;
EVENT_PLAYER_RESET_VOTE<-117;
EVENT_ENABLE_RESTART_VOTING<-118;
EVENT_SFUIEVENT<-119;
EVENT_START_VOTE<-120;
EVENT_PLAYER_GIVEN_C4<-121;
EVENT_GG_RESET_ROUND_START_SOUNDS<-122;
EVENT_TR_PLAYER_FLASHBANGED<-123;
EVENT_TR_MARK_COMPLETE<-124;
EVENT_TR_MARK_BEST_TIME<-125;
EVENT_TR_EXIT_HINT_TRIGGER<-126;
EVENT_BOT_TAKEOVER<-127;
EVENT_TR_SHOW_FINISH_MSGBOX<-128;
EVENT_TR_SHOW_EXIT_MSGBOX<-129;
EVENT_RESET_PLAYER_CONTROLS<-130;
EVENT_JOINTEAM_FAILED<-131;
EVENT_TEAMCHANGE_PENDING<-132;
EVENT_MATERIAL_DEFAULT_COMPLETE<-133;
EVENT_CS_PREV_NEXT_SPECTATOR<-134;
EVENT_CS_HANDLE_IME_EVENT<-135;
EVENT_NEXTLEVEL_CHANGED<-136;
EVENT_SEASONCOIN_LEVELUP<-137;
EVENT_TOURNAMENT_REWARD<-138;
EVENT_START_HALFTIME<-139;
EVENT_HLTV_STATUS<-140;
EVENT_HLTV_CAMERAMAN<-141;
EVENT_HLTV_RANK_CAMERA<-142;
EVENT_HLTV_RANK_ENTITY<-143;
EVENT_HLTV_FIXED<-144;
EVENT_HLTV_CHASE<-145;
EVENT_HLTV_MESSAGE<-146;
EVENT_HLTV_TITLE<-147;
EVENT_HLTV_CHAT<-148;
EVENT_HLTV_CHANGED_TARGET<-149;
EVENT_TEAM_INFO<-150;
EVENT_TEAM_SCORE<-151;
EVENT_TEAMPLAY_BROADCAST_AUDIO<-152;
EVENT_GAMEUI_HIDDEN<-153;
EVENT_ITEMS_GIFTED<-154;
EVENT_PLAYER_TEAM<-155;
EVENT_PLAYER_CLASS<-156;
//EVENT_PLAYER_DEATH<-157;
EVENT_PLAYER_HURT<-158;
EVENT_PLAYER_CHAT<-159;
EVENT_PLAYER_SCORE<-160;
EVENT_PLAYER_SPAWN<-161;
EVENT_PLAYER_SHOOT<-162;
EVENT_PLAYER_USE<-163;
EVENT_PLAYER_CHANGENAME<-164;
EVENT_PLAYER_HINTMESSAGE<-165;
EVENT_GAME_INIT<-166;
EVENT_GAME_NEWMAP<-167;
EVENT_GAME_START<-168;
EVENT_GAME_END<-169;
//EVENT_ROUND_START<-170;
EVENT_ROUND_ANNOUNCE_MATCH_POINT<-171;
EVENT_ROUND_ANNOUNCE_FINAL<-172;
EVENT_ROUND_ANNOUNCE_LAST_ROUND_HALF<-173;
EVENT_ROUND_ANNOUNCE_MATCH_START<-174;
EVENT_ROUND_ANNOUNCE_WARMUP<-175;
//EVENT_ROUND_END<-176;
EVENT_ROUND_END_UPLOAD_STATS<-177;
EVENT_ROUND_OFFICIALLY_ENDED<-178;
EVENT_ROUND_TIME_WARNING<-179;
EVENT_UGC_MAP_INFO_RECEIVED<-180;
EVENT_UGC_MAP_UNSUBSCRIBED<-181;
EVENT_UGC_MAP_DOWNLOAD_ERROR<-182;
EVENT_UGC_FILE_DOWNLOAD_FINISHED<-183;
EVENT_UGC_FILE_DOWNLOAD_START<-184;
EVENT_BEGIN_NEW_MATCH<-185;
EVENT_ROUND_START_PRE_ENTITY<-186;
EVENT_TEAMPLAY_ROUND_START<-187;
EVENT_HOSTNAME_CHANGED<-188;
EVENT_DIFFICULTY_CHANGED<-189;
EVENT_FINALE_START<-190;
EVENT_GAME_MESSAGE<-191;
EVENT_DM_BONUS_WEAPON_START<-192;
EVENT_SURVIVAL_ANNOUNCE_PHASE<-193;
EVENT_BREAK_BREAKABLE<-194;
EVENT_BREAK_PROP<-195;
EVENT_PLAYER_DECAL<-196;
EVENT_ENTITY_KILLED<-197;
EVENT_BONUS_UPDATED<-198;
EVENT_PLAYER_STATS_UPDATED<-199;
EVENT_ACHIEVEMENT_EVENT<-200;
EVENT_ACHIEVEMENT_INCREMENT<-201;
EVENT_ACHIEVEMENT_EARNED<-202;
EVENT_ACHIEVEMENT_WRITE_FAILED<-203;
EVENT_PHYSGUN_PICKUP<-204;
EVENT_FLARE_IGNITE_NPC<-205;
EVENT_HELICOPTER_GRENADE_PUNT_MISS<-206;
EVENT_USER_DATA_DOWNLOADED<-207;
EVENT_RAGDOLL_DISSOLVED<-208;
EVENT_GAMEINSTRUCTOR_DRAW<-209;
EVENT_GAMEINSTRUCTOR_NODRAW<-210;
EVENT_MAP_TRANSITION<-211;
EVENT_ENTITY_VISIBLE<-212;
EVENT_SET_INSTRUCTOR_GROUP_ENABLED<-213;
EVENT_INSTRUCTOR_SERVER_HINT_CREATE<-214;
EVENT_INSTRUCTOR_SERVER_HINT_STOP<-215;
EVENT_READ_GAME_TITLEDATA<-216;
EVENT_WRITE_GAME_TITLEDATA<-217;
EVENT_RESET_GAME_TITLEDATA<-218;
EVENT_WEAPON_RELOAD_DATABASE<-219;
EVENT_VOTE_ENDED<-220;
EVENT_VOTE_STARTED<-221;
EVENT_VOTE_CHANGED<-222;
EVENT_VOTE_PASSED<-223;
EVENT_VOTE_FAILED<-224;
EVENT_VOTE_CAST<-225;
EVENT_VOTE_OPTIONS<-226;
EVENT_ENDMATCH_MAPVOTE_SELECTING_MAP<-227;
EVENT_ENDMATCH_CMM_START_REVEAL_ITEMS<-228;
EVENT_INVENTORY_UPDATED<-229;
EVENT_CART_UPDATED<-230;
EVENT_STORE_PRICESHEET_UPDATED<-231;
EVENT_GC_CONNECTED<-232;
EVENT_ITEM_SCHEMA_INITIALIZED<-233;
EVENT_CLIENT_LOADOUT_CHANGED<-234;
EVENT_ADD_PLAYER_SONAR_ICON<-235;
EVENT_ADD_BULLET_HIT_MARKER<-236;
EVENT_VERIFY_CLIENT_HIT<-237;
EVENT_SERVER_SPAWN<-238;
EVENT_SERVER_PRE_SHUTDOWN<-239;
EVENT_SERVER_SHUTDOWN<-240;
EVENT_SERVER_CVAR<-241;
EVENT_SERVER_MESSAGE<-242;
EVENT_SERVER_ADDBAN<-243;
EVENT_SERVER_REMOVEBAN<-244;
EVENT_PLAYER_CONNECT<-245;
EVENT_PLAYER_INFO<-246;
EVENT_PLAYER_DISCONNECT<-247;
EVENT_PLAYER_ACTIVATE<-248;
EVENT_PLAYER_CONNECT_FULL<-249;
EVENT_PLAYER_SAY<-250;
EVENT_CS_ROUND_START_BEEP<-251;
EVENT_CS_ROUND_FINAL_BEEP<-252;
EVENT_ROUND_TIME_WARNING<-253;

//Used for assign user id's 
userid_assigner<-function(params){
if (::GameEventsCapturedPlayer!=null&&params.entity==0){
local script_scope=::GameEventsCapturedPlayer.GetScriptScope();
script_scope.userid<-params.userid;
::GameEventsCapturedPlayer=null;
return true
}
}



OnEventFired<- function(EVENT_ID){
VUtil.Event.Call(EVENT_ID,this.event_data)
if (true){
return 
}
if (EVENT_ID==EVENT_PLAYER_USE){if (userid_assigner(this.event_data)){return}}
if ("event_data" in this){
if ("OnGameEvent_"+events_ids_translate[EVENT_ID][0] in getroottable()){
FireEventFormat(EVENT_ID,this.event_data)
}
if ("OnGameEvent_"+events_ids_translate[EVENT_ID][0]+"_raw" in getroottable()){
getroottable()["OnGameEvent_"+events_ids_translate[EVENT_ID][0]+"_raw"](this.event_data)
}
}
}