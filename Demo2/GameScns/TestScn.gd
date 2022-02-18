extends Control

onready var testBtn = get_node("TestButton")
onready var deathScn = get_node("DeathScreen")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	testBtn.connect("button_up", deathScn, "on_player_died")
	print("Test btn connected")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
