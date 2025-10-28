extends Node2D

@onready var win_text = $CanvasGroup/WinScreen/WinText
@onready var loose_text = $CanvasGroup/Node/LooseText
@onready var world = $world

var has_won = false
var has_lost = false

func _process(delta: float) -> void:
	if has_won == true:
		win_text.visible = true
	
	if has_lost == true:
		loose_text.visible = true
	
	if world.tiles_captured == world.tiles_to_capture:
		has_won = true
