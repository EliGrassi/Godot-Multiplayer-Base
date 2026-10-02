class_name PlayerInputEvents extends Node

@export var movement_vector: Vector2 = Vector2.ZERO
@export var jump_pressed: int = 0
@export var look_vector: Vector3 = Vector3(0, 0, 0)


func _physics_process(delta: float) -> void:
	if is_multiplayer_authority():
		movement_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
