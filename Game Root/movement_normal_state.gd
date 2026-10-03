extends PlayerState


var speed: float = 100


func enter() -> void:
	pass
	
func physics(delta: float) -> void:
	var move_vec: Vector2 = player_machine.player_root.player_inputs.movement_vector
	move_vec *= delta * speed
	player_machine.player_root.player_character.velocity = Vector3(move_vec.x ,0, move_vec.y)
	player_machine.player_root.player_character.move_and_slide()
	
func exit() -> void:
	pass
