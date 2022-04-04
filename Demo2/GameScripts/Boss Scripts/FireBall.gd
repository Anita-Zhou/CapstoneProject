extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var final_pos = null
var start_pos = null
var inc = null
var spike_timer = 0
var spike_num = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func being_cast(direction):
#	var player = $"../../Player"
	var player = get_tree().current_scene.get_node("Player")
#	var player = $"../Player"
	if(is_instance_valid(player)):
		final_pos = player.get_position()
		var boss = $"../../ZhuRong"
		start_pos = boss.get_position()
		inc = (final_pos - start_pos)
		inc = inc.normalized() * 60
		spike_num = 0
	else:
		final_pos = null
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(final_pos != null):
		if(spike_timer < 10):
			spike_timer = spike_timer + 1
		elif(spike_num < 1):
			var Skill = load("res://GameScns/BossScns/fireBall.tscn")
			var spike = Skill.instance()
			var world = get_tree().current_scene
			spike.global_position = start_pos + (spike_num + 2) * inc
			spike.set_rotation(inc.angle())
			world.add_child(spike)
			
			print("ball position", spike.global_position)
			spike_num = spike_num + 1
			spike_timer = 0
		else:
			final_pos = null
