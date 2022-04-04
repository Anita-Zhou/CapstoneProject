extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var anim_player = $AnimationPlayer
	anim_player.play("fireball_flying")

func target(pos):
	pass

func animation_finished():
	queue_free()
