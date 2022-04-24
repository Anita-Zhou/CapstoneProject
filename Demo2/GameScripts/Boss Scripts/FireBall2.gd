extends Node

var final_pos = null
var start_pos = null
var inc = null
var spike_num = 0
var ball = null

func _ready():
	pass

func being_cast(direction):
	var boss = $"../../ZhuRong"
	var Skill = load("res://GameScns/BossScns/fireBallSummoning.tscn")
	ball = Skill.instance()
	ball.summonFireBall(boss)
	var world = get_tree().current_scene
	ball.set_global_position(boss.get_position())
	world.add_child(ball)

func _process(delta):
	pass
