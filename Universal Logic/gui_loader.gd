class_name GuiLoader extends Node


signal gui_message(message: StringName, payload: Variant)

var loaded_gui: GuiBase = null

var gui_dict: Dictionary[int, Resource] = {
	1: preload("res://Gui/main_menu_GUI.tscn"),
	2: preload("res://Gui/lobby_GUI.tscn")
}

#Deletes any existing GUI and replaces it with a new loaded one
func load_gui_from_id(id: int) -> void:
	if loaded_gui != null:
		loaded_gui.queue_free()
	loaded_gui = gui_dict[id].instantiate()
	#Connect the GUIs signal to this one to pass up messages to the game
	loaded_gui.gui_base_signal.connect(func(message: StringName, payload: Variant) -> void:
		gui_message.emit(message, payload)
		)
	#Parent the GUI to the scene tree GUI manager
	add_child(loaded_gui)
	
func unload_gui() -> void:
	if loaded_gui != null:
		loaded_gui.queue_free()
