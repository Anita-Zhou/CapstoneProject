extends TextureButton

onready var winOver = $"../ColorRect"

func _on_ContTxtBtn_button_up():
	winOver.visible = false
	
