extends GameState


	

func read_signals(message: StringName, payload: Variant) -> void:
	match message:
		"CREATE_LOBBY":
			game_machine.network_creator.open_server()
		"JOIN_LOBBY":
			game_machine.network_creator.join_server()
		"EXIT_GAME":
			get_tree().quit()
			return
	game_machine.switch_state("GameMenuState")
	
func enter() -> void:
	if !game_machine.gui_master.gui_message.is_connected(read_signals):
		game_machine.gui_master.gui_message.connect(read_signals)
	game_machine.gui_master.load_gui_from_id(1)
	return

func exit() -> void:
	game_machine.gui_master.unload_gui()
