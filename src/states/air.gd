extends State

onready var speed = owner.speed
onready var acceleration = owner.acceleration
onready var gravity = owner.gravity
onready var jump_speed = owner.jump_speed

func enter(_msg := {}) -> void:
	if _msg.has('jump'):
		owner.velocity.y = jump_speed


func physics_update(delta: float) -> void:
	var dir = 0
	if Input.is_action_pressed("right"):
		dir += 1
		owner.actor_position.scale.x = 1
	if Input.is_action_pressed("left"):
		owner.actor_position.scale.x = -1
		dir -= 1
	if dir != 0:
		owner.velocity.x = lerp(owner.velocity.x, dir * speed, acceleration)

	owner.velocity.y += gravity * delta

	if owner.velocity.y < 0:
		owner.anim.play('jump')
	else:
		owner.anim.play('fall')

	if Input.is_action_just_pressed('jump'):
		if owner.climb_check.is_climbable():
			state_machine.transition(
				'climb',
				{ "climbing_point": owner.climb_check.climbing_point }
			)

	if owner.is_on_floor():
		if is_equal_approx(owner.velocity.x, 0.0):
			state_machine.transition('idle')
		else:
			state_machine.transition('run')

	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
