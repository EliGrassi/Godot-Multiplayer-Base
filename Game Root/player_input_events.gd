class_name PlayerInputEvents extends Node

@export var movement_vector: Vector2 = Vector2.ZERO
@export var jump_pressed: int = 0
@export var look_vector: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	#Poll for what movement keys are held down
	if is_multiplayer_authority():
		movement_vector = Input.get_vector("move_left", "move_right", "move_forward", "move_back")

func _unhandled_input(event: InputEvent) -> void:
	#Store mouse movement to rotate character
	if event is InputEventMouseMotion:
		var mouse_event: InputEventMouseMotion = event
		look_vector.x = -mouse_event.relative.x
		look_vector.y = -mouse_event.relative.y

#Gets the camera movement command and resets it to zero for the next read frame
#This way we dont perpetually rotate	
func get_look_movement() -> Vector2:
	var stored_vector: Vector2 = look_vector
	look_vector = Vector2.ZERO
	return stored_vector
