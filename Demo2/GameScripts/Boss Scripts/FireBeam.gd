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

func being_cast():
	var player = get_tree().current_scene.get_node("Player")
	var hfireBeam = load("res://GameScns/BossScns/ZhuRongSkill/hfireBeam.tscn")
	var vfireBeam = load("res://GameScns/BossScns/ZhuRongSkill/vfireBeam.tscn")
	var summon = load("res://GameScns/BossScns/ZhuRongSkill/fireBallSummoning.tscn")
	var world = get_tree().current_scene
	
#	if dir == 1:
		# start from the left
	var pos = Vector2(LEFT_X_BEAM, rng.randi_range(260,BOTTOM_Y_BEAM))
	var hbeam = hfireBeam.instance()
	var hsummon = summon.instance()
	hsummon.summonFireBeam()
	world.add_child(hsummon)
	hsummon.global_position = Vector2(screenSize.x - pos.x - 80, pos.y - 20)
	world.add_child(hbeam)
	hbeam.set_rotation(Vector2(0, 1).angle())
	hbeam.global_position = pos
	
#	elif dir == 3:
		# start from the right
	var pos1 = Vector2(RIGHT_X_BEAM, rng.randi_range(260, BOTTOM_Y_BEAM))
	var hbeam1 = hfireBeam.instance()
	var hsummon1 = summon.instance()
	hsummon1.summonFireBeam()
	world.add_child(hsummon)
	hsummon1.global_position = Vector2(screenSize.x - pos1.x + 80, pos1.y - 20)
	world.add_child(hbeam1)
	hbeam1.set_rotation(Vector2(0, -1).angle())
	hbeam1.global_position = pos1
		
#	elif dir == 2:
		# start from the bottom
	var pos2 = Vector2(rng.randi_range(LEFT_X_BEAM + 150, RIGHT_X_BEAM - 150), BOTTOM_Y_BEAM)
	var vbeam = vfireBeam.instance()
	world.add_child(vbeam)
	vbeam.global_position = pos2
		
	var pos3 = Vector2(rng.randi_range(LEFT_X_BEAM + 150, RIGHT_X_BEAM - 150), BOTTOM_Y_BEAM)
	var vbeam1 = vfireBeam.instance()
	world.add_child(vbeam1)
	vbeam1.global_position = pos3
	
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
