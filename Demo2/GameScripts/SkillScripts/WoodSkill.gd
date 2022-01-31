extends RigidBody2D

func being_cast():
	
	var player = get_owner()
	var player_position = player.get_position()
	var direction = player.get_player2enemy_dir()
	print("prev cast position", position)
	print("wanted position", player_position + direction * 60)
	self.position = position.move_toward(direction, -10)

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var player = get_owner()
#	var direction = player.get_player2enemy_dir()
#	var speed = 1 # Change this to increase it to more units/second
#	position = position.move_toward(direction, delta * speed)
