extends State

onready var climb_speed = owner.jump_speed / 4
onready var gravity = owner.gravity

var climbing 
var climbing_point

func enter(_msg := {}) -> void:
	if not _msg.has('climbing_point'):
		print('missing climbing point on climb state')
	climbing_point = _msg.climbing_point
	owner.velocity = Vector2.ZERO
	


func physics_update(delta: float) -> void:
	if Input.is_action_just_pressed('down'):
		climbing = false
		state_machine.transition('air')
	if Input.is_action_just_pressed('up'):
		climbing = true
		owner.velocity.y = climb_speed
		owner.get_node('CollisionShape2D').disabled = true

	if climbing:
		owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
	
	if owner.position.y < climbing_point.position.y:
		state_machine.transition('idle')


func exit():
	owner.velocity = Vector2.ZERO
	climbing = false
	owner.get_node('CollisionShape2D').disabled = false
