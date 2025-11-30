extends Node2D

@onready var purchase_button = $PurchaseButton
@onready var item_label = $ItemLabel
@onready var item_description_node = $ItemDescription

@export var item_name = "Default Item"
@export var item_price = 5
@export var item_description = "Just a generic item. Means nothing. Waste of money."

var player_manager

func _ready() -> void:
	player_manager = get_node("../../../PlayerManager")
	
	setup_item("Default Item",
	5, "Just a generic item. Means nothing. Waste of money.")

func setup_item(name: String, price: int, description: String):
	item_name = name
	item_price = price
	item_description = description
	
	purchase_button.text = str(item_price) + " Resources"
	item_label.text = item_name
	item_description_node.text = item_description 

func _on_purchase_button_pressed() -> void:
	if player_manager.resources >= item_price:
		player_manager.spend_resource(item_price)
		player_manager.add_item_to_inventory(item_name)
		print(player_manager.items)
