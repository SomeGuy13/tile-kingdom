extends Node2D

@onready var square = $Polygon2D
@onready var label = $HealthLabel

@export var health = 3
var max_health = 3

var captured = false
var tile_position: Vector2

var neighbor_tiles: Array = []
var neighbors_captured = 0

var damage_timer = 0.0
var damage_interval = 10

var decay_timer = 0.0
var decay_interval = 2

var untouched = true

func _ready() -> void:
	label.text = str(health)

func _process(delta: float) -> void:
	damage_timer += delta
	if damage_timer >= damage_interval:
		if total_neighbors_captured() >= 2 and captured == false and untouched == true:
			take_damage(total_neighbors_captured())
		damage_timer = 0.0
	
	decay_timer += delta
	if decay_timer >= decay_interval:
		if health < max_health && total_neighbors_touched() >= 8:
			var chance = randi_range(0, 100000)
			if chance >= 99999 - total_neighbors_touched() * 250:
				take_damage(-1)
				if total_neighbors_touched() >= 1 and captured == true and untouched == false:
					take_damage(-1)
		if health < roundi(max_health / 2) and captured == false and untouched == false:
			take_damage(-1)
			var neighbor = randi_range(0, neighbor_tiles.size() - 1)
			var chance = randi_range(0, 1000)
			print(chance)
			if chance >= 800:
				neighbor_tiles[neighbor].take_damage(-1)
		decay_timer = 0.0

func set_neighbors():
	neighbor_tiles = get_parent().get_neighbors(tile_position.x, tile_position.y)

func take_damage(damage: int):
	if health >= 0 and captured == false:
		health -= damage
		label.text = str(health)
		# square.color = Color.from_hsv(0 + (health * 0.1), 1, 1)
	
	if health <= max_health and captured == true:
		health -= damage
		label.text = str(health)
		# square.color = Color.from_hsv(0 + (health * 0.1), 1, 1)
	
	if health <= 0 and captured == false:
		capture()
	elif health > 0 and captured == true:
		health = 1
		decapture()

func capture():
	captured = true
	get_parent().tiles_captured += 1
	square.color = Color.NAVY_BLUE
	untouched = false
	label.visible = false

func decapture():
	captured = false
	get_parent().tiles_captured -= 1
	square.color = Color.ORANGE_RED
	label.text = str(health)
	label.visible = true

func total_neighbors_captured() -> int:
	var total = 0
	for tile in neighbor_tiles:
		if tile.captured == true:
			total += 1
	return total

func total_neighbors_touched() -> int:
	var total = 0
	for tile in neighbor_tiles:
		if tile.untouched == false:
			total += 1
	return total
