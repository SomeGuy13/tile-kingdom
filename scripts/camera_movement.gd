extends Camera2D

@export var pan_speed: float = 400.0
@export var damping: float = 0.1

var target_position: Vector2

func _process(delta: float) -> void:
	# 25-11-12: Read input from keyboard and move the camera with smoothing
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength(("right")) - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength(("down")) - Input.get_action_strength(("up"))
	target_position += input_vector.normalized() * pan_speed * delta
	
	position = position.lerp(target_position, damping)

#var dragging = false
#var last_mouse_pos = Vector2.ZERO
#
#func _input(event):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#dragging = event.pressed
			#last_mouse_pos = event.position
			## print(dragging)
		#if event is InputEventMouseMotion:
			#print("movement")
		#elif event is InputEventMouseMotion and dragging:
			#position -= event.relative
