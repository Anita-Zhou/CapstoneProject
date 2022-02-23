extends Control

var paused := false setget set_paused
onready var scene_tree := get_tree()
onready var death_overlay: ColorRect = get_node("DeathOverlay")

func set_paused(value: bool) -> void:
	#scene_tree.paused = value
	#self.visible = value
	death_overlay.visible = value
	print("set paused")

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.connect("no_health", self, "on_player_died")

func on_player_died():
	print("on player died")
	set_paused(true)


#func _on_MainBtn_button_up():
#	print("=====pressed main menu button")
#	get_tree().change_scene("res://GameScns/UIScns/SplashScreen.tscn")



#func _on_RestartBtn_button_up():
#	print("=========== restart button pressed")
#	PlayerStats.set_health(PlayerStats.max_health)
#	self.set_paused(false)
#	print("get_tree().paused = false")
#	#get_tree().reload_current_scene()
#	#print("get_tree().reload_current_scene()")
#	get_tree().change_scene("res://World1.tscn")
#	print("get_tree().change_scene()")
