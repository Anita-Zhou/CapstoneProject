extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var timer = 0
#onready var player = get_node("player")
#onready var boss = get_node("boar")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func being_cast():
	var player = $"../Player"
	var boss = $"../Boar"
	var player_position = player.get_position()
	var boss_position = boss.get_position()
#	var direction = player.get_player2enemy_dir()
#	print("distance", abs((player_position - boss_position).length()))
#	self.position = position.move_toward(direction, -50)
	if timer < 100 and abs((player_position - boss_position).length()) < 200:
		self.position = boss_position
		boss.fix_position(true)
		timer += 1

	
func _process(delta):
	var player = $"../Player"
	var boss = $"../Boar"
	var player_position = player.get_position()
	var boss_position = boss.get_position()
#	var direction = player.get_player2enemy_dir()
#	print("distance", abs((player_position - boss_position).length()))
#	self.position = position.move_toward(direction, -50)

	if timer >= 100:
		self.position = Vector2.ZERO
		boss.fix_position(false)
