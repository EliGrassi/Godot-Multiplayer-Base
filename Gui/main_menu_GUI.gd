class_name MainMenu extends GuiBase


func _on_create_lobby_button_pressed() -> void:
	emit_gui_base_signal("CREATE_LOBBY")


func _on_join_lobby_button_pressed() -> void:
	emit_gui_base_signal("JOIN_LOBBY")
	
	
	
func _on_exit_game_button_pressed() -> void:
	emit_gui_base_signal("EXIT_GAME")
