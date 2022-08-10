extends Attack


func physics_update(_delta: float) -> void:
	yield(owner.anim, 'animation_finished')

	if Input.is_action_pressed('attack'):
		# make different script for each move
		# work on input controller that stores
		combat.transition('slash')
		return
	
	emit_signal('attack_finish')
