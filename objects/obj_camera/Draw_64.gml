draw_set_font(fnt_debug);

var i = 0;
draw_text(10, 10+(i*30), "CONTROLS"); i++;
draw_text(10, 10+(i*30), "Move: Arrow keys"); i++;
draw_text(10, 10+(i*30), "Text Event: Space"); i++;
draw_text(10, 10+(i*30), "Interact: E"); i++;
draw_text(10, 10+(i*30), "Debug: D"); i++;


if(debug){
	draw_set_halign(fa_right);
	i = 0;
	var gw = display_get_gui_width();
	
	draw_text(gw-10, 10+(i*30), "Textbox Instances = "+string(instance_number(obj_textbox))); i++;
	draw_text(gw-10, 10+(i*30), "Text Event Instances = "+string(instance_number(obj_textevent))); i++;
	
	if(instance_exists(obj_textbox)){
		var tb = instance_find(obj_textbox, 0);	
		i++;
		with(tb) {
			draw_text(gw-10, 10+(i*30), "charCount = "+string(floor(charCount))); i++;
			draw_text(gw-10, 10+(i*30), "String Length = "+string(string_length(text_NE))); i++;
			draw_text(gw-10, 10+(i*30), "Choice = "+string(choice)); i++;
		}
	}
	with(obj_examplechar){
		i++;
		draw_text(gw-10, 10+(i*30), "choice_variable = "+string(choice_variable)); i++;
	}
	
	draw_set_halign(fa_left);
}