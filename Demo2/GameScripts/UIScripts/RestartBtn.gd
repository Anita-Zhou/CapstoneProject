extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on__button_up():
	PlayerStats.health = PlayerStats.max_health
	get_tree().paused = false
	print("get_tree().paused = false")
	get_tree().reload_current_scene()
	print("get_tree().reload_current_scene()")
	
func _get_configuration_warning()->String:
	return "cannot load World1 scene"
	
	
