extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func being_cast():
	var enemy = $"../../Boar"
	var pos = enemy.get_position() 
	var WoodSkill = load("res://GameScns/SkillScns/WoodSkill.tscn")
	var woodSkill = WoodSkill.instance()
	var world = get_tree().current_scene
	world.add_child(woodSkill)
	woodSkill.global_position = pos
	

