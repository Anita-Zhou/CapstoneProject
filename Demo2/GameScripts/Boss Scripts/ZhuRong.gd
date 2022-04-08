extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 40
var direction2hero = Vector2(0, 0)
var horizontal_dirc2hero = Vector2(0, 0)
var temp_direction = Vector2(0, 0)
var distance2hero = float("inf")
var horizontal_dist2hero = float("inf")

var anim_sprite = null
var player = null
var second_phase = false
var stop_timer = 0
var fireball_timer = 0
var lava_timer = 0
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
var rng = RandomNumberGenerator.new()

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
onready var fireBall = get_node("FireBall")
onready var lavaPond = get_node("LavaPond")

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_sprite = get_node("AnimatedSprite")
	player = get_parent().get_node("Player")
	# Can only be set once by this, indicating the center of the screen
	#  where all casting os spells happneing 
	mid_scrn = self.global_position
	player_pos = player.global_position
	

func _physics_process(delta):
	# If player is not dead, calculate distance and direction between boss and hero.
	if(is_instance_valid(player)):
		direction2hero = player.position - self.position
		distance2hero = self.position.distance_to(player.position)
		horizontal_dist2hero = abs(self.position.x - player.position.x)
	direction2hero = direction2hero.normalized()
	
	# Decide horizontal moving direction
	if(direction2hero.x > 0) :
		horizontal_dirc2hero = Vector2(1, 0)
	else:
		horizontal_dirc2hero = Vector2(-1, 0)
	
	# Decide when to release fireball. 
	if fireball_timer >0:
		fireball_timer -= 1
	if horizontal_dist2hero < 300 and fireball_timer == 0:
		state = MOVE_STAFF
		fireBall.being_cast(direction2hero)
		fireball_timer = 300
		
		
	if(second_phase):
		if(lava_timer < 60):
			lava_timer = lava_timer + 1
		else:
			var lava_pos = Vector2(rng.randi_range(0,screenSize.x), rng.randi_range(240,screenSize.y))
			lavaPond.being_cast(lava_pos)
			lava_timer = 0

	# Decide states
	if horizontal_dist2hero > 40:
		state = MOVE
	
	var motion = direction2hero * speed
	animationTree.set("parameters/Idle/blend_position", direction2hero)
	animationTree.set("parameters/Move/blend_position", direction2hero)
	animationTree.set("parameters/MeleeAttack/blend_position", direction2hero)
	
	match state:
		IDLE:
			motion = horizontal_dirc2hero * 0
#			print("horizontal_dirc2hero:", horizontal_dirc2hero)
			animationState.travel("Idle")
		MOVE:
			motion = horizontal_dirc2hero * 20
			animationState.travel("Move")
		MOVE_STAFF:
			motion = horizontal_dirc2hero * 0
			animationState.travel("MoveStaff")
				
	
	move_and_slide(motion)
	move_and_collide(motion * delta)
			
		
		
		
func get_stats():
	return self.stats

func get_direction2hero():
	return direction2hero
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


func fix_position(check):
	if(!check):
		stop_timer = 90
		if(state != IDLE):
			state = IDLE
	else:
		stop_timer = stop_timer - 90
		
func take_damage(area):
	stats.health -= 5
#	emit_signal("boss_damage")
	animationPlayer.play("Hurt")
	print("zhu rong health", stats.health)
