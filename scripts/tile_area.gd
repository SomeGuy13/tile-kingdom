extends Area2D

@onready var square = $"../Polygon2D"
@onready var main_manager = $".."
@onready var label = $"../HealthLabel"

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		# Decrease health when clicked, capture the tile if health is low
		if event.is_pressed() and event.button_index == 1 and get_parent().captured == false:
			main_manager.take_damage(1)
