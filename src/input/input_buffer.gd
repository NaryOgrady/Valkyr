extends Label

var buffersize = 7
var wait = 0.2
var input_buffer = []
var prev_joy


func _init() -> void:
	input_buffer.resize(buffersize)


func _ready() -> void:
	$Timer.wait_time = wait


func _process(delta: float) -> void:
	_get_joy()
	text = str(input_buffer)


func _get_joy() -> void:
	var button = ''
	var joy = Vector2(0, 0)

	if Input.is_action_just_pressed('right'):
		joy.x = 1
	elif Input.is_action_just_pressed('left'): 
		joy.x = -1
	
	if Input.is_action_just_pressed('up'):
		joy.y = -1
	elif Input.is_action_just_pressed('down'): 
		joy.y = 1

	if Input.is_action_just_pressed('attack'):
		button = 'A'
	
	if (joy == prev_joy and not button):
		return

	for i in buffersize - 1:
		input_buffer[i] = input_buffer[i + 1]

	input_buffer[buffersize - 1] = _get_direction(joy) + button
	
	prev_joy = joy
	button = ''
	

func _get_direction(joy):
	var index = str(joy.x) + str(joy.y)
	var directions = {
		'10': 'E',
		'-10': 'W',
		'0-1': 'N',
		'01': 'S',
		'1-1': 'NE',
		'11': 'SE',
		'-1-1': 'NW',
		'-11': 'SW',
		'00': 'NN'
	}
	return directions[index]
