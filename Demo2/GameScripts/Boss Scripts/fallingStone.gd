extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var final_pos = null
var pos_buff = null
var stone = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		

func being_cast(position):
	var player = $"../../Player"
	var stoneSkill = load("res://GameScns/BossScns/stoneIdle.tscn")
	stone = stoneSkill.instance()
	var world = get_tree().current_scene
	world.add_child(stone)
	pos_buff = Vector2(position.x, 0)
	stone.global_position = pos_buff
	final_pos = position
	stone.target(position, pos_buff)

