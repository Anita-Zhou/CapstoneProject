extends Node2D
#
#onready var screenSize = get_viewport().get_visible_rect().size
onready var animationPlayer = $AnimationPlayer
#onready var animationTree = $AnimationTree
#onready var animationState = animationTree.get("parameters/playback")
onready var stats = $Stats
#
#var direction = Vector2(0, 0)
#var temp_direction = Vector2(0, 0)
#var speed = 40
#
#enum{
#	JUMP
#}
#var state = JUMP


#func _physics_process(delta):
#	var motion = direction * speed
#	match state:
#		JUMP:
#			motion = direction * speed
#			animationState.travel("Jump")
#
func _on_Hurtbox_area_entered(area):
	take_damage(area)
	
func take_damage(area):
	stats.health -= 20
	#print("dummy hurt: ", stats.health)
	animationPlayer.play("Hurt")


func _on_Stats_no_health():
	get_tree().change_scene("res://Levels/World1.tscn")
