extends CanvasLayer

var paused := false setget set_paused

onready var scene_tree := get_tree()
onready var pauseOverlay: ColorRect = get_node("ColorRect")

export(String, FILE) var replayscn: = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_paused(value: bool) -> void:
	#scene_tree.paused = value
	#self.visible = value
	pauseOverlay.visible = value
	print("set paused")

func _input(ev):
	# While this node instance exists, a pause click will delete it
	if Input.is_action_pressed("pause"):
		queue_free()

##
# This is main button section
#
func _on_MainTxtBtn_pressed():
	scene_tree.paused = false
	print("=====Pause screen pressed main menu button")
	PlayerStats.reset()
	get_tree().change_scene("res://Levels/SplashScreen.tscn")
	# Since changed scene no need to queue_free
	
##
# This is restart button section
#
func _get_configuration_warning()->String:
	return "cannot load restart scene"

func _on_ReTxtBtn_pressed():
	scene_tree.paused = false
	print("=========== restart button pressed")
	PlayerStats.reset()
	get_tree().change_scene(replayscn)
	print("get_tree().change_scene()")
	# Since changed scene no need to queue_free
	

##
# This is quit button section
#
func _on_QuitBtn_pressed():
	get_tree().quit()

