extends Node2D

@onready var resources_text = $"../CanvasLayer/Overlay/ResourceText"

var resources = 0

func collect_resource(amount: float):
	resources += amount
	resources_text.text = "Resources: " + str(resources)
