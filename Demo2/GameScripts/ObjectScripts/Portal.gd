extends Node2D

onready var animPlayer = $AnimationPlayer

func _ready():
	$Hurtbox/CollisionShape2D.disabled = true

func _on_enemy_died():
	animPlayer.play("active")
	self.visible = true
	$Hurtbox/CollisionShape2D.disabled = false
	
func set_self_visible():
	animPlayer.play("active")
	self.visible = true

func _on_Hurtbox_area_entered(area):
	print("Portal hurtbox entered")
	PlayerStats.reset()
	var SceneName = get_tree().current_scene.get_name()
	if(SceneName == "World1"):
		get_tree().change_scene("res://Levels/World2.tscn")
	elif (SceneName == "Tutorial"):
		get_tree().change_scene("res://Levels/World1.tscn")

	

