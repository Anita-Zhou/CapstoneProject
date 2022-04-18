extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_enemy_died():
	self.visible = true
	$AnimationPlayer.play("arrow")
