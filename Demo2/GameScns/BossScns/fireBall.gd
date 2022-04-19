extends Node2D

var speed = 750
var exploded = false
var final_position = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fireball_flying")

func target(pos):
	final_position = pos

func animation_finished():
	queue_free()

func _physics_process(delta):
	
	if not exploded:
		position += transform.x * speed * delta
	else:
#		print("play explosion animation")
	
		$AnimationPlayer.play("fireball_explosion")
	

	if self.position.y > final_position.y:
#			print("======spike position", self.position)
#			print("======spike final position", final_position)
			queue_free()

func _on_Hurtbox_area_entered(area):
	exploded = true
