class_name MapBase extends Node3D

signal map_base_signal(message: StringName, payload: Variant)

func emit_map_base_signal(message: StringName, payload: Variant = null) -> void:
		map_base_signal.emit(message, payload)
