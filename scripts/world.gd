extends Node2D

# References to scenes in files
var tile_scene = preload("res://scenes/tile.tscn")

# References to scenes in game
@onready var player_manager = $"../PlayerManager"

# Adjustable parameters
@export var size: Vector2 = Vector2(1, 1)
@export var tile_size: Vector2 = Vector2(64, 64)
@export var grid_offset: Vector2 = Vector2(0, 0)

# 2D Array to hold tiles
var tiles: Array = []
var tiles_captured = 0;
var tiles_to_capture = size.x * size.y

func _ready() -> void:
	create_tiles()

# 25-10-29: Creates the tiles and places them in the world
func create_tiles() -> void:
	for x in range(size.x):
		tiles.append([])
		for y in range(size.y):
			var tile = tile_scene.instantiate();
			tile.position = Vector2(x * tile_size.x + 10 + grid_offset.x,
			y * tile_size.y + 10 + grid_offset.y)
			tile.tile_position = Vector2(x, y)
			var health = randi_range(5, 20)
			tile.max_health = health
			tile.health = health
			add_child(tile)
			tiles[x].append(tile)
	
	# Populate the neighbor array in the tile
	for x in tiles.size():
		for y in tiles[x].size():
			tiles[x][y].set_neighbors()
	
	tiles_to_capture = size.x * size.y
	
	spawn_corrupted_tiles(3)

func spawn_corrupted_tiles(amount: int):
	for tile in amount:
		# 25-11-3: Spawn a corrupted tile in the world
		var random_tile_x = randi_range(0, tiles.size() - 1)
		var random_tile_y = randi_range(0, tiles[random_tile_x].size() - 1)
		tiles[random_tile_x][random_tile_y].capture("corruption")
		# tiles[random_tile_x][random_tile_y].tile_owner = "corruption"
		# tiles[random_tile_x][random_tile_y].square.color = Color.WEB_PURPLE

# 25-10-29: Gets the neighbors to a specific cordinate in the world grid
func get_neighbors(x: int, y: int) -> Array:
	var neighbors = []
	for dx in [-1, 0, 1]:
		for dy in [-1, 0, 1]:
			if dx == 0 and dy == 0:
				continue # Skip the tile itself
			var nx = x + dx
			var ny = y + dy
			if nx >= 0 and nx < size.x and ny >= 0 and ny < size.y:
				neighbors.append(tiles[nx][ny])
	return neighbors

# 25-11-12: Send resource collection information to the appropriate manager
func collect_resource(quantity: float, collector: String):
	match collector:
		"player":
			player_manager.collect_resource(1)
