//=======================================//
//VUtil.Timer - Timer related functionality
//=======================================//

//Note: all called logic_timer located in VUtil.nut
//Not try rewrite this in hammer delay calls it just gonna hang game real fast

VUtil.Timer <- {};
VUtil.Timer.__Identifiers<-{}

function VUtil::Timer::Create(identifier,delay,repetitions,callback,scope=getroottable(),args=[]){
VUtil.Timer.__Identifiers[identifier]<-{repetitions_left=repetitions,repetitions=repetitions,next_trigger=Time()+delay,delay=delay,callback=callback,scope=scope,args=args};
}

function VUtil::Timer::Simple(delay,callback,scope=getroottable(),args=[]){
VUtil.Timer.__Identifiers[UniqueString("_timer")]<-{repetitions_left=1,repetitions=1,next_trigger=Time()+delay,delay=delay,callback=callback,scope=scope,args=args};
}

function VUtil::Timer::Destroy(identifier){
if (identifier in VUtil.Timer.__Identifiers){
	delete VUtil.Timer.__Identifiers[identifier];
}
}

function VUtil::Timer::Think(){
foreach (identifier,timer in VUtil.Timer.__Identifiers){
if (timer.next_trigger<Time()){
timer.next_trigger<-Time()+timer.delay
local scope=timer.scope
local callback=timer.callback
local args=timer.args
switch (args.len()){
	case 0:scope[callback]();break;
	case 1:scope[callback](args[0]);break;
	case 2:scope[callback](args[0],args[1]);break;
	case 3:scope[callback](args[0],args[1],args[2]);break;
	case 4:scope[callback](args[0],args[1],args[2],args[3]);break;
	case 5:scope[callback](args[0],args[1],args[2],args[3],args[4]);break;
	}
if (timer.repetitions>0){
timer.repetitions_left--
if (timer.repetitions_left<=0){
VUtil.Timer.Destroy(identifier)	
}
}
}
}
}