///@description Setup
//Must be done AFTER the handover occurs, so frame after created, and after every text page change

#region Reset variables
charCount		= 0;
finishede_count = 0;
portrait_talk_c = 0;
portrait_idle_c = 0;
text_speed_c	= 0;
audio_c			= 0;
charCount_f		= 0;
effects_p		= effects[page];
text_col_p		= text_col[page];

text_speed_al	= array_length_1d(text_speed[page])/2;
effects_al		= array_length_1d(effects[page])/2;
text_col_al		= array_length_1d(text_col[page])/2;

if(portrait[page] == -1){
	pos_x			= (gb_diff/2);
	finishede_x		= pos_x + boxWidth - x_buffer;
} else {
	pos_x			= (gb_diff/2)+(portraitWidth/2);
	finishede_x		= pos_x + boxWidth - x_buffer;
}

draw_set_font(font[page]);
charSize = string_width("M");		//gets new charSize under current font
charHeight = string_height("M");	//same for width
#endregion

#region GET THE BREAKPOINTS AND TEXT EFFECTS
//Again only need to do this if our CURRENT page is "normal". Separated from above for readability.
if(type[page] == 0){
	text_NE = text[page]; 
	str_len = string_length(text_NE);
	
	//Get variables ready
	var by = 0, ty = 0, cc = 1, breakpoint = 0;
	var next_space = 0, char, txtwidth = boxWidth-(2*x_buffer), char_max = txtwidth div charSize;

	//Reset the text effects and breakpoints arrays
	text_effects = -1;
	breakpoints = -1;
	
	//Loop through and save the effect positions and breakpoints
	repeat(str_len){
		//Save Effect Positions
		char = string_char_at(text[page], cc);
		
		//Get next space, deal with new lines
		if(cc >= next_space){
			next_space = cc;
			while(next_space < str_len and string_copy(text_NE, next_space,1) != " ") next_space++;
			var linewidth = (next_space-breakpoint)*charSize;
			if (linewidth >= txtwidth) { breakpoint = cc; breakpoints[by] = cc; by++; } 
		}
	
		cc++;
	}
}
#endregion
			
#region Get the emotes
if(emotes != -1 and emotes[page] != -1){
	var sp = speaker[page]; var ep = emotes[page];
	var obj = instance_create_layer(sp.x,sp.y-sp.sprite_height-2,"Text",obj_emote);
	var spr = emote_sprite;
	with(obj){
		sprite_index = spr;
		image_index = ep;
		creator = sp;
		mode = 1;
	}
}
#endregion
