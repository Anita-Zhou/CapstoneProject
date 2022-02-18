extends Button


func _ready():
	pass # Replace with function body.

func _get_configuration_warning()->String:
	return "cannot load World1 scene"


func _on_RestartBtn_pressed():
	print("restart button pressed")
	PlayerStats.health = PlayerStats.max_health
	get_tree().paused = false
	print("get_tree().paused = false")
	get_tree().reload_current_scene()
	print("get_tree().reload_current_scene()")
	get_tree().change_scene("res://World1.tscn")
	print("get_tree().change_scene()")
