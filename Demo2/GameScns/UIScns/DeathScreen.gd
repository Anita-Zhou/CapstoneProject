extends Control

var paused := false setget set_paused
onready var scene_tree := get_tree()
onready var death_overlay: ColorRect = get_node("DeathOverlay")

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	death_overlay.visible = value

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.connect("no_health", self, "on_player_died")

func on_player_died():
	self.paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
