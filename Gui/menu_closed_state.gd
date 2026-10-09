extends LobbyGuiState

var state_running: bool = false


func enter() -> void:
	state_running = true
	#Capture the mouse and close the menu's background panel
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	lobby_machine.lobby_gui.menu_open_elements.visible = false

#Listen for the escape key and open the menu if it is pressed
func _unhandled_input(event: InputEvent) -> void:
	if state_running and event is InputEventKey:
		var key_event: InputEventKey = event
		if key_event.pressed and key_event.keycode == KEY_ESCAPE:
			get_viewport().set_input_as_handled()
			state_switched.emit("MenuOpen")
			

func exit() -> void:
	state_running = false
