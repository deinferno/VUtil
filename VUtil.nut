//==================================//
//A VScript Utility Library for CSGO
//==================================//

::VUtil <- {};

//Hey to use full functionality of VUtil you need to create event listeners for listed events ("player_use","item_equip")

IncludeScript("VUtil/Constants.nut");
IncludeScript("VUtil/Math.nut");
IncludeScript("VUtil/Entity.nut");
IncludeScript("VUtil/Logic.nut");
IncludeScript("VUtil/Timer.nut");
IncludeScript("VUtil/Event.nut");
IncludeScript("VUtil/Player.nut");
IncludeScript("VUtil/Physics.nut");
IncludeScript("VUtil/Debug.nut");
IncludeScript("VUtil/PostInit.nut");

printl("VUtil loaded.")