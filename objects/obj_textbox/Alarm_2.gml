/// @description Dialogue Choice
//This is made to be an alarm so we can have a small "pause" after selecting a dialogue option

#region Update choice and page

//Change an object's variable according to choice if applicable
var cv = changevar[page];
if(cv != -1){
	var obj = cv[0];
	var var_name = cv[1];
	var new_val_array = cv[2];
	var _choice = choice;

	variable_instance_set(obj, var_name, new_val_array[choice]);
}

//Update page
if(page+1 < array_length_1d(text)){
	var nl = nextline[page];
	switch(nl[choice]){
		case -1: instance_destroy();	exit;
		case  0: page += 1;				break;
		default: page = nl[choice];
	}
	event_perform(ev_alarm, 0);
	
} else {
	instance_destroy();	
}

chosen = false;

#endregion