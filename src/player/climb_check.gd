extends Area2D

var climbing_point = null

func is_climbable():
	for area in get_overlapping_areas():
		if area.is_in_group('Climbable'):
			climbing_point = area.get_node('CollisionShape2D')
			return true

	climbing_point = null
	return false

