extends KinematicBody2D

#var final_pos = null

var lava = null
#var pos_buff = null
onready var Lava = load("res://GameScns/BossScns/ZhuRongSkill/lavaPond.tscn")


func _ready():
	pass

func being_cast(position):
#	var player = $"../../Player"
	var player = get_tree().current_scene.get_node("Player")
#	var Lava = load("res://GameScns/BossScns/lavaPond.tscn")
	lava = Lava.instance()
	var world = get_tree().current_scene
	world.add_child(lava)
#	pos_buff = Vector2(position.x, 0)
	lava.global_position = position

#	lava.target(position, pos_buff)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if(final_pos != null):
#		if(spike_timer < 10):
#			spike_timer = spike_timer + 1
#		elif(spike_num < 1):
#			var Skill = load("res://GameScns/BossScns/lavaPond.tscn")
#			var spike = Skill.instance()
#			var world = get_tree().current_scene
#			spike.global_position = start_pos + (spike_num + 2) * inc
#			spike.set_rotation(inc.angle())
#			world.add_child(spike)
#			spike_num = spike_num + 1
#			spike_timer = 0
#		else:
#			final_pos = null
