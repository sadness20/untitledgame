/// @description Insert description here
// You can write your code in this editor
gridX = 0;
gridY = 0;

movementPath = path_add();
path_set_kind(movementPath, 2);
path_set_closed(movementPath, false);

moveSpeed = 6;
state = "idle";
lead = -1;


SPRITE = spr_severa;
INI = 10;

MAXHP = 10;
HP = MAXHP;

MAXMP = 4;
MP = MAXMP;

MAXAP = 4;
AP = MAXAP;