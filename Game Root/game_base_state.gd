extends GameState


	

func read_signals(message: StringName, payload: Variant) -> void:
	match message:
		"CREATE_LOBBY":
			game_machine.network_creator.open_server()
			#Let our player spawner know it can start spawning people
			#because we are now the host
			#We cant just have an is_server() check on it because every node
			#thinks its the server before a multiplayer connection is started,
			#and this node exists by default in the scene tree.
			game_machine.world_master.player_spawner.start_host()
			#Enter the game menu state when you start the lobby
			state_switched.emit("GameLobbyState")
		"JOIN_LOBBY":
			game_machine.network_creator.join_server()
		"EXIT_GAME":
			get_tree().quit()
			return
	
	
func enter() -> void:
	#Connect our GUI signals to this states read_signals function
	game_machine.gui_master.gui_message.connect(read_signals)
	
	#Load the main menu's GUI
	game_machine.gui_master.load_gui_from_id(1)
	
	#Tells our spawner we arent the host anymore if we enter the main menu
	#(No one has hosted a lobby yet from this state)
	if game_machine.world_master.player_spawner.hosting:
		game_machine.world_master.player_spawner.stop_host()
		
	#Connect the signal for a client connecting to a server to a function
	#that switches us into the menu/lobby state
	game_machine.network_creator.confirm_client_connected.connect(client_connection_success)
	return
	
#This function transitions us into the lobby state when a server confirms
#that we have connected to it.
func client_connection_success(_id: int) -> void:
	state_switched.emit("GameLobbyState")

func exit() -> void:
	#disconnect signals
	game_machine.network_creator.confirm_client_connected.disconnect(client_connection_success)
	game_machine.gui_master.gui_message.disconnect(read_signals)
	
	#Remove the GUI
	game_machine.gui_master.unload_gui()
