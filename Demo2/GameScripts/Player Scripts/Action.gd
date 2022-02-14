extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

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
#var face_right = true
var animation_in_process = false
var animation_not_interruptable = false
var wood_cd = 0
var water_cd = 0
var stats = PlayerStats

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $HitboxPivot/SwordHitbox
onready var hurtbox = $Hurtbox

onready var woodcdlbl = $"../WoodcdLbl"
onready var watercdlbl = $"../WatercdLbl"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_z_index(0)
	print ("Hello World")
	stats.connect("no_health", self, "queue_free")
	animationTree.active = true

func _process(delta):
	if(wood_cd > 0):
		wood_cd -= 1
		if(wood_cd%60 == 0):
			woodcdlbl.text = "Wood Cooldown: " + str(wood_cd/60)
		#print("wood_cd:", wood_cd)
	if(water_cd > 0):
		water_cd -= 1
		if(water_cd%60 == 0):
			watercdlbl.text = "Water Cooldown: " + str(water_cd/60)
		#print("water_cd:", water_cd)

func AnimationLoop():
	var face_direction = "E"
	var anim_mode = "Idle"
	pass
	
	# pass # Replace with function body.
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		DASH:
			dash_state(delta)
		ATTACK:
			attack_state(delta)
	
	# if(Input.get_action_strength("ui_right")):
	# 	print("pressed d")
func move_state(delta):
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	#Set blend_position for Animations
	if (input_vector != Vector2.ZERO):
		swordHitbox.knockback_vector = input_vector
		print("input vector", input_vector)
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

func _input(ev):
	
	var player = get_node("player")
	var woodskill = get_node("WoodSkill")
	var waterskill = get_node("WaterSkill")
	
	
#	if Input.is_action_pressed("ui_right", false):
#		face_right = true;
#		animationPlayer.play("WalkRight")	
#	elif Input.is_action_pressed("ui_left", false):
#		face_right = false;
#		animationPlayer.play("WalkRight")	
	#if Input.is_mouse_button_pressed(BUTTON_LEFT):
		#animationPlayer.play("Attack")	
	if Input.is_key_pressed(KEY_U):
		if(wood_cd == 0):
			woodskill.being_cast()
			wood_cd = 180
			woodcdlbl.text = "Wood Cooldown: " + str(180/60)
		
	if Input.is_key_pressed(KEY_I):
		if(water_cd == 0):
			waterskill.being_cast()
			water_cd = 300
			watercdlbl.text = "Water Cooldown: " + str(300/60)
	#else:
	#	animationPlayer.play("Idle")	
		
	#if face_right == true:
	#	player.set_flip_h(false)
	#else:
	#	player.set_flip_h(true)

			#play attck animation

func get_player2enemy_dir():
	var enemy = $"../Boar"
	var dir_vec = enemy.get_position() - self.position
	dir_vec = dir_vec.normalized()
	return dir_vec


# func _movementLoop(delta):
# 	move_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
# 	move_direction.y = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))) / float(2)
	
# 	var motion = move_direction.normalized() * speed
# 	move_and_slide(motion)

# func _animationLoop():
# 	pass

func take_damage(area):
	stats.health -= 10
	print("what hurt player:", area.get_name())
	animationPlayer.play("Hurt")

func _on_Hurtbox_area_entered(area):
	if(state != DASH):
		self.take_damage(area)
#	hurtbox.create_hit_effect()
	print("player health: ", stats.health)
