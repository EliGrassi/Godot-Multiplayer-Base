class_name StateMachine extends Node

@export var states: Array[State] = []
@export var current_state: State = null


signal pass_message(message: String)


var state_names: Dictionary[StringName,State] = {}
var target_agent: Node = null
var agent_added: bool = false

func add_agent(agent: Node) -> void:
	target_agent = agent
	agent_added = true
	

func _ready() -> void:
	
	if current_state == null:
		print("State machine has no initial state!")
		return 
		
	for state: State in states:
		state.parent_machine = self
		state_names[state.name] = state
		state.state_switched.connect(switch_state)
	current_state.enter()

func _physics_process(delta: float) -> void:
	if current_state.has_method("physics"):
		current_state.physics(delta)

func switch_state(state_name: StringName) -> void:
	current_state.exit()
	current_state = state_names[state_name]
	current_state.enter()
	
