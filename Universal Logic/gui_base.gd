class_name GuiBase extends Control

signal gui_base_signal(message: StringName, payload: Variant)

func emit_gui_base_signal(message: StringName, payload: Variant = null) -> void:
		gui_base_signal.emit(message, payload)
