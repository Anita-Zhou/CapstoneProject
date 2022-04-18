extends KinematicBody2D

var pos = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func being_cast(enemy):
	
	if(is_instance_valid(enemy)):
		print("cast wood skill")
		# TODO: identify enemy kind
		pos = enemy.get_position() 
		if(enemy.get_name() == "ZhuRong"):
			print("Now enemy is Zhurong, increase wood skill position")
			pos += Vector2(0, -120)
		var Skill = load("res://GameScns/SkillScns/WoodIdle.tscn")
		var woodSkill = Skill.instance()
		var world = get_tree().current_scene
		woodSkill.global_position = pos
		world.add_child(woodSkill)
	

