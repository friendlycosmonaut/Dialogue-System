var cv = executeScript[page];
if(is_array(cv)){
	var len = array_length_1d(cv)-1;
	var cva = array_create(len, 0);
	array_copy(cva, 0, cv, 1, len);
	var c = cva;
	script_execute_alt(cv[0], cva);
}