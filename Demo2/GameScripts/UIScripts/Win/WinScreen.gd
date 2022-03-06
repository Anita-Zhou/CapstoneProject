extends CanvasLayer

onready var winOver: ColorRect = $ColorRect
onready var scene_tree := get_tree()


func _on_ContTxtBtn_button_up():
	queue_free()
	
	
func _on_MainTxtBtn_button_up():
	print("=====pressed main menu button")
	PlayerStats.reset()
	get_tree().change_scene("res://Levels/SplashScreen.tscn")
