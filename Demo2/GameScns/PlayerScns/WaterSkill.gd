extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func being_cast():
	var player = $"../../Player"
	var pos = player.get_position() 
	var WaterSkill = load("res://GameScns/SkillScns/WaterSkill.tscn")
	var waterSkill = WaterSkill.instance()
	var world = get_tree().current_scene
	world.add_child(waterSkill)
	waterSkill.global_position = pos
