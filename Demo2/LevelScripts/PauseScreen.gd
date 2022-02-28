extends Control

var paused := false setget set_paused
onready var scene_tree := get_tree()
onready var pauseOverlay: ColorRect = get_node("ColorRect")

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
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
