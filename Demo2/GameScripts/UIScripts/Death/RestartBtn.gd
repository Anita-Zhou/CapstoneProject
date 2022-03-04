extends TextureButton

onready var deathscn = get_tree().get_root().get_node("World1/DeathLayer/DeathScreen")

func _ready():
	pass # Replace with function body.

func _get_configuration_warning()->String:
	return "cannot load World1 scene"


func _on_ReTxtBtn_button_up():
	print("=========== restart button pressed")
	PlayerStats.reset()
#	self.set_paused(false)
	deathscn.set_paused(false)
	print("get_tree().paused = false")
	#get_tree().reload_current_scene()
	#print("get_tree().reload_current_scene()")
	get_tree().change_scene("res://Levels/World1.tscn")
	print("get_tree().change_scene()")
