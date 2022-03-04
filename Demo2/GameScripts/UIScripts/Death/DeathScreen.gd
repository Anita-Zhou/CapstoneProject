extends Control

var paused := false setget set_paused
onready var scene_tree := get_tree()
onready var death_overlay: ColorRect = get_node("DeathOverlay")

func set_paused(value: bool) -> void:
	#scene_tree.paused = value
	#self.visible = value
	death_overlay.visible = value
	print("death set paused:", paused)

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.connect("no_health", self, "on_player_died")

func on_player_died():
	print("on player died")
	set_paused(true)

