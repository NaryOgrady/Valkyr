extends State

onready var friction = owner.friction

func enter(_msg := {}) -> void:
	owner.anim.play('idle')


func physics_update(delta: float) -> void:
	owner.velocity.x = lerp(owner.velocity.x, 0, friction)
	owner.velocity.y += owner.gravity * delta
	owner.velocity = owner.move_and_slide(owner.velocity, Vector2.UP)
