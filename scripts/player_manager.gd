extends Node2D

var icon = preload("res://icon.svg")

@onready var resources_text = $"../CanvasLayer/Overlay/ResourceText"
@onready var inventory_list = $"../CanvasLayer/CanvasGroup/InventoryList"

var resources = 0
var items: Array = []

# 25-11-30: Handles collecting a resource
func collect_resource(amount: int):
	resources += amount
	resources_text.text = "Resources: " + str(resources)

# 25-11-30: Handles spending resources
func spend_resource(amount: int):
	resources -= amount
	resources_text.text = "Resources: " + str(resources)

# 25-11-30: Handles adding items to the inventory
func add_item_to_inventory(item: String):
	items.append(item)
	inventory_list.add_item(item, icon, true)
