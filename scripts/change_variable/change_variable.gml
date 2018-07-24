///@description change_variable
///@arg obj
///@arg var_name_as_string
///@arg new_value

with(argument0) var oid = id;
variable_instance_set(oid, argument1, argument2);