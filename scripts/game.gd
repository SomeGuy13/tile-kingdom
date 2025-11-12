extends Node2D

@onready var win_text = $CanvasLayer/CanvasGroup/WinScreen/WinText
@onready var loose_text = $CanvasLayer/CanvasGroup/Node/LooseText
@onready var world = $world

var has_won = false
var has_lost = false

func _process(delta: float) -> void:
	# 25-10-29: Display win and loose text depending on the conditions
	if has_won == true:
		win_text.visible = true
	
	if has_lost == true:
		loose_text.visible = true
	
	if world.tiles_captured == world.tiles_to_capture:
		has_won = true
