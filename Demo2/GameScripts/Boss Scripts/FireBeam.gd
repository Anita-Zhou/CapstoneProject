extends KinematicBody2D

onready var screenSize = get_parent().get_viewport().get_visible_rect().size

onready var LEFT_X_BEAM = 20
onready var RIGHT_X_BEAM = screenSize.x - 20
onready var BOTTOM_Y_BEAM = screenSize.y - 20
#var RIGHT_X_BEAM = screenSize.x - 20
#var BOTTOM_Y_BEAM = screenSize.y - 20
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	print("======screen size", screenSize)
	pass # Replace with function body.

func being_cast(dir):
	var player = get_tree().current_scene.get_node("Player")
	var fireBeam = load("res://GameScns/BossScns/fireBeam.tscn")
	var world = get_tree().current_scene
	
	if dir == 1:
		# start from the left
		var pos = Vector2(LEFT_X_BEAM, rng.randi_range(260,BOTTOM_Y_BEAM))
		var hbeam = fireBeam.instance()
		world.add_child(hbeam)
		hbeam.set_rotation(Vector2(0, 1).angle())
		hbeam.global_position = pos
	
	elif dir == 3:
		# start from the right
		var pos = Vector2(RIGHT_X_BEAM, rng.randi_range(260, BOTTOM_Y_BEAM))
		var hbeam = fireBeam.instance()
		world.add_child(hbeam)
		hbeam.set_rotation(Vector2(0, -1).angle())
		hbeam.global_position = pos
		
	elif dir == 2:
		# start from the bottom
		var pos = Vector2(rng.randi_range(LEFT_X_BEAM, RIGHT_X_BEAM), BOTTOM_Y_BEAM)
		var vbeam = fireBeam.instance()
		world.add_child(vbeam)
		vbeam.global_position = pos
		

#	var player = get_tree().current_scene.get_node("Player")
#	var FireSkill = load("res://GameScns/BossScns/lavaPond.tscn")
#	lava = FireSkill.instance()
#	var world = get_tree().current_scene
#	world.add_child(lava)
##	pos_buff = Vector2(position.x, 0)
#	lava.global_position = position
## Called every frame. 'delta' is the elapsed time since the previous frame.
##func _process(delta):
##	pass
