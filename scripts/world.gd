extends Node2D

# References to scenes
var tile_scene = preload("res://scenes/tile.tscn")

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
			var health = randi_range(3, 10)
			tile.max_health = health
			tile.health = health
			add_child(tile)
			tiles[x].append(tile)
	
	# Populate the neighbor array in the tile
	for x in tiles.size():
		for y in tiles[x].size():
			tiles[x][y].set_neighbors()
	
	tiles_to_capture = size.x * size.y

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
