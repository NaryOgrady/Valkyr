extends Node

class_name StateMachine

signal transitioned(state_name)

onready var state: State = get_child(0)

func _ready() -> void:
	yield(owner, 'ready')
	for child in get_children():
		child.state_machine = self
	state.enter()


func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func transition(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		print('missing state')
		return
	
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal('transitioned', state.name)
