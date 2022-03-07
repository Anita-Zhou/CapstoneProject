extends Sprite

var block_sig = ""
var unblock_sig = ""
var skill_name = self.get_name()
var cd_unit = 0.0
var full_cd = 0.0

onready var cd = $SkillCD
onready var stats = $"/root/PlayerStats"

# Called when the node enters the scene tree for the first time.
func _ready():
	print("skill name:", skill_name)
	match skill_name:
		"Wood":
			block_sig = "wood_block"
			unblock_sig = "wood_unblock"
			full_cd = 300.0
		"Water":
			block_sig = "water_block"
			unblock_sig = "water_unblock"
			full_cd = 420.0
	PlayerStats.connect(block_sig, self, "_draw")
	PlayerStats.connect(unblock_sig, self, "_erase")
	
func _physics_process(delta):
#	cd_unit = stats._get_cd(skill_name) / 100.0
#	cd.value = stats._get_cd(skill_name) / cd_unit
	pass
	
func _draw():
	pass

func _erase():
	pass
