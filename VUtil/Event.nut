//=======================================//
//VUtil.Event - Events related functionality
//Became usable after CSGO update 28.06.2016
//=======================================//

VUtil.Event <- {};
VUtil.Event.__Listeners <- {};
VUtil.Event.Table <-{};
VUtil.Event.Table.Constants <-{};
VUtil.Event.Table.Translates <-{};

IncludeScript("VUtil/EventTable.nut");

//Add event for listening
//eventname = name of event
//listenername = unique name for eventlistener
//callback = when event occur fire this function
//format(true) = will it even try to format data or return it in raw table
//vararg(true) = reorder arguments to fill event with arguments instead of table
function VUtil::Event::Add(event,listener,callback,scope=getroottable(),format=true,vararg=true)
{
	if (!(event in VUtil.Event.__Listeners)){
	VUtil.Event.__Listeners[event]<-{}
	}
	VUtil.Event.__Listeners[event][listener]<-{callback=callback,scope=scope,format=format,vararg=true};
}

function VUtil::Event::Remove(event,listener)
{
	if (event in VUtil.Event.__Listeners&&listener in VUtil.Event.__Listeners[event]){
	delete VUtil.Event.__Listeners[event][listener];
	}
}

function VUtil::Event::Generate(event,activator=null){
VUtil.Entity.SetKeyValue(VUtil.info_game_event_proxy,"event_name",event);
EntFireByHandle(VUtil.info_game_event_proxy,"GenerateGameEvent","",0.0,activator,null);
}

//WARNING: Effects of that function can't be undone (only map change recreate vote_controller)
//Disable votes by removing vote_controller , only can be fired once
function VUtil::Event::DisableVote(){
	foreach (vote_controller in VUtil.Entity.GetAllByClassname("vote_controller")){
	vote_controller.Destroy()
	}
}

//function that called by logic_eventlistener
function VUtil::Event::Call(eventid,eventdata){
	local event=VUtil.Event.Table.Translates[eventid][0]
	if (!(event in VUtil.Event.__Listeners)){
	VUtil.Event.__Listeners[event]<-{}
	}
	foreach (listener,arguments in VUtil.Event.__Listeners[event]){
	local scope=arguments.scope
	local callback=arguments.callback
	local vararg=arguments.vararg
	if (!arguments.format){
	if (scope[callback](eventdata)){return}
	continue;
	}
	local event_arguments=VUtil.Event.FormatArgumentsForEvent(eventid,eventdata,vararg)
	if (arguments.vararg){
	switch (event_arguments.len()){
	case 0:if (scope[callback]()){return};break;
	case 1:if (scope[callback](event_arguments[1])){return};break;
	case 2:if (scope[callback](event_arguments[1],event_arguments[2])){return};break;
	case 3:if (scope[callback](event_arguments[1],event_arguments[2],event_arguments[3])){return};break;
	case 4:if (scope[callback](event_arguments[1],event_arguments[2],event_arguments[3],event_arguments[4])){return};break;
	case 5:if (scope[callback](event_arguments[1],event_arguments[2],event_arguments[3],event_arguments[4],event_arguments[5])){return};break;
	case 6:if (scope[callback](event_arguments[1],event_arguments[2],event_arguments[3],event_arguments[4],event_arguments[5],event_arguments[6])){return};break;
	case 7:if (scope[callback](event_arguments[1],event_arguments[2],event_arguments[3],event_arguments[4],event_arguments[5],event_arguments[6],event_arguments[7])){return};break;
	case 8:if (scope[callback](event_arguments[1],event_arguments[2],event_arguments[3],event_arguments[4],event_arguments[5],event_arguments[6],event_arguments[7],event_arguments[8])){return};break;
	case 9:if (scope[callback](event_arguments[1],event_arguments[2],event_arguments[3],event_arguments[4],event_arguments[5],event_arguments[6],event_arguments[7],event_arguments[8],event_arguments[9])){return};break;
	case 10:if (scope[callback](event_arguments[1],event_arguments[3],event_arguments[4],event_arguments[5],event_arguments[6],event_arguments[7],event_arguments[8],event_arguments[9],event_arguments[10])){return};break;
	}
	} else {
	if (scope[callback](event_arguments)) {return}
	}
	}
}


function VUtil::Event::FormatArgumentsForEvent(eventid,eventdata,vararg=true){
local args={}
local vector=Vector(0,0,0);
local writedx=false
local writedy=false
local writedz=false
local offset=0
local order=VUtil.Event.Table.Translates[eventid][1]
foreach (key,arg in eventdata){
local shouldwrite=true
if (key=="userid"||key=="attacker"||key=="assister"||key=="victimid"||key=="attackerid"||key=="playerid"||key=="botid"){
arg=VUtil.Player.GetByUserID(arg);
}
if (key=="entindex"||key=="entindex_killed"||key=="entindex_attacker"||key=="entindex_inflictor"||key=="site"||key=="hostage"||key=="index"||key=="victim"||key=="killer"||key=="player"||key=="entity"){
arg=VUtil.Entity.GetByIndex(arg);
}
if (key=="x"||key=="pos_x"||key=="start_x"||key=="ang_x"){
vector.x=arg
writedx=true
shouldwrite=false
}
if (key=="y"||key=="pos_y"||key=="start_y"||key=="ang_y"){
vector.y=arg
writedy=true
shouldwrite=false
}

if (key=="z"||key=="pos_z"||key=="start_z"||key=="ang_z"){
vector.z=arg
writedz=true
shouldwrite=false
}

if (writedx&&writedy&&writedz){
if (vararg) {
foreach (index,k in order){
if (k=="vector"){
args[index+1]<-vector;
writedx=false;
writedy=false;
writedz=false;
break
}
}
} else {
args["vector"]<-vector;
writedx=false;
writedy=false;
writedz=false;	
}
}

if (shouldwrite){
if (vararg) {
foreach (index,k in order){
if (k==key){
args[index+1]<-arg;
break;
}
}
}  else {
args[key]<-arg;	
}
}
}
return args
}