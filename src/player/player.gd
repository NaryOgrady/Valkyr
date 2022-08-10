extends KinematicBody2D

class_name Player

export (int) var speed = 150
export (int) var jump_speed = -280
export (int) var gravity = 700
export (float, 0, 1.0) var friction = 0.3
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO
var current_attack

onready var actor_position = $PlayerPosition
onready var anim = $AnimationPlayer
onready var state_machine = $StateMachine
onready var climb_check = $PlayerPosition/ClimbCheck
onready var collision = $CollisionShape2D
onready var height = collision.shape.height
