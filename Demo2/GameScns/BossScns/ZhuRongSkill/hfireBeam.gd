extends Node2D

#onready var screenSize = get_viewport().get_visible_rect().size
var horizontal = false

func _ready():
	$AnimationPlayer.play("firebeam")

func summon_animation_finished():
	$AnimationPlayer.stop()
	$AnimationPlayer.play("firebeam")

func firebeam_animation_finished():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
