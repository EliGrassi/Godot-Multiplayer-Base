extends LobbyGuiState


var state_running: bool = false

func enter() -> void:
	state_running = true
	#Free the mouse and display the rest of the menu background
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	lobby_machine.lobby_gui.menu_open_elements.visible = true

#Listen for the escape key and close the menu if it is pressed
func _input(event: InputEvent) -> void:
	if state_running and event is InputEventKey:
		var key_event: InputEventKey = event
		if key_event.pressed and key_event.keycode == KEY_ESCAPE:
			get_viewport().set_input_as_handled()
			state_switched.emit("MenuClosed")
			

func exit() -> void:
	state_running = false
