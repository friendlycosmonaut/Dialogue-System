var view = view_camera[0];
gui_width = camera_get_view_width(view);
gui_height = camera_get_view_height(view);

if(instance_exists(following)){
	var new_x = following.x - gui_width/2;
	var new_y = following.y - gui_height/2;
	camera_set_view_pos(view, new_x, new_y);
}

room_w = room_width;
room_h = room_height;