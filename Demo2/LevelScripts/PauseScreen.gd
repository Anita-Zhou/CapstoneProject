extends CanvasLayer

var paused := false setget set_paused
onready var scene_tree := get_tree()
onready var pauseOverlay: ColorRect = get_node("ColorRect")

export(String, FILE) var replayscn: = ""

func set_paused(value: bool) -> void:
	#scene_tree.paused = value
	#self.visible = value
	pauseOverlay.visible = value
	print("set paused")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(ev):
	if Input.is_action_pressed("ui_cancel"):
		pauseOverlay.visible = true

##
# This is main button section
#
func _on_MainTxtBtn_button_up():
	print("=====pressed main menu button")
	PlayerStats.reset()
	get_tree().change_scene("res://Levels/SplashScreen.tscn")
	
##
# This is restart button section
#
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
	

##
# This is quit button section
#
func _on_QuitBtn_button_up():
	get_tree().quit()


