extends TileMapLayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		var mouse_pos =  get_global_mouse_position()
		var local_map_pos = local_to_map(mouse_pos)
		local_map_pos = Vector2i(local_map_pos.x, local_map_pos.y - 2)
		set_cell(local_map_pos, 0, Vector2i(13,0))
