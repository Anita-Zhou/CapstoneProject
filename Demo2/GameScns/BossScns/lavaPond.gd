extends Node2D

onready var animatedSprite = $AnimatedSprite
onready var animationPlayer = $AnimationPlayer

var final_pos = null
#var pos_buff = null
#var speed = 400
var shadow = null
var shadow_freed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer.play("lavaPond")

func target(pos):
	final_pos = pos
#	pos_buff = p_buff
##	var Shadow = load("res://GameScns/BossScns/shadow.tscn")
##	shadow = Shadow.instance()
#	var world = get_tree().current_scene
##	world.add_child(shadow)
##	shadow.global_position = pos

func _process(delta):
	pass
#	if position != null:
#		animationPlayer.play("lavaPond")

#		if(abs(pos_buff.y - final_pos.y) > speed * delta):
#			pos_buff.y = pos_buff.y + speed * delta
#
#		if(abs(pos_buff.y - final_pos.y) < 5 * speed * delta && !shadow_freed):
#			shadow.queue_free()
#			shadow_freed = true

func animation_finished():
	animationPlayer.play("lava_persist")
	
func _on_Hurtbox_area_entered(area):
	if area.get_parent().get_name() == "WaterSkill":
		queue_free()
	

