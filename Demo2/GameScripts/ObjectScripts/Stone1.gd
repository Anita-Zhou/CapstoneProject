extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var animatedSprite = $AnimatedSprite

func _ready():
	animatedSprite.play("Animate")

func _process(delta):
	pass


func _on_AnimatedSprite_animation_finished():
	queue_free()
