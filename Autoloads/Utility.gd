extends Node

#Returns the ID of a key in a Dictionary
static func get_enum_key_at_index(enumerator: Dictionary, index: int) -> String:
	return enumerator.keys()[index]

#Sets the names of variables in a dictionary based on their key.
static func set_keys_to_names(dict: Dictionary) -> void:
	var keys: Array = dict.keys()
	if dict[keys[0]] is RefCounted:
		for key in keys:
			dict[key].set_name_var(key)
	else:
		print("Error: Dictionary must have instanced references in it.")
