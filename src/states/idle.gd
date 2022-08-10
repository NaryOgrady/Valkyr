extends State

onready var friction = owner.friction

func enter(_msg := {}) -> void:
	owner.anim.play('idle')


func physics_update(delta: float) -> void:
	if not owner.is_on_floor():
		state_machine.transition('air')
		return
	
	if Input.is_action_just_pressed('jump'):
		state_machine.transition('air', { 'jump': true })
		return

	if Input.is_action_just_pressed('attack'):
		state_machine.transition('combat', {'attack': 'slash'})
		return

	if Input.is_action_just_pressed('right') || Input.is_action_just_pressed('left'):
		state_machine.transition('run')

	# TODO: move this to the stopping motion for better animation
	owner.velocity.x = lerp(owner.velocity.x, 0, friction)

