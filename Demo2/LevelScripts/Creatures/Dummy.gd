extends KinematicBody2D

onready var screenSize = get_viewport().get_visible_rect().size
onready var stats = $Stats
onready var player = null

var rng = RandomNumberGenerator.new()
var direction = Vector2(0, 0)
var temp_direction = Vector2(0, 0)
var distance2hero = Vector2(0, 0)

var move = false
var speed = 15
var timer = 420
var stop_timer = 0

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

enum{
	STOP,
	JUMP
}
var state = STOP

func _ready():
	print("=====dummy ready")
	rng.randomize()
	player = get_parent().get_node("Player")
	print("=====dummy got player")
	timer = rng.randf_range(180.0, 360.0)
	
func _physics_process(delta):
	if(is_instance_valid(player)):
		direction = player.position - self.position
		distance2hero = self.position.distance_to(player.position)
	direction = direction.normalized()
	
	var motion = direction * speed
	move_and_slide(motion)
	move_and_collide(motion * delta)
	
	if(timer > 0):
		timer -= 1
	else:
		move = !move
		timer = rng.randf_range(180.0, 360.0)
	
	match state:
		STOP:
			motion = direction * 0
			if stop_timer < 180:
				animationState.travel("Idle")
				stop_timer = stop_timer + 1
		
			

func _on_Hurtbox_area_entered(area):
	print(area.get_parent().get_name() + " entered boss")
	if("WoodIdle" in area.get_parent().get_name()):
		fix_position(false)
	elif("WoodSkill" in area.get_parent().get_name()):
		fix_position(true)
	else:
		take_damage(area)
		
#func _on_Hurtbox_area_entered(area):
#	take_damage(area)
	
func take_damage(area):
	stats.health -= 150
	#print("dummy hurt: ", stats.health)
	animationPlayer.play("Hurt")

func fix_position(check):
	if(!check):
		stop_timer = 90
		if(state != CHARGE):
			state = STOP
	else:
		stop_timer = stop_timer - 90

func get_stats():
	return self.stats

func _on_Stats_no_health():
#	get_tree().change_scene("res://Levels/World1.tscn")
	queue_free()
