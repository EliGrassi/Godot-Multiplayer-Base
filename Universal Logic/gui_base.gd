class_name GuiBase extends Control

#This is a base class for all GUI's. it allows them to send signals upwards


signal gui_base_signal(message: StringName, payload: Variant)

func emit_gui_base_signal(message: StringName, payload: Variant = null) -> void:
		gui_base_signal.emit(message, payload)
