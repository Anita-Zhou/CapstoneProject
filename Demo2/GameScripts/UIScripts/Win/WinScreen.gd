extends CanvasLayer

onready var winOver = $ColorRect

func _on_ContTxtBtn_button_up():
	winOver.visible = false
	
func _on_MainTxtBtn_button_up():
	print("=====pressed main menu button")
	PlayerStats.reset()
	get_tree().change_scene("res://Levels/SplashScreen.tscn")
