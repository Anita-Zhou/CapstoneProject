extends KinematicBody2D

onready var screenSize = get_viewport().get_visible_rect().size
onready var animationPlayer = $AnimationPlayer
onready var stats = $Stats

var direction = Vector2(0, 0)
var temp_direction = Vector2(0, 0)
var rng = RandomNumberGenerator.new()
#var direction = Vector2(0, 0)
var distance2hero = Vector2(0, 0)
var speed = 15
var timer = 420
var move = false

onready var player = null

func _ready():
	print("=====dummy ready")
	rng.randomize()
	player = get_parent().get_node("Player")
	print("=====dummy got player")
	timer = rng.randf_range(180.0, 360.0)
	
func _physics_process(delta):
	if(move == true):
		speed = 20
	else:
		speed = 0
		
	var motion = direction * speed
	if(is_instance_valid(player)):
		direction = player.position - self.position
		distance2hero = self.position.distance_to(player.position)
	direction = direction.normalized()
	#print("current dummy direction:", direction)
	move_and_slide(motion)
	move_and_collide(motion * delta)
	
	if(timer > 0):
		timer -= 1
	else:
		move = !move
		timer = rng.randf_range(180.0, 360.0)
		

#func _physics_process(delta):
#	var motion = direction * speed
#
#		JUMP:
#			motion = direction * speed
#			animationState.travel("Jump")

func _on_Hurtbox_area_entered(area):
	take_damage(area)
	
func take_damage(area):
	stats.health -= 150
	#print("dummy hurt: ", stats.health)
	animationPlayer.play("Hurt")

func get_stats():
	return self.stats

func _on_Stats_no_health():
#	get_tree().change_scene("res://Levels/World1.tscn")
	queue_free()
