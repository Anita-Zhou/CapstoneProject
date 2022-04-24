extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player = $"../../Player"
onready var pos = player.get_position() 

export var isCast := false setget _set_isCast, _get_isCast

func _set_isCast(value):
	isCast = value
	
func _get_isCast():
	return isCast


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pos = player.get_position() 
	
func being_cast():
#	var player = $"../../Player"
#	var pos = player.get_position() 
	var EarthSkill = load("res://GameScns/SkillScns/EarthSkill.tscn")
	var earthSkill = EarthSkill.instance()
	PlayerStats.dec_dmg = 0.5
	var player = get_tree().current_scene.get_node("Player")
	player.add_child(earthSkill)
#	earthSkill.global_position = pos
