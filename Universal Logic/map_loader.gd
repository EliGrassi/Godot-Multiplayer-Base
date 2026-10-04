class_name MapLoader extends Node


#Class for loading and deloading maps. keeps track of what map is currently loaded
#and switches it out to new ones when asked

signal map_message(message: StringName, payload: Variant)

@export var player_spawner: PlayerSpawner = null
@export var entity_spawner: MultiplayerSpawner = null


var loaded_map: MapBase = null


#Dictonary of our maps. We load a map by calling load_map_from_id with its ID
#in the dictionary
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

#This just unloads the current map if it exists
func unload_map() -> void:
	if loaded_map != null:
		loaded_map.queue_free()
