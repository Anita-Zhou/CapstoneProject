extends TextureButton

#var currScene = get_parent().get_parent().get_name()

#onready var deathscn = get_tree().get_root().get_node("World1/PauseLayer/PauseScreen")
export(String, FILE) var replayscn: = ""


func _ready():
	pass # Replace with function body.

func _get_configuration_warning()->String:
	return "cannot load World1 scene"


func _on_ReTxtBtn_button_up():
	print("=========== restart button pressed")
	PlayerStats.reset()
#	self.set_paused(false)
	print("get_tree().paused = false")
	#get_tree().reload_current_scene()
	#print("get_tree().reload_current_scene()")
	get_tree().change_scene(replayscn)
	print("get_tree().change_scene()")
