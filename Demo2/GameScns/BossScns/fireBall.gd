extends Node2D

var speed = 750
var exploded = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fireball_flying")

func target(pos):
	pass

func animation_finished():
	queue_free()

func _physics_process(delta):
	if not exploded:
		position += transform.x * speed * delta
	else:
		$AnimationPlayer.play("fireball_explosion")
func _on_Hurtbox_area_entered(area):
	exploded = true
	
