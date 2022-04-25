extends Node2D

var fireball = false
var firebeam = null
var fireballinstance = null
var firebeaminstance = null
var final_pos = null
var start_pos = null
var boss = null
var inc = null
onready var fireBall = get_node("FireBall")
onready var fireBeam = get_node("FireBeam")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func summonFireBall(boss_instance):
	$AnimationPlayer.play("summoning")
	boss = boss_instance
	fireball = true
	
func summonFireBeam():
	$AnimationPlayer.play("summoning")
	firebeam = true


func animation_finished():
	queue_free()
	if(fireball):
		var player = get_tree().current_scene.get_node("Player")
		if(is_instance_valid(player)):
			start_pos = boss.get_position() 
			final_pos = start_pos + 4000 * boss.get_direction2hero()
			var Skill = load("res://GameScns/BossScns/ZhuRongSkill/fireBall.tscn")
			inc = boss.get_direction2hero()
			fireballinstance = Skill.instance()
			fireballinstance.target(final_pos)
			var world = get_tree().current_scene
			fireballinstance.set_rotation(inc.angle())
			fireballinstance.set_global_position(start_pos)
			world.add_child(fireballinstance)
		else:
			final_pos = null


func _on_Hurtbox_area_entered(area):
	pass
	
