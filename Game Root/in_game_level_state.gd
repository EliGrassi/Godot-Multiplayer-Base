extends GameState


func enter() -> void:
	multiplayer.server_disconnected.connect(server_down)
	game_machine.gui_master.unload_gui()
	
	
func server_down() -> void:
	game_machine.switch_state("GameBaseState")
	
	
func exit() -> void:
	multiplayer.server_disconnected.disconnect(server_down)
	game_machine.world_master.unload_map()
