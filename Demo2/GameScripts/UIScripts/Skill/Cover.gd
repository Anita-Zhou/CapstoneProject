extends Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.connect("wood_block", self, "_draw")
	PlayerStats.connect("wood_unblock", self, "_erase")

func _draw():
	self.visible = true

func _erase():
	self.visible = false
