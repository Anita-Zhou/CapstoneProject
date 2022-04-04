extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 40
var direction2hero = Vector2(0, 0)
var temp_direction = Vector2(0, 0)
var distance2hero = float("inf")

var anim_sprite = null
var player = null
var second_phase = false
var stop_timer = 0

enum{
	IDLE,
	MOVE,
	FIRE_CHARGE,
	MOVE_SOWRD,
	MOVE_STAFF, 
	MELEE_ATK,
	STOP
}
var state = IDLE

onready var screenSize = get_viewport().get_visible_rect().size
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var stats = $Stats

#fixed point
onready var mid_scrn = Vector2.ZERO
onready var player_pos = Vector2.ZERO
onready var left_edge = Vector2.ZERO
onready var right_edge = Vector2.ZERO


#skills
onready var stoneSkill = get_node("fireBall")

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_sprite = get_node("AnimatedSprite")
	player = get_parent().get_node("Player")
	# Can only be set once by this, indicating the center of the screen
	#  where all casting os spells happneing 
	mid_scrn = self.global_position
	player_pos = player.global_position
	

func _physics_process(delta):
	if(is_instance_valid(player)):
		direction2hero = player.position - self.position
		distance2hero = self.position.distance_to(player.position)
	direction2hero = direction2hero.normalized()

	var motion = direction2hero * speed
	
	match state:
		IDLE:
			motion = direction2hero * 0
			animationPlayer.play("Idle")
			

func get_stats():
	return self.stats


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hurtbox_area_entered(area):
	print(area.get_parent().get_name() + " entered boss")
	if("WoodIdle" in area.get_parent().get_name()):
		fix_position(false)
	elif("WoodSkill" in area.get_parent().get_name()):
		fix_position(true)
	else:
		take_damage(area)
	if stats.health < stats.max_health/2:
		second_phase = true
#	pass # Replace with function body.

func fix_position(check):
	if(!check):
		stop_timer = 90
		if(state != IDLE):
			state = IDLE
	else:
		stop_timer = stop_timer - 90
		
func take_damage(area):
	stats.health -= 53
#	emit_signal("boss_damage")
	animationPlayer.play("Hurt")
