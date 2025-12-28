extends CanvasGroup

var shop_item = preload("res://scenes/shop_item.tscn")

@onready var items = $Items

var shop_open = false

# 25-11-30: A function to manage opening the shop
func open_shop():
	shop_open = true
	for child in get_children():
		child.visible = true

# 25-11-20: A function to manage closing the shop
func close_shop():
	shop_open = false
	for child in get_children():
		child.visible = false

# 25-11-20: A function to toggle opening and closing the shop
func _on_shop_button_pressed() -> void:
	if shop_open:
		close_shop()
	else:
		open_shop()
