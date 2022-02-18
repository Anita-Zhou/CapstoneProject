extends Button

onready var deathscn = get_tree().get_root().get_node("DeathScreen")

func _ready():
	pass # Replace with function body.

func _get_configuration_warning()->String:
	return "cannot load World1 scene"


func _on_RestartBtn_button_up():
	print("=========== restart button pressed")
	PlayerStats.set_health(PlayerStats.max_health)
#	self.set_paused(false)
	print("get_tree().paused = false")
	#get_tree().reload_current_scene()
	#print("get_tree().reload_current_scene()")
	get_tree().change_scene("res://World1.tscn")
	print("get_tree().change_scene()")
