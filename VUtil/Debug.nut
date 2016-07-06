//=========================================//
//VUtil.Debug - Debug Draw helper functions
//=========================================//

VUtil.Debug <- {};

//Draws the entity's bounding box
function VUtil::Debug::DrawEntityBBox(entity,r,g,b,a,time = 0.15)
{
	DebugDrawBox(entity.GetOrigin(),entity.GetBoundingMins(), entity.GetBoundingMaxs(), r, g, b, a, time)
}

//Draws the entity's local direction vectors
function VUtil::Debug::DrawEntityVectors(entity,size,xray = false,time = 0.15)
{
	local origin = entity.GetOrigin();
	DebugDrawLine(origin, origin + (entity.GetLeftVector() * size), 255, 0, 0, xray, time)
	DebugDrawLine(origin, origin + (entity.GetForwardVector() * size), 0, 255, 0, xray, time)
	DebugDrawLine(origin, origin + (entity.GetUpVector() * size), 0, 0, 255, xray, time)
}

//Draws the entity's attachments
function VUtil::Debug::DrawEntityAttachments(entity,size,xray = false,time = 0.15) //No way to get the number of attachments so assume there are 32 or less
{
	local entOrigin = entity.GetOrigin();
	
	for(local i = 0;i < 128;i++)
	{
		local origin = entity.GetAttachmentOrigin(i);
		//local angles = entity.GetAttachmentAngles(i); //todo
		
		if(i != 0 && VUtil.Math.VectorEqual(entOrigin, origin)) //If the attachment doesn't exist then origin will equal the entity's origin.
		{
			break; //This attachment doesn't exist so stop and assume we have drawn all of them.
		}
		
		DebugDrawLine(origin, origin + (Vector(1,0,0) * size), 255, 0, 0, xray, time)
		DebugDrawLine(origin, origin + (Vector(0,1,0) * size), 0, 255, 0, xray, time)
		DebugDrawLine(origin, origin + (Vector(0,0,1) * size), 0, 0, 255, xray, time)
	}
}

function VUtil::Debug::DrawCross(origin,size,xray = false,time = 0.15)
{
	DebugDrawLine(origin - (Vector(1,0,0) * size), origin + (Vector(1,0,0) * size), 255, 0, 0, xray, time)
	DebugDrawLine(origin - (Vector(0,1,0) * size), origin + (Vector(0,1,0) * size), 0, 255, 0, xray, time)
	DebugDrawLine(origin - (Vector(0,0,1) * size), origin + (Vector(0,0,1) * size), 0, 0, 255, xray, time)
}


function VUtil::Debug::PrintTable(table,tablename="",spaces=0){
local spaces_string=""
for (local i=0;i<spaces;i++){
	spaces_string+=" "
}
printl(spaces_string+(tablename!=""&&tablename+"  <-  "||"")+(typeof(table)=="table"&&"{"||"["))
local nokey=false
if (typeof(table)=="array"){
nokey=true
}
spaces_string+="  "
foreach(key,value in table){
if (typeof(value)=="table"||typeof(value)=="array"){
VUtil.Debug.PrintTable(value,(nokey&&""||key),spaces+4)
} else if (typeof(value)=="string"){
local double_quote=@""""
printl(spaces_string+(nokey&&""||key.tostring()+"  <-  ")+double_quote+value.tostring()+double_quote+",")
} else {
printl(spaces_string+(nokey&&""||key.tostring()+"  <-  ")+value.tostring()+",")
}
}
local spaces_string=""
for (local i=0;i<spaces;i++){
	spaces_string+=" "
}
printl(spaces_string+(typeof(table)=="table"&&"}"||"]")+(spaces!=0&&","||""))
}