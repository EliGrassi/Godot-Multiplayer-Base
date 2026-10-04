class_name PlayerRoot extends Node3D

signal player_root_signal()


@export var player_state_machine: PlayerStateMachine = null
@export var player_character: CharacterBody3D = null
@export var player_camera: Camera3D = null
@export var player_inputs: PlayerInputEvents = null

# Called when the node enters the scene tree for the first time.

# Tell our state machine about this object so it can reference it and its children

# This technically breaks our design pattern because it means a child node understands
# its parent and siblings, but this is really just a work around to the fact
# that we cant extend several classes and make a 3D node also a state machine itself
# in principle, this parent node *is* the state machine, it just needs
# to hold the technical state machine object as a child

func _ready() -> void:
	player_state_machine.set_player_root(self)
