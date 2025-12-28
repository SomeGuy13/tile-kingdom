extends Button

@onready var inventory_list = $"../InventoryList"

var inventory_open = false

func open_inventory():
	inventory_list.visible = true
	inventory_open = true

func close_inventory():
	inventory_list.visible = false
	inventory_open = false

func _on_pressed() -> void:
	if inventory_open:
		close_inventory()
	elif !inventory_open:
		open_inventory()
