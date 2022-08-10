extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = owner.health
	value = owner.health


func _process(_delta):
	if value < max_value:
		visible = true
	value = owner.health
