extends PlayerState


#The default character state. Lets you move and look around


#Controls for movement speed and camera speed
var speed: float = 100
var look_speed: float  = 0.1

#Prevent the camera from rotating in circles up or down
var max_pitch: float = deg_to_rad(89.0)
var min_pitch: float = deg_to_rad(-89.0)

func enter() -> void:
	pass
	
func process(delta: float) -> void:
	var input: PlayerInputEvents = player_machine.player_root.player_inputs
	var character: CharacterBody3D = player_machine.player_root.player_character
	var camera: Camera3D = player_machine.player_root.player_camera
	
	#Get the stored camera rotation from our input component
	var camera_move_vector: Vector2 = input.get_look_movement()
	#Rotate the player body about the y axis
	character.rotate_y(camera_move_vector.x * delta)
	#Just rotate the camera about the x axis for now, we dont want
	#to tilt the player up and down
	camera.rotate_x(camera_move_vector.y * delta)
	camera.rotation.x = clamp(camera.rotation.x, min_pitch, max_pitch)	
	
	
func physics(delta: float) -> void:
	var input: PlayerInputEvents = player_machine.player_root.player_inputs
	var character: CharacterBody3D = player_machine.player_root.player_character
	var camera: Camera3D = player_machine.player_root.player_camera
	
	#Move the player based on our input nodes stored wasd commands
	var move_vec: Vector2 = input.movement_vector
	move_vec *= delta * speed
	character.velocity = Vector3(move_vec.x ,0, move_vec.y)
	

	
	player_machine.player_root.player_character.move_and_slide()
	
func exit() -> void:
	pass
