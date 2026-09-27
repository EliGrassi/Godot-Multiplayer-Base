extends GameState



	
func enter() -> void:
	multiplayer.server_disconnected.connect(server_down)
	game_machine.gui_master.load_gui_from_id(2)
	if !game_machine.gui_master.gui_message.is_connected(read_signals):
		game_machine.gui_master.gui_message.connect(read_signals)
	
@rpc("authority", "call_local", "reliable")
func start_game() -> void:
	game_machine.world_master.load_map_from_id(1)
	game_machine.switch_state("InGameLevelState")
	
	
	
func read_signals(message: StringName, payload: Variant) -> void:
	match message:
		"START_GAME":
			start_game.rpc()
			
	
	

func server_down() -> void:
	game_machine.switch_state("GameBaseState")


func exit() -> void:
	multiplayer.server_disconnected.disconnect(server_down)
