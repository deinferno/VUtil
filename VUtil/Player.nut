//=======================================//
//VUtil.Player - General player functions
//=======================================//

VUtil.Player <- {};

//Freezes a player in place
function VUtil::Player::Freeze(player)
{
	if(player.GetClassname() == "player")
	{
		player.__KeyValueFromFloat("movetype",VUtil.Constants.MoveTypes.None);
	}
}

//Enables noclip for a player
function VUtil::Player::EnableNoclip(player)
{
	if(player.GetClassname() == "player")
	{
		player.__KeyValueFromFloat("movetype",VUtil.Constants.MoveTypes.Noclip);
	}
}

//Enables fly mode for a player
function VUtil::Player::EnableFly(player)
{
	if(player.GetClassname() == "player")
	{
		player.__KeyValueFromFloat("movetype",VUtil.Constants.MoveTypes.Fly);
	}
}

//Resets the player's movetype to WALK (disables freeze/noclip/fly).
function VUtil::Player::ResetMoveType(player)
{
	if(player.GetClassname() == "player")
	{
		player.__KeyValueFromFloat("movetype",VUtil.Constants.MoveTypes.Walk);
	}
}

//Forces the player to look at the given position.
function VUtil::Player::LookAt(player, targetPos)
{
	if(player.GetClassname() == "player")
	{
		local eyePos = player.EyePosition();
		local eyeToTarget =  targetPos - eyePos;
		
		local ToDegrees = 180.0 / 3.14159; //Converts radians to degrees (SetAngles uses degrees, atan2 returns radians).
		
		local pitch = atan2(eyeToTarget.Length2D(),eyeToTarget.z) * ToDegrees - 90.0; //Calculate the pitch (up/down) angle.
		local yaw = atan2(eyeToTarget.y,eyeToTarget.x) * ToDegrees; //Calculate the yaw (left/right) angle.
		
		player.SetAngles(pitch,yaw,0);
	}
}

//Returns whether the player is crouching or not.
function VUtil::Player::IsCrouching(player)
{
	if(player.GetClassname() == "player")
	{
		return player.GetBoundingMaxs().z < 72.0;
	}
	return false;
}

//Returns an array containing all of the weapons the player have.
function VUtil::Player::GetWeapons(player)
{
	local weapons = [];
	
	local weapon = null;
	while(weapon = Entities.FindByClassname(weapon,"weapon_*"))
	{
		if(weapon.GetOwner() == player)
		{
			weapons.push(weapon);
		}
	}
	
	return weapons;
}

function VUtil::Player::ConCommand(player,cmd){
EntFireByHandle(VUtil.point_clientcommand,"Command",cmd,0,player,null);
}

//Set player gravity 1-0
function VUtil::Player::SetGravity(player,gravity){
VUtil.Entity.SetKeyValue(player,"gravity",gravity);
}

//Set player speed multiplier
//normalizegravity(true) = auto adjust gravity to match speed (Prevent jumping higher or lower)
function VUtil::Player::SetSpeedMultiplier(player,speedmul,normalizegravity=true){
EntFireByHandle(VUtil.player_speedmod,"ModifySpeed",speedmul.tostring(),0,player,null);
if (normalizegravity&&speedmul>1.0){
VUtil.Entity.SetKeyValue(player,"gravity",1/speedmul);
}
}

//Not work properly DISABLED , use from hammer
/*
//Allow to shoot bullets from entity to entity
//On wiki:  The visual effect will be identical to an actual weapon firing, but causes no damage.
//In virtual reality: *Dying sounds*
//That means that it deadly
//end - can be used as entity or origin
function VUtil::Player::ShootBullets(attacker,weapon,start,end,numshots=1,spread=0){
if (typeof(weapon)=="instance"){
	weapon=weapon.GetClassname()
}

local npc_bullseye=null
if (typeof(end)=="Vector"){
	npc_bullseye=VUtil.Entity.Create("npc_bullseye")
	npc_bullseye.SetOrigin(end)
	VUtil.Entity.EnsureHasName(npc_bullseye)
	end=npc_bullseye
}

local env_gunfire=VUtil.Entity.Create("env_gunfire",{weaponname=weapon,minburstsize=numshots,maxburstsize=numshots,StartDisabled=true,minburstdelay=1,maxburstdelay=1,spread=spread,bias=1})
EntFireByHandle(env_gunfire,"addoutput","target "+end.GetName(),0,null,null)
env_gunfire.SetOrigin(start)
env_gunfire.SetOwner(attacker)
EntFireByHandle(env_gunfire,"Enable","",5,null,null)
VUtil.Debug.DrawCross(end.GetOrigin(),5,false,10)
VUtil.Debug.DrawCross(env_gunfire.GetOrigin(),10,false,10)
//Pew pew
}
*/

//Shake player view
function VUtil::Player::Shake(player,frequency,amplitude,duration){
VUtil.Entity.SetKeyValue(VUtil.env_shake,"frequency",frequency);
VUtil.Entity.SetKeyValue(VUtil.env_shake,"amplitude",amplitude);
VUtil.Entity.SetKeyValue(VUtil.env_shake,"duration",duration);
VUtil.Entity.EnsureHasName(player)
EntFireByHandle(VUtil.env_shake,"SetParent",player.GetName(),0.0,null,null);
VUtil.env_shake.SetOrigin(player.GetCenter())
EntFireByHandle(VUtil.env_shake,"StartShake","",0.01,null,null);
EntFireByHandle(VUtil.env_shake,"ClearParent","",0.02,null,null);
}


//Punch player view
function VUtil::Player::ViewPunch(player,angle){
VUtil.Entity.SetKeyValue(VUtil.env_viewpunch,"punchangle",angle);
VUtil.Entity.EnsureHasName(player)
EntFireByHandle(VUtil.env_viewpunch,"SetParent",player.GetName(),0.0,null,null);
VUtil.env_viewpunch.SetOrigin(player.GetOrigin())

EntFireByHandle(VUtil.env_viewpunch,"ViewPunch","",0.01,null,null);
EntFireByHandle(VUtil.env_viewpunch,"ClearParent","",0.02,null,null);
}

//Add score to player 
function VUtil::Player::AddScore(player,amount){
VUtil.Entity.SetKeyValue(VUtil.game_score,"points",amount)
VUtil.Entity.SetKeyValue(VUtil.game_score,"spawnflags",1)

EntFireByHandle(VUtil.game_score,"ApplyScore","",0.0,player,null);
}

VUtil.Player.RemoveScore<-function(player,amount){VUtil.Player.AddScore(player,-amount)}

function VUtil::Player::AddTeamScore(amount,team){
VUtil.Entity.SetKeyValue(VUtil.game_score,"points",amount)
VUtil.Entity.SetKeyValue(VUtil.game_score,"spawnflags",3)
local player=null
foreach (k,v in VUtil.Player.GetAll()){
if (v.GetTeam()==team){
player=v
}
}

EntFireByHandle(VUtil.game_score,"ApplyScore","",0.0,player,null);
}

VUtil.Player.RemoveTeamScore<-function(amount,team){VUtil.Player.RemoveScore(-amount,team)}


//Add money to player (can't be negative)
function VUtil::Player::AddMoney(player,amount,text=""){
VUtil.Entity.SetKeyValue(VUtil.game_money,"Money",amount)
VUtil.Entity.SetKeyValue(VUtil.game_money,"AwardText",text)

EntFireByHandle(VUtil.game_money,"AddMoneyPlayer","",0.0,player,null);
}

VUtil.Player.GiveMoney <- VUtil.Player.AddMoney 

function VUtil::Player::StripWeapon(player,weapons=true){
if (weapons==true){
	foreach (weapon in VUtil.Player.GetWeapons(player)){
	weapon.Destroy()
	}
} else {
	if (typeof(weapons)=="string"){
	weapons=[weapons]
	}
	foreach (weapon in VUtil.Player.GetWeapons(player)){
	foreach (weapon_class in weapons){
	if (weapon_class==weapon.GetClassname()){
	weapon.Destroy();
	break;
	}
	}
	}
}
}

VUtil.Player.StripWeapons <- VUtil.Player.StripWeapon

function VUtil::Player::GiveWeapon(player,weapons){
local game_player_equip = Entities.CreateByClassname("game_player_equip");
VUtil.Entity.SetKeyValue(game_player_equip ,"spawnflags",5)

if (typeof(weapons)=="string"){
weapons=[weapons]
}

foreach (weapon in weapons){
VUtil.Entity.SetKeyValue(game_player_equip,weapon,0)
//Prevent knife create duplicate of itself
if (weapon=="weapon_knife"){
local knife=VUtil.Player.GetWeaponByClass(player,"weapon_knife")
if (knife!=null){
knife.Destroy()
}
}
}

EntFireByHandle(game_player_equip ,"Use","",0.0,player,null);
EntFireByHandle(game_player_equip ,"Kill","",0.0,null,null);
}

VUtil.Player.GiveWeapons <- VUtil.Player.GiveWeapon


function VUtil::Player::RegenerateAmmo(player){
EntFireByHandle(VUtil.point_give_ammo,"GiveAmmo","",0.0,player,null);
}

VUtil.Player.GiveAmmo <- VUtil.Player.RegenerateAmmo

function VUtil::Player::SetHUDVisibility(player,visible){
	if (visible==true){visible=1}
	EntFireByHandle(player,"SetHUDVisibility",visible.tostring(),0.0,null,null)
}

function VUtil::Player::GetViewModel(player){
	foreach (k,v in VUtil.Entity.GetAllByClassname("predicted_viewmodel")){
	if (v.GetRootMoveParent()==player){return v}
	}
}

function VUtil::Player::GetWorldModels(player){
	local worldmodels=[]
	foreach (k,v in VUtil.Entity.GetAllByClassname("weaponworldmodel")){
	if (v.GetMoveParent()==player){worldmodels.push(v)}
	}
	return worldmodels
}

function VUtil::Player::GetActiveWeapon(player){
	local active_weapon=VUtil.Player.GetActiveWeaponClass(player)
	return VUtil.Player.GetWeaponByClass(player,active_weapon)
}

function VUtil::Player::GetWeaponByClass(player,c){
	local active_weapon=VUtil.Player.GetActiveWeaponClass(player)
	foreach(weapon in VUtil.Player.GetWeapons(player)){
	if (weapon.GetClassname()==c){return weapon}
	}
}

function VUtil::Player::GetActiveWeaponClass(player){
	if (player.GetClassname() == "player"){
	player.ValidateScriptScope();
	local ss=player.GetScriptScope();
	if ( "vutil_active_weapon" in ss){return player.GetScriptScope().vutil_active_weapon} else {return "unknown"};
	};
}

function VUtil::Player::GetActiveWeaponSlot(player){
	if(player.GetClassname() == "player"){
	player.ValidateScriptScope();
	local ss=player.GetScriptScope();
	if ( "vutil_active_slot" in ss){return player.GetScriptScope().vutil_active_slot} else {return VUtil.Constants.WeaponTypes.WEAPONTYPE_UNKNOWN};
	};
}

//Return all players including bots
function VUtil::Player::GetAll(){
local players=[]
foreach(player in VUtil.Entity.GetAll()){
if (player.GetClassname()=="player"){
players.push(player);
}
}	
return players
}

//Get player from his userid 
//userid = unique number for player slot on server
function VUtil::Player::GetByUserID(userid){
foreach(player in VUtil.Player.GetAll()){
if (player.ValidateScriptScope()){
local ss=player.GetScriptScope()
if ("vutil_userid" in ss&&ss.vutil_userid==userid){return player}	
}
}	
}

function VUtil::Player::KeyDown(player,key){
	player.ValidateScriptScope()
	
	local playerscope=player.GetScriptScope()

	if (key in playerscope){
	return playerscope[key]
	}

	return false
}

//That thing can read player movements
function VUtil::Player::CreateGameUI(player,callback,table=getroottable(),freeze=true,deactive="+use"){
	local flags=0
	if (freeze){
	flags+=96
	}
	if (deactive=="+use"){
	flags+=128
	} else if (deactive=="jump"){
	flags+=256
	}

	player.ValidateScriptScope()
	
	local playerscope=player.GetScriptScope()
	if (("game_ui" in playerscope)&&playerscope.game_ui.IsValid()){printl("[VUtil.Player.CreateGameUI] Player already occupied by other VUtil game_ui");return}

	local game_ui=VUtil.Entity.Create("game_ui",{spawnflags=flags,FieldOfView=-1.0,targetname=player.GetName()+"_"+player.entindex()+"game_ui"})
	
	playerscope.game_ui<-game_ui
	
	game_ui.ValidateScriptScope()

	local scope = game_ui.GetScriptScope()
	
	scope.playerscope<-playerscope
	scope.classscope<-table
	scope.callback<-callback

	scope.InputPressedMoveLeft<-function(){playerscope.left<-true;classscope[callback]("left",true)}
	scope.InputPressedMoveRight<-function(){playerscope.right<-true;classscope[callback]("right",true)}
	scope.InputPressedMoveForward<-function(){playerscope.forward<-true;classscope[callback]("forward",true)}
	scope.InputPressedMoveBack<-function(){playerscope.back<-true;classscope[callback]("back",true)}
	scope.InputPressedAttack<-function(){playerscope.attack<-true;classscope[callback]("attack",true)}
	scope.InputPressedAttack2<-function(){playerscope.attack2<-true;classscope[callback]("attack2",true)}

	scope.InputUnPressedMoveLeft<-function(){playerscope.left<-false;classscope[callback]("left",false)}
	scope.InputUnPressedMoveRight<-function(){playerscope.right<-false;classscope[callback]("right",false)}
	scope.InputUnPressedMoveForward<-function(){playerscope.forward<-false;classscope[callback]("forward",false)}
	scope.InputUnPressedMoveBack<-function(){playerscope.back<-false;classscope[callback]("back",false)}
	scope.InputUnPressedAttack<-function(){playerscope.attack<-false;classscope[callback]("attack",false)}
	scope.InputUnPressedAttack2<-function(){playerscope.attack2<-false;classscope[callback]("attack2",false)}

	scope.InputPlayerOff<-function(){
	playerscope.left<-false
	playerscope.right<-false
	playerscope.forward<-false
	playerscope.back<-false
	playerscope.attack<-false;
	playerscope.attack2<-false;

	classscope[callback]("disable",true)
	self.Destroy()
	}

	game_ui.ConnectOutput("PressedMoveLeft","InputPressedMoveLeft")
    	game_ui.ConnectOutput("UnpressedMoveLeft","InputUnPressedMoveLeft")
	
	game_ui.ConnectOutput("PressedMoveRight","InputPressedMoveRight")
    	game_ui.ConnectOutput("UnpressedMoveRight","InputUnPressedMoveRight")
		
	game_ui.ConnectOutput("PressedForward","InputPressedMoveForward")
    	game_ui.ConnectOutput("UnpressedForward","InputUnPressedMoveForward")
	
	game_ui.ConnectOutput("PressedBack","InputPressedMoveBack")
    	game_ui.ConnectOutput("UnpressedBack","InputUnPressedMoveBack")
	
	game_ui.ConnectOutput("PressedAttack","InputPressedAttack")
   	game_ui.ConnectOutput("UnpressedAttack","InputUnPressedAttack")
	
	game_ui.ConnectOutput("PressedAttack2","InputPressedAttack2")
   	game_ui.ConnectOutput("UnpressedAttack2","InputUnPressedAttack2")

   	game_ui.ConnectOutput("PlayerOff","InputPlayerOff")

   	EntFireByHandle(game_ui,"Activate","",0.0,player,null)	
}

function VUtil::Player::RemoveGameUI(player){
	player.ValidateScriptScope()
	
	local playerscope=player.GetScriptScope()	
	if (("game_ui" in playerscope)&&playerscope.game_ui.IsValid()){
	playerscope.game_ui.Destroy()
	delete playerscope.game_ui
	} else {
	printl("[VUtil.Player.RemoveGameUI] Can't find available game_ui of player")
	}
}

//Get userid of player
//player = player entity
function VUtil::Player::GetUserID(player){
if (player.GetClassname()=="player"){
if (player.ValidateScriptScope()){
local ss=player.GetScriptScope()
if ("vutil_userid" in ss){return ss.vutil_userid} else {return -1}	
}
}
}

function VUtil::Player::GetEyeAngles(player){
if (player.GetClassname()=="player"){
if (player.ValidateScriptScope()){
local ss=player.GetScriptScope()
if ("vutil_eye_tracker" in ss){return ss.vutil_eye_tracker.GetAngles()} else {return Vector(0,0,0)}	
}
}	
}


function VUtil::Player::GetEyeDirection(player){
if (player.GetClassname()=="player"){
if (player.ValidateScriptScope()){
local ss=player.GetScriptScope()
if ("vutil_eye_tracker" in ss){return ss.vutil_eye_tracker.GetForwardVector()} else {return Vector(0,0,0)}	
}
}	
}

//Creates an 'Eye Tracker' entity which will mimic the player's view angles and position.
//NOW : Automatically created per player not needed
//GetAngles on the eye will return the player's view angles.
//GetForwardVector on the eye will return the player's looking direction (useful for traces).
//This is a work around for the lack of an EyeAngles function for players.
function VUtil::Player::CreateEye(player)
{
	if(player != null)
	{
		if(player.GetClassname() == "player")
		{
			local playerID = player.entindex();
			
			//Create unique entity names for this player 
			local playerName = "player_"+playerID;
			local refName = "eye_ref_"+playerID;
			local origName = "eye_orig_"+playerID;
			local trackName = "eye_tracker_"+playerID;
			
			//Give the player a targetname
			VUtil.Entity.SetName(player,playerName);
			
			//The entity that the logic_measure_movement measures relative to.
			VUtil.Entity.Create("path_track", { targetname = refName });// MeasureReference/TargetReference
			
			//The entity which has the player's eye position & angles.
			local eyeOrigin = VUtil.Entity.Create("path_track", { targetname = origName }); //Target
			
			//The logic_measure_movement entity that tracks the player's eye position & angles.
			local tracker = VUtil.Entity.Create("logic_measure_movement",
			{
				targetname = trackName
				MeasureReference = refName
				TargetReference = refName
				Target = origName
				MeasureType = 1
				TargetScale = 1
			});
			
			//These do not get assigned properly with VUtil.Entity.Create
			EntFireByHandle(tracker,"setmeasurereference",refName,0.01,null,null);
			EntFireByHandle(tracker,"setmeasuretarget",playerName,0.01,null,null);
			EntFireByHandle(tracker,"enable","",0.02,null,null);
			
			return eyeOrigin;
		}
		else
		{
			printl("[VUtil.Player.CreateEye] Tried to make an eye tracker for a non-player entity!" );
		}
	}
	else
	{
		printl("[VUtil.Player.CreateEye] Tried to make an eye tracker for an invalid player!" );
	}
}