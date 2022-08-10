extends State

var current_attack
var attack_in_progress = false

func enter(_msg := {}) -> void:
	if not _msg.has('attack'):
		return
	var attack_name = _msg.attack
	current_attack = get_node(attack_name)
	current_attack.connect('attack_finish', self, '_handle_attack_finish')
	current_attack.combat = self
	current_attack.init()
	attack_in_progress = true


func physics_update(delta: float) -> void:
	if attack_in_progress:
		current_attack.physics_update(delta)
		return

	if Input.is_action_pressed('right') || Input.is_action_pressed('left'):
		state_machine.transition('run')
		return
	
	state_machine.transition('idle')


func _handle_attack_finish() -> void:
	attack_in_progress = false

func transition(attack_name):
	current_attack.disconnect('attack_finish', self, '_handle_attack_finish')	
	enter({ 'attack': attack_name })
