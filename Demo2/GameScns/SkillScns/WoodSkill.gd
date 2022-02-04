extends Node2D

onready var animatedSprite = $AnimatedSprite
onready var growPlayer = $GrowPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func being_cast():
	growPlayer.play("Animate")

func upgrade():
	growPlayer.play("partial")

func _on_animation_finished():
	queue_free()
	
