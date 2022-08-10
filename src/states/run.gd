extends State

onready var speed = owner.speed
onready var acceleration = owner.acceleration
onready var gravity = owner.gravity


func enter(_msg := {}) -> void:
	owner.anim.play('run')


func physics_update(delta: float) -> void:
	if not owner.is_on_floor():
		state_machine.transition('air')
		return
	
	if Input.is_action_just_pressed('jump'):
		state_machine.transition('air', { 'jump': true })
		return

	if Input.is_action_just_pressed('attack'):
		state_machine.transition('combat', { 'attack': 'slash'})
		return

	var dir = 0
	if Input.is_action_pressed("right"):
		dir += 1
		owner.actor_position.scale.x = 1
	if Input.is_action_pressed("left"):
		owner.actor_position.scale.x = -1
		dir -= 1
	if dir != 0:
		owner.velocity.x = lerp(owner.velocity.x, dir * speed, acceleration)
	else:
		state_machine.transition('idle')
	
	owner.velocity.y += gravity * delta
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
