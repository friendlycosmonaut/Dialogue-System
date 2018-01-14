///@description create_dialogue
///@arg Text
///@arg Speaker
///@arg *Effects
///@arg *Speed
///@arg *Type
///@arg *Next_Line
///@arg *Change_Variable
///@arg *Text_Col
///@arg *Emotion
///@arg *Emote

if(instance_exists(obj_textbox)){ exit; }

//Create the Textbox
var _textbox = instance_create_layer(x,y, "Text", obj_textbox);

//Get Arguments
var arg = 0, i = 0, arg_count = argument_count;
repeat(arg_count){ arg[i] = argument[i]; i++; } 

//Setup Default Variables
var _effects	= -1;
var _speed		= -1;
var _type		= -1; 
var _nextline	= -1;
var _changevar	= -1;
var _textcol	= -1;
var _emotion	= -1;
var _emotes		= -1;
var _creator	= id;

//Fill variables depending on argument count
switch(arg_count-1){
	case 9: _emotes		= arg[9];
	case 8: _emotion	= arg[8];
	case 7: _textcol	= arg[7];
	case 6: _changevar	= arg[6];
	case 5: _nextline	= arg[5];
	case 4: _type		= arg[4];
	case 3: _speed		= arg[3];
	case 2: _effects	= arg[2];
	default:
		var _text		= arg[0];
		var _speaker	= arg[1];	
		var _s			= _speaker;	//for assigning _speaker during repeat loop
	break;
}

//If Text or Speaker aren't arrays (single line input), make them arrays 
if(is_array(_text))		{ var text_len = array_length_1d(_text); }
else					{ var text_len = 1; _text[0] = _text;  }
if(!is_array(_speaker))	{ 
	if(_speaker == -1)	{ _s = id; }				//the default "-1" argument, ready for loop
	else				{ _speaker[0] = _speaker; }	//if we HAVE specified the speaker
}

//Fill arrays for default arguments
if(!is_array(_type)		and _type		== -1) { i = 0; repeat(text_len){ _type[i]		= 0;			i++; } }
if(!is_array(_nextline)	and _nextline	== -1) { i = 0; repeat(text_len){ _nextline[i]	= 0;			i++; } }
if(!is_array(_changevar)and _changevar	== -1) { i = 0; repeat(text_len){ _changevar[i]	= -1;			i++; } }
if(!is_array(_emotion)	and _emotion	== -1) { i = 0; repeat(text_len){ _emotion[i]	= 0;			i++; } }
if(!is_array(_emotes)	and _emotes		== -1) { i = 0; repeat(text_len){ _emotes[i]	= -1;			i++; } }
if(!is_array(_speaker)	and _speaker	== -1) { i = 0; repeat(text_len){ _speaker[i]	= _s;			i++; } }

var array_len, new_array, ai;

if(!is_array(_effects)	and _effects	== -1) { i = 0; repeat(text_len){ _effects[i]	= [1,0];		i++; } }
else {
	#region Fill with default values
	array_len = array_length_1d(_effects);
	if(array_len != text_len){ _effects[text_len-1] = 0; }
	ai = 0; repeat(text_len){
		if(_effects[ai] == 0){ _effects[ai] = [1,0]; }
		ai++;
	}
	#endregion
}

if(!is_array(_speed)	and _speed		== -1) { i = 0; repeat(text_len){ _speed[i]		= [1,0.5];		i++; } }
else {
	#region Fill with default values
	array_len = array_length_1d(_speed);
	if(array_len != text_len){ _speed[text_len-1] = 0; }
	ai = 0; repeat(text_len){
		if(_speed[ai] == 0){ _speed[ai] = [1,0.5]; }
		ai++;
	}
	#endregion
}

if(!is_array(_textcol)	and _textcol	== -1) { i = 0; repeat(text_len){ _textcol[i]	= [1,c_white];	i++; } }
else {
	#region Fill with default values
	array_len = array_length_1d(_textcol);
	if(array_len != text_len){ _textcol[text_len-1] = 0; }
	var def_col = _textbox.default_col;
	ai = 0; repeat(text_len){
		if(_textcol[ai] == 0){ _textcol[ai] = [1,def_col]; }
		ai++;
	}
	#endregion
}

//Change the Textbox Values
with(_textbox){
	creator		= _creator;
	effects		= _effects;
	text_speed	= _speed;
	type		= _type;
	text		= _text;
	nextline	= _nextline;
	changevar	= _changevar;
	text_col	= _textcol;
	emotion		= _emotion;	
	emotes		= _emotes;
	
	//Speaker's Variables
	i = 0; repeat(text_len){
		portrait[i]			= _speaker[i].myPortrait;
		voice[i]			= _speaker[i].myVoice;
		font[i]				= _speaker[i].myFont;
		name[i]				= _speaker[i].myName;
		speaker[i]			= _speaker[i];
		
		if(variable_instance_exists(_speaker[i], "myPortraitTalk"))		{ portrait_talk[i] = _speaker[i].myPortraitTalk; }
		else { portrait_talk[i] = -1; }
		if(variable_instance_exists(_speaker[i], "myPortraitTalk_x"))	{ portrait_talk_x[i] = _speaker[i].myPortraitTalk_x; }
		else { portrait_talk_x[i] = -1; }
		if(variable_instance_exists(_speaker[i], "myPortraitTalk_y"))	{ portrait_talk_y[i] = _speaker[i].myPortraitTalk_y; }
		else { portrait_talk_y[i] = -1; }
		if(variable_instance_exists(_speaker[i], "myPortraitIdle"))		{ portrait_idle[i] = _speaker[i].myPortraitIdle; }
		else { portrait_idle[i] = -1; }
		if(variable_instance_exists(_speaker[i], "myPortraitIdle_x"))	{ portrait_idle_x[i] = _speaker[i].myPortraitIdle_x; }
		else { portrait_idle_x[i] = -1; }
		if(variable_instance_exists(_speaker[i], "myPortraitIdle_y"))	{ portrait_idle_y[i] = _speaker[i].myPortraitIdle_y; }
		else { portrait_idle_y[i] = -1; }
		
		
		if(portrait_talk[i] != -1){ 
			portrait_talk_n[i] = sprite_get_number(portrait_talk[i]);
			portrait_talk_s[i] = sprite_get_speed(portrait_talk[i])/room_speed;
		}
		if(portrait_idle[i] != -1){ 
			portrait_idle_n[i] = sprite_get_number(portrait_idle[i]);
			portrait_idle_s[i] = sprite_get_speed(portrait_idle[i])/room_speed;
		}
		i++;
	}
	
	draw_set_font(font[0]);
	charSize = string_width("M");
	stringHeight = string_height("M");
	event_perform(ev_alarm, 0);	//makes textbox perform "setup"
}

myTextbox = _textbox;
return _textbox;