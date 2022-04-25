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

func _on_Hurtbox_area_entered(area):
	var SceneName = get_tree().current_scene.get_name()
	if(SceneName == "World2"):
		print("------- wood skill ", area.get_parent().get_name())
		growPlayer.play("burned")
	
