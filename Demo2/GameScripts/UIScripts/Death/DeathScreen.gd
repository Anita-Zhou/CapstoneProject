extends CanvasLayer

#var paused := false setget set_paused
#onready var scene_tree := get_tree()
onready var death_overlay: ColorRect = $DeathOverlay
export var curr_scene_path := "" 

#func set_paused(value: bool) -> void:
#	#scene_tree.paused = value
#	#self.visible = value
#	death_overlay.visible = value
#	print("death set paused:", paused)

# Called when the node enters the scene tree for the first time.
func _ready():
#	PlayerStats.connect("no_health", self, "on_player_died")
	var path = self.get_parent().get_name()
	print("Death scene parent: ", path)

#func on_player_died():
#	print("on player died")
#	set_paused(true)
	
func _on_MainTxtBtn_button_up():
	print("===== death pressed main menu button")
	PlayerStats.reset()
	get_tree().change_scene("res://Levels/SplashScreen.tscn")

func _on_ReTxtBtn_button_up():
	print("=========== death restart button pressed")
#	print(self.get_parent().get_name() == "World2")
	PlayerStats.reset()
#	self.set_paused(false)
	print("get_tree().paused = false")
	if self.get_parent().get_name() == "World1":
		get_tree().change_scene("res://Levels/World1.tscn")
	elif self.get_parent().get_name() == "World2":
		get_tree().change_scene("res://Levels/World2.tscn")
	print("get_tree().change_scene()")
