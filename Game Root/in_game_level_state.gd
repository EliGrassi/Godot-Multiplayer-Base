extends GameState


func enter() -> void:
		
	#Connect function to check for the server closing
	multiplayer.server_disconnected.connect(server_down)
	
	game_machine.gui_master.unload_gui()
	#Lock mouse on screen in fps view
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

#Return to the main menu when the server closes
func server_down() -> void:
	state_switched.emit("GameBaseState")
	
	
func exit() -> void:
	multiplayer.server_disconnected.disconnect(server_down)
	game_machine.world_master.unload_map()
	#Unlock mouse
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
