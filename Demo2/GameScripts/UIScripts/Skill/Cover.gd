extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.connect("wood_block", self, "_draw")
#	_draw()

func _draw():
	var cen = Vector2(0, 0)
	var rad = 26
	var col = Color(255, 255, 255, 0.5)
	draw_circle(cen, rad, col)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
