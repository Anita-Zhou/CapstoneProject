extends Node2D

#onready var screenSize = get_viewport().get_visible_rect().size

func _ready():
	pass # Replace with function body.

func being_cast(position):
	# Check position left, right, up, down
#	if position.x < screenSize.x/2:
		#left
		
	# FireBall preparation
	$AnimationPlayer.play("fireBeam_summoning")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
