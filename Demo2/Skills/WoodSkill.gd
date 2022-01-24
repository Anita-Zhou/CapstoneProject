extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func being_cast():
	print("skill being cast")
	var player = get_owner()
	var player_position = player.get_position()
	var direction = player.get_player2enemy_dir()
	print("prev cast position", position)
	print("wanted position", player_position + direction * 60)
	self.position = player_position + direction * 60
	print("cast position", position)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
