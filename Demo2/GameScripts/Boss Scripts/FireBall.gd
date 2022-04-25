extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var final_pos = null
var start_pos = null
var inc = null
var spike_num = 0
var spike = null

func _ready():
	pass

func being_cast(direction):
	var boss = $"../../ZhuRong"
	var Skill = load("res://GameScns/BossScns/ZhuRongSkill/fireBallSummoning.tscn")
	spike = Skill.instance()
	spike.summonFireBall(boss)
	var world = get_tree().current_scene
	spike.set_global_position(boss.get_position())
	world.add_child(spike)
#	var player = get_tree().current_scene.get_node("Player")
#	var boss = $"../../ZhuRong"
#	if(is_instance_valid(player)):
#		start_pos = boss.get_position() 
#		final_pos = start_pos + 4000 * boss.get_direction2hero()
#		inc = boss.get_direction2hero()
#	#	inc = (final_pos - start_pos)
#	#	inc = inc.normalized() * 60
#		spike_num = 0
#		var Skill = load("res://GameScns/BossScns/fireBall.tscn")
#		spike = Skill.instance()
#		spike.target(final_pos)
#		var world = get_tree().current_scene
#		spike.set_rotation(inc.angle())
#		spike.set_global_position(start_pos)
#		world.add_child(spike)
#	else:
#		final_pos = null
		

func _process(delta):
	pass
#	if(final_pos != null and spike != null):
#		if spike.position.y > final_pos.y:
#			print("======spike position", spike.position)
#			print("======spike final position", final_pos)
#			spike.queue_free()
#			spike = null
#		print("ball position", spike.global_position)
