class_name MapLoader extends Node


signal map_message(message: StringName, payload: Variant)

var loaded_map: MapBase = null

var map_dict: Dictionary[int, Resource] = {
	1: preload("res://Maps/first_level.tscn")
}

#Deletes any existing GUI and replaces it with a new loaded one
func load_map_from_id(id: int) -> void:
	print("loading map "+str(id))
	if loaded_map != null:
		loaded_map.queue_free()
	loaded_map = map_dict[id].instantiate()
	#Connect the GUIs signal to this one to pass up messages to the game
	loaded_map.map_base_signal.connect(func(message: StringName, payload: Variant) -> void:
		map_message.emit(message, payload)
		)
	#Parent the GUI to the scene tree GUI manager
	add_child(loaded_map)
	
func unload_map() -> void:
	if loaded_map != null:
		loaded_map.queue_free()
