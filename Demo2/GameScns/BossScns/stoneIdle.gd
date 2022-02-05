extends KinematicBody2D

onready var animatedSprite = $AnimatedSprite
onready var animationPlayer = $AnimationPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var final_pos = null
var pos_buff = null
var speed = 400
var shadow = null
var shadow_freed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func target(pos, p_buff):
	final_pos = pos
	pos_buff = p_buff
	var Shadow = load("res://GameScns/BossScns/shadow.tscn")
	shadow = Shadow.instance()
	var world = get_tree().current_scene
	world.add_child(shadow)
	shadow.global_position = pos
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	if((final_pos != null) && (pos_buff != null)):
		if(abs(pos_buff.y - final_pos.y) > speed * delta):
			move_and_slide(Vector2(0,speed))
			animationPlayer.play("Idle")
			pos_buff.y = pos_buff.y + speed * delta
		else:
			animationPlayer.play("break")
		if(abs(pos_buff.y - final_pos.y) < 5 * speed * delta && !shadow_freed):
			shadow.queue_free()
			shadow_freed = true

func break_animation_finished():
	queue_free()
