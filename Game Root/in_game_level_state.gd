extends GameState


func enter() -> void:
	multiplayer.server_disconnected.connect(server_down)
	game_machine.gui_master.unload_gui()
	#Lock mouse on screen in fps view
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
func server_down() -> void:
	game_machine.switch_state("GameBaseState")
	
	
func exit() -> void:
	multiplayer.server_disconnected.disconnect(server_down)
	game_machine.world_master.unload_map()
	#Unlock mouse
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
