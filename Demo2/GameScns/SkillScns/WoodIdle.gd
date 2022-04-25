extends Node2D

#onready var water = get_node("WaterSkill")
onready var animatedSprite = $AnimatedSprite
onready var animationPlayer = $woodAnimation
var animationFinished = false

func _ready():
	animationPlayer.play("SmallVine")
	
	
func _on_grow_finished():
	animationFinished = true
	var SceneName = get_tree().current_scene.get_name()
	if(SceneName == "World2"):
		print("burned woodidle")
		animationPlayer.play("Burned")
	
func _on_animation_finished():
	queue_free()
	
func _on_Hurtbox_area_entered(area):
	#area != boar and 
	#print(str(area.get_parent()))
	#if area == water:	# call wood skill
	print("wood idle cast")
	var Skill = load("res://GameScns/SkillScns/WoodSkill.tscn")
	var woodSkill = Skill.instance()
	var world = get_tree().current_scene
	world.add_child(woodSkill)
	woodSkill.global_position = global_position
	if(animationFinished):
		woodSkill.upgrade()
	else:
		woodSkill.being_cast()
	queue_free()
	
