extends Node2D

onready var animPlayer = $AnimationPlayer

func _on_enemy_died():
	animPlayer.play("active")
	self.visible = true
	
	
func _on_Hurtbox_area_entered(area):
	print("Portal hurtbox entered")
	get_tree().change_scene("res://Levels/World2.tscn")


