extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fireball_flying")

func target(pos):
	pass

func animation_finished():
	queue_free()

#func _on_Hurtbox_area_entered(area):
#	$AnimationPlayer.play("fireball_explosion")
