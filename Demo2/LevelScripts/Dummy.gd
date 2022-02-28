extends Node2D

onready var animationPlayer = $AnimationPlayer
onready var stats = $Stats

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Hurtbox_area_entered(area):
	take_damage(area)
	
func take_damage(area):
	stats.health -= 20
	#print("dummy hurt: ", stats.health)
	animationPlayer.play("Hurt")


func _on_Stats_no_health():
	queue_free()
