extends Attack

var moving = false

func physics_update(delta: float) -> void:
	if not moving:
		owner.velocity.x = lerp(owner.velocity.x, 0, friction)
	else:
		var dir = owner.actor_position.scale.x
		owner.velocity.x = lerp(owner.velocity.x, dir * speed, acceleration)

	owner.velocity.y += gravity * delta
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	yield(owner.anim, 'animation_finished')

	if Input.is_action_pressed('attack'):
		# make different script for each move
		# work on input controller that stores
		combat.transition('slash')
		return
	
	emit_signal('attack_finish')

func _set_moving(value: bool) -> void:
	moving = value
