extends KinematicBody2D

export (int) var health: int = 0
export (int) var speed = 150
export (int) var jump_speed = -280
export (int) var gravity = 300
export (float, 0, 1.0) var friction = 0.3
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO

onready var actor_position = $PlayerPosition
onready var anim = $EnemyPosition/AnimatedSprite
onready var state_machine = $StateMachine

func _on_Hurtbox_area_entered(area):
	state_machine.transition('take_damage', { 'attacker': area.owner })
	health -= area.owner.current_attack.damage
	if health <= 0:
		queue_free()
