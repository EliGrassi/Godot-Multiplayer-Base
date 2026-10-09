extends GameState



	
func enter() -> void:
	#Connect function to trigger if we disconnect from the server
	multiplayer.server_disconnected.connect(server_down)
	
	#Allow new connections when we are in the lobby
	multiplayer.multiplayer_peer.refuse_new_connections = false
	
	#Load the lobby GUI upon joining a game
	game_machine.gui_master.load_gui_from_id(2)
	
	#Connect GUI messages
	game_machine.gui_master.gui_message.connect(read_signals)
	
	#Load the lobby map upon joining a game
	game_machine.world_master.load_map_from_id(1)
	
#RPC function that starts the game. The server will call this
#and the clients will all listen for it.
@rpc("authority", "call_local", "reliable")
func start_game() -> void:
	game_machine.switch_state("InGameLevelState")
	
	

#Start the game if we get the message from the GUI.
#This function is connected to our GUI signals
func read_signals(message: StringName, payload: Variant) -> void:
	match message:
		"START_GAME":
			#Call the RPC start game function to let clients know
			#that the game is starting
			start_game.rpc()
			
	
	
#When we disconnect from the server, we need to switch back to the main
#menu state.
func server_down() -> void:
	state_switched.emit("GameBaseState")


func exit() -> void:
	#Disconnect this states signals
	game_machine.gui_master.gui_message.disconnect(read_signals)
	multiplayer.server_disconnected.disconnect(server_down)
	#Have the server not let people connect anymore if not in lobby
	multiplayer.multiplayer_peer.refuse_new_connections = true
