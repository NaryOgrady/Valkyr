extends State

onready var friction = owner.friction

var attacker: Player
var attack: Attack
var dir = Vector2.ZERO

func enter(_msg := {}) -> void:
	if not _msg.has('attacker'):
		print('missing attacker on msg.')
		return
	attacker = _msg.attacker
	attack = attacker.current_attack

	print('attacker', attacker.position.x)
	print('enemy', owner.position.x)
	if attacker.position.x > owner.position.x:
		dir = Vector2.LEFT
	else:
		dir = Vector2.RIGHT

	owner.anim.play('take_damage')
	$Timer.start(0.4)


func physics_update(delta: float) -> void:
	owner.velocity.x = lerp(attack.knockback.x * dir.x, 0, friction * 2.7)
	owner.velocity.y = attack.knockback.y

	owner.velocity.y += (owner.gravity * 3) * delta
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)


func _on_Timer_timeout():
	state_machine.transition('idle')
