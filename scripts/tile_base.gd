extends Node2D

@onready var square = $Polygon2D
@onready var label = $HealthLabel

@export var health = 3
var max_health = 3

var captured = false
var tile_owner = "neutral"

var neighbor_tiles: Array = []
var neighbors_captured = 0

var tile_position: Vector2

var damage_timer = 0.0
var damage_interval = 0.25
var decay_timer = 0.0
var decay_interval = 0.5

func _ready() -> void:
	label.text = str(health)
	label.visible = false

func _process(delta: float) -> void:
	# 25-11-3: Make corruption spread across the map randomly using attack_neighbor()
	if tile_owner == "corruption":
		damage_timer += delta
		if damage_timer >= damage_interval:
			attack_neighbor()
			damage_timer = 0.0
	
	# 25-11-3: Make player territory spread to neutral tiles
	#if tile_owner == "player":
		#decay_timer += delta
		#if decay_timer >= decay_interval:
			#attack_neighbor()
			#decay_timer = 0.0

func set_neighbors():
	neighbor_tiles = get_parent().get_neighbors(tile_position.x, tile_position.y)

# 25-10-29: Handles taking damage accordingly
func take_damage(damage: int, attacker: String):
	if health >= 0 and tile_owner != attacker: # and captured == false:
		health -= damage
		label.text = str(health)
		# square.color = Color.from_hsv(0 + (health * 0.1), 1, 1)
	
	#if health <= max_health: # and captured == true:
		#health -= damage
		#label.text = str(health)
		# square.color = Color.from_hsv(0 + (health * 0.1), 1, 1)
	
	if health <= 0: # and captured == false:
		capture(attacker)
	#elif health > 0 and captured == true:
		#health = 1
		#decapture("neutral")

# 25-10-29: Handles a tile being captured
# 25-10-29: Tiles are captured by an attacker doing damage to them
func capture(attacker: String):
	captured = true
	# label.visible = false
	health = max_health
	label.text = str(health)
	
	match attacker:
		"player":
			get_parent().tiles_captured += 1
			square.color = Color.NAVY_BLUE
			tile_owner = "player"
		"corruption":
			square.color = Color.WEB_PURPLE
			if tile_owner == "player":
				get_parent().tiles_captured -=1
			tile_owner = "corruption"
	

# 25-10-29: Handles a tile becoming uncaptured
# 25-10-29: Tiles become uncaptured due to decay
func decapture(attacker: String):
	captured = false
	if tile_owner == "player":
		get_parent().tiles_captured -= 1
	square.color = Color.WHITE
	label.text = str(health)
	label.visible = true

# 25-10-29: Gets the total ammount of neighbors that have been captured
func total_neighbors_captured() -> int:
	var total = 0
	for tile in neighbor_tiles:
		if tile.captured == true:
			total += 1
	return total
	
# 25-10-29: Gets the total ammount of neighbors that have been touched
func total_neighbors_touched() -> int:
	var total = 0
	for tile in neighbor_tiles:
		if tile.untouched == false:
			total += 1
	return total

# 25-10-29: Attack a neighbor tile that is not an ally
func attack_neighbor():
	var tile = neighbor_tiles[randi_range(0, neighbor_tiles.size() - 1)]
	if tile.tile_owner != tile_owner and tile.tile_owner != "player" and tile_owner == "corruption":
		tile.take_damage(1, tile_owner)
		
	if tile_owner == "player":
		tile.take_damage(1, tile_owner)

	## 25-10-29: Deals with tiles that have not been captured
	#damage_timer += delta
	#if damage_timer >= damage_interval:
		#if total_neighbors_captured() >= 2 and captured == false and untouched == true:
			#take_damage(total_neighbors_captured())
		#damage_timer = 0.0
	#
	## 25-10-29: Deals with captured tiles and potential decay
	#decay_timer += delta
	#if decay_timer >= decay_interval:
		#if health < max_health && total_neighbors_touched() >= 8:
			#var chance = randi_range(0, 100000)
			#if chance >= 99999 - total_neighbors_touched() * 250:
				#take_damage(-1)
				#if total_neighbors_touched() >= 1 and captured == true and untouched == false:
					#take_damage(-1)
		#if health < roundi(max_health / 2) and captured == false and untouched == false:
			#take_damage(-1)
			#var neighbor = randi_range(0, neighbor_tiles.size() - 1)
			#var chance = randi_range(0, 1000)
			#print(chance)
			#if chance >= 800:
				#neighbor_tiles[neighbor].take_damage(-1)
		#decay_timer = 0.0
