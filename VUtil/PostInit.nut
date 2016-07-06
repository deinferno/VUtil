//Create all entities needed by VUtil
function VUtil::InitializeHelperEntities(){
VUtil.logic_timer <- VUtil.Entity.Create("logic_timer",{targetname="VUtil_logic_timer",RefireTime=0.01,StartDisabled=0,UserRandomTime=0});
VUtil.Logic.Link(VUtil.logic_timer,"OnTimer",VUtil.logic_timer,"RunScriptCode","VUtil.Timer.Think()");
EntFireByHandle(VUtil.logic_timer,"Enable","",0,null,null);

VUtil.info_target <- VUtil.Entity.Create("info_target",{targetname="VUtil_info_target"});
VUtil.point_give_ammo<- VUtil.Entity.Create("point_give_ammo",{targetname="VUtil_point_give_ammo"});
VUtil.info_game_event_proxy <- VUtil.Entity.Create("info_game_event_proxy",{range=0,targetname="VUtil_info_game_event_proxy"});
VUtil.point_hurt <- VUtil.Entity.Create("point_hurt",{targetname="VUtil_point_hurt"});
VUtil.game_money <- VUtil.Entity.Create("game_money",{targetname="VUtil_game_money"})
VUtil.game_score <- VUtil.Entity.Create("game_score",{targetname="VUtil_game_score",spawnflags=1})
VUtil.player_speedmod <- VUtil.Entity.Create("player_speedmod",{targetname="VUtil_player_speedmod"})
VUtil.point_clientcommand <- VUtil.Entity.Create("point_clientcommand",{targetname="VUtil_point_clientcommand"});
VUtil.env_viewpunch <- VUtil.Entity.Create("env_viewpunch",{targetname="VUtil_env_viewpunch",radius=5,spawnflags=2,punchangle=Vector(0,0,0)});
VUtil.env_shake <- VUtil.Entity.Create("env_shake",{targetname="VUtil_env_shake",radius=5,spawnflags=4,frequency=0.0,duration=0,amplitude=0});
VUtil.env_explosion <- VUtil.Entity.Create("env_explosion",{targetname="VUtil_env_explosion",iMagnitude=0,iRadiusOverride=0,ignoredEntity="",spawnflags=6146,fireballsprite="sprites/zerogxplode.spr",rendermode=4});
}

if (!("info_target" in VUtil)||(VUtil.info_target.IsValid())){
VUtil.InitializeHelperEntities();
}

function VUtil::DefineHooks(){
	

::VUTIL_WaitingClient<-null;

function VUTIL_PlayerFetch_request(){
foreach(player in VUtil.Player.GetAll()){
if (player.ValidateScriptScope()){
local ss=player.GetScriptScope();
if (!("vutil_eye_tracker" in ss)||!(ss.vutil_eye_tracker.IsValid())){
ss.vutil_eye_tracker<-VUtil.Player.CreateEye(player)
}
if (!("vutil_userid" in ss)){
ss.vutil_userid<- -1;
VUTIL_WaitingClient=player;
VUtil.Event.Generate("player_use",player);
return
}
}
}
}

VUTIL_PlayerFetch_request()
VUtil.Timer.Create("VUTIL_PlayerFetch_request",0.5,-1,"VUTIL_PlayerFetch_request",this)

function VUTIL_PlayerFetch_userid(params){
local userid=params.userid;
local entity=params.entity;
if (entity==0){
VUTIL_WaitingClient.GetScriptScope().vutil_userid<-userid;
VUTIL_WaitingClient=null;
return true;
}
}

VUtil.Event.Add("player_use","VUTIL_PlayerFetch_userid","VUTIL_PlayerFetch_userid",this,false)


function VUtil_WeaponData(params){
	local ply=VUtil.Player.GetByUserID(params.userid)
	if (ply==null){
	function ReCall(params){
	VUtil.Event.Call(VUtil.Constants.EVENT_ITEM_EQUIP,params);
	}
	VUtil.Timer.Simple(0.5,"ReCall",this,[params])
	return true
	}
	local item=params.item
	local weptype=params.weptype
	ply.ValidateScriptScope();
	local ss=ply.GetScriptScope();
	ss.vutil_active_weapon<-"weapon_"+item;
	ss.vutil_active_slot<-weptype;
}

VUtil.Event.Add("item_equip","VUtil_WeaponData","VUtil_WeaponData",this,false,false)
}

VUtil.DefineHooks()