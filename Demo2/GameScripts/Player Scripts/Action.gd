extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 100
var move_direction = Vector2(0,0)
var face_right = true
var animation_in_process = false
var animation_not_interruptable = false;

onready var animationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	print ("Hello World")

func _process(delta):
	pass

func AnimationLoop():
	var face_direction = "E"
	var anim_mode = "Idle"
	
	
	pass
	# pass # Replace with function body.
func _physics_process(delta):
	
	# if(Input.get_action_strength("ui_right")):
	# 	print("pressed d")

	move_direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move_direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	move_direction = move_direction.normalized()
	#debug
	#print(move_direction)
	var motion = move_direction * speed
	move_and_slide(motion)
	move_and_collide(motion * delta)

func _input(ev):
	
	var player = get_node("player")
	var skill = get_node("WoodSkill")
	
	
	if Input.is_action_pressed("ui_right", false):
		face_right = true;
		animationPlayer.play("WalkRight")	
	elif Input.is_action_pressed("ui_left", false):
		face_right = false;
		animationPlayer.play("WalkRight")	
	elif Input.is_mouse_button_pressed(BUTTON_LEFT):
		animationPlayer.play("Attack")	
	elif Input.is_key_pressed(KEY_E):
		skill.being_cast()
	else:
		animationPlayer.play("Idle")	
		
	if face_right == true:
		player.set_flip_h(false)
	else:
		player.set_flip_h(true)

			#play attck animation

func get_player2enemy_dir():
	var enemy = $"../Boar"
	var dir_vec = enemy.get_position() - self.position
	dir_vec = dir_vec.normalized()
	return dir_vec
# func _process(delta):
# 	pass
# 	# _animationLoop()

# func _movementLoop(delta):
# 	move_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
# 	move_direction.y = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))) / float(2)
	
# 	var motion = move_direction.normalized() * speed
# 	move_and_slide(motion)

# func _animationLoop():
# 	pass

