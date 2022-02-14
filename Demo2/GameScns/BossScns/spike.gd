extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var anim_player = $AnimationPlayer
	anim_player.play("spike_animation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func target(pos):
	pass

func spike_animation_finished():
	queue_free()
