extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var anim_player = $AnimationPlayer
	anim_player.play("EarthSkill")
	
func earth_finished():
	PlayerStats.dec_dmg = 1
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
