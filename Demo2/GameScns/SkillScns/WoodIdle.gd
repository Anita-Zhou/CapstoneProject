extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



onready var water = get_node("WaterSkill")
func _on_Hurtbox_area_entered(area):
	#area != boar and 
	#print(str(area.get_parent()))
	#if area == water:	# call wood skill
	var WoodSkill = load("res://GameScns/SkillScns/WoodSkill.tscn")
	var woodSkill = WoodSkill.instance()
	var world = get_tree().current_scene
	world.add_child(woodSkill)
	woodSkill.global_position = global_position
	queue_free()
	
