class_name LobbyGui extends GuiBase

@export var menu_open_elements: Control = null
@export var lobby_gui_state_machine: LobbyGuiStateMachine = null

func _ready() -> void:
	lobby_gui_state_machine.set_lobby_gui(self)


func _on_button_2_pressed() -> void:
	emit_gui_base_signal("START_GAME")
