extends Node

class_name Attack

signal attack_finish

export (int) var damage: int = 0
export(Vector2) var knockback: Vector2

onready var speed = owner.speed / 9
onready var acceleration = owner.acceleration
onready var gravity = owner.gravity
onready var friction = owner.friction

var combat

func init() -> void:
	owner.anim.play(self.name)
	owner.current_attack = self


func physics_update(_delta: float) -> void:
	print('You need to overwrite this physiscs_update')
	pass	
