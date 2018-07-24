following = obj_player;
freeze = false;
debug = false;

create_textevent(
	["Welcome to the demo of the dialogue system! Hit 'E' to go to the next page.", 
	"This is an example of a one-time 'text event'. It runs when the game starts.", 
	"Hit 'Space' to make a player monologue happen. And 'D' to toggle debug."],
	-1,
	[ [1,1, 9,2, 16,4], -1, [1,3]],
	[ [1,0.2, 4,2, 10, 0.5]],
	-1,
	-1,
	-1,
	[ [1,c_lime, 9,c_fuchsia, 16,c_aqua] ],
	-1,
	-1,
	
);

show_debug_overlay(true);