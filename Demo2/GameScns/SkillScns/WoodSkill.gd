extends Node2D

onready var animatedSprite = $AnimatedSprite
onready var growPlayer = $GrowPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	growPlayer.play("Animate")

func being_cast():
	growPlayer.play("Animate")


func _on_animation_finished():
	queue_free()
