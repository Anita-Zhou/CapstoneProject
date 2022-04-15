extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func being_cast(enemy):
	
	if(is_instance_valid(enemy)):
		print("cast wood skill")
		var pos = enemy.get_position() 
		var Skill = load("res://GameScns/SkillScns/WoodIdle.tscn")
		var woodSkill = Skill.instance()
		var world = get_tree().current_scene
		woodSkill.global_position = pos
		world.add_child(woodSkill)
	

