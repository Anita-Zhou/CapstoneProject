extends StaticBody2D

var animationPlayer = null
# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer = get_node("StoneAnimation")
	

func wood_interaction():
	animationPlayer.play("Break")	
