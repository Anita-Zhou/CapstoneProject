extends KinematicBody2D


# Useless constants
const MAX_SPEED = 80
const ACCELERATION = 500
const FRICTION = 500

enum {
	MOVE,
	DASH,
	ATTACK
}
var state = MOVE

var speed = 100
var velocity = Vector2(0,0)
var animation_in_process = false
var animation_not_interruptable = false
var stats = PlayerStats
var enemy
var invincibleCounter = 0

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtbox

signal cast_wood
signal cast_water
signal cast_earth

# Called when the node enters the scene tree for the first time.
func _ready():
	print ("Hello World")
	# Connect signals
	stats.connect("no_health", self, "queue_free")
	self.connect("cast_wood", stats, "_on_wood_cast")
	self.connect("cast_water", stats, "_on_water_cast")
	self.connect("cast_earth", stats, "_on_earth_cast")
	
	animationTree.active = true
	var SceneName = get_tree().current_scene.get_name()
	if(SceneName == "World1"):
		enemy = $"../Boar"
	elif (SceneName == "Tutorial"):
		enemy = $"../Dummy"

func AnimationLoop():
	var face_direction = "E"
	var anim_mode = "Idle"
	pass
	
	# pass # Replace with function body.
func _physics_process(delta):
	if (invincibleCounter > 0):
		invincibleCounter -= 1
	match state:
		MOVE:
			move_state(delta)
		DASH:
			dash_state(delta)
		ATTACK:
			attack_state(delta)
	
####################################################
####################################################
##
# States functions
#
func move_state(delta):
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	#Set blend_position for Animations
	if (input_vector != Vector2.ZERO):
		swordHitbox.knockback_vector = input_vector
		
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Dash/blend_position", input_vector)
		animationState.travel("Walk")
	else:
		animationState.travel("Idle")
	#debug
	#print(move_direction)
	
	velocity = input_vector * speed
	move_and_slide(velocity)
	move_and_collide(velocity * delta)
	
	# Immediately change stop walking and commit to attack
	if (Input.is_action_just_pressed("ui_attack")):
		state = ATTACK
	if (Input.is_action_just_pressed("ui_dash")):
		state = DASH

func attack_state(delta):
	animationState.travel("Attack")
	
func dash_state(delta):
	animationState.travel("Dash")
	move_and_slide(velocity * 3)
	move_and_collide(velocity * 3  *delta)
	
func attack_animation_finished():
	state = MOVE

####################################################
####################################################

func _input(ev):
#	var player = get_node("player")
	var woodskill = get_node("WoodSkill")
	var waterskill = get_node("WaterSkill")
	var earthskill = get_node("EarthSkill")
	
	if Input.is_key_pressed(KEY_K):
		if(stats.wood_cd == 0):
			woodskill.being_cast(enemy)
			emit_signal("cast_wood")
		
	if Input.is_key_pressed(KEY_L):
		if(stats.water_cd == 0):
			waterskill.being_cast()
			emit_signal("cast_water")
			
	if Input.is_key_pressed(KEY_I):
		if(stats.earth_cd == 0):
			earthskill.being_cast()
			emit_signal("cast_earth")

####################################################
####################################################

func get_player2enemy_dir():
	var enemy = $"../Boar"
	var dir_vec = enemy.get_position() - self.position
	dir_vec = dir_vec.normalized()
	return dir_vec

func take_damage(area):
	invincibleCounter = 30
	stats.health -= 10
	print("what hurt player:", area.get_name())
	animationPlayer.play("Hurt")

func _on_Hurtbox_area_entered(area):
	if(state != DASH && invincibleCounter == 0):
		self.take_damage(area)
#	hurtbox.create_hit_effect()
	print("player health: ", stats.health)
