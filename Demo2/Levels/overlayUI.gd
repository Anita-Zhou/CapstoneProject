extends Control

const deathScn = preload("res://GameScns/UIScns/DeathUI/DeathScreen.tscn")
const pauseScn = preload("res://Levels/PauseScreen.tscn")

var overlay = null
var world = null

func _ready():
	PlayerStats.connect("no_health", self, "on_player_died")
	
func on_player_died():
	print("on player died")
	overlay = deathScn.instance()
	print("death scene instanced")
	world = get_tree().current_scene
	print("overlayUI got world:", world)
	world.add_child(overlay)
	print("world children after added overlay:", world.get_children())
	
func _input(ev):
	if Input.is_action_pressed("ui_cancel"):
		print("ui_cancel is clicked in overlayUI")
		overlay = pauseScn.instance()
		print("pause scene instanced")
		world = get_tree().current_scene
		print("overlayUI got world:", world)
		world.add_child(overlay)
		print("world children after added overlay:", world.get_children())
