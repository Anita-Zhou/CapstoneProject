extends TextureButton


func _on_MainTxtBtn_button_up():
	print("=====pressed main menu button")
	PlayerStats.reset()
	get_tree().change_scene("res://Levels/SplashScreen.tscn")


func _on_button_up():
	pass # Replace with function body.
