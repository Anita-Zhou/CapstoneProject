extends Sprite

var block_sig = ""
var unblock_sig = ""
var cd_unit = 0.0
var full_cd = 0.0

onready var cd = $SkillCD
onready var skill_name = self.get_name()
onready var stats = $"/root/PlayerStats"

# Called when the node enters the scene tree for the first time.
func _ready():
#	skill_name = self.get_name()
	print("skill name:", skill_name)
	match skill_name:
		"Wood":
			print("skill is wood")
			block_sig = "wood_block"
			unblock_sig = "wood_unblock"
			full_cd = 360.0
		"Water":
			block_sig = "water_block"
			unblock_sig = "water_unblock"
			full_cd = 480.0
		"Earth":
			print("skill is earth")
			block_sig = "earth_block"
			unblock_sig = "earth_unblock"
			full_cd = 560.0
	PlayerStats.connect(block_sig, self, "_draw")
	PlayerStats.connect(unblock_sig, self, "_erase")
	
func _physics_process(delta):
	cd_unit = full_cd / 100.0
	cd.value = stats._get_cd(skill_name) / cd_unit
#	pass
	
func _draw():
	pass

func _erase():
	pass
