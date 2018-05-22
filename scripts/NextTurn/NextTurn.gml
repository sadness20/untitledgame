var ob = argument[0];


global.selectedActor = noone;
CleanNodes();

global.cturn ++;
if(global.cturn >= ds_list_size(global.units))
{
	global.cturn = 0;
}

ob.MP = ob.MAXMP;
ob.AP = ob.MAXAP;

//reset ai
ran = false;