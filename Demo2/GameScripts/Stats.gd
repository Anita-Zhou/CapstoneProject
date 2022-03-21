extends Node

export(int) var max_health = 100
onready var health = max_health setget set_health

var crit_t = 0.2
var crit_atk = 1.2
var dec_dmg = 0.5

signal no_health
signal health_changed(value)

# Elemental skill cool downs are treated as critical section
signal wood_block
signal wood_unblock

signal water_block
signal water_unblock

signal earth_block
signal earth_unblock

#Elemental skill cd
var wood_cd = 0
var water_cd = 0
var earth_cd = 0

func _ready():
#	health = 40
	pass

func reset():
	health = max_health
	
func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")
		
func _physics_process(delta):
	# Wood
	if(wood_cd > 0):
		wood_cd -= 1
	elif(wood_cd == 0):
		emit_signal("wood_unblock")
	# Water
	if(water_cd > 0):
		water_cd -= 1
	elif(water_cd == 0):
		emit_signal("water_unblock")
	# Earth
	if(earth_cd > 0):
		earth_cd -= 1
	elif(earth_cd == 0):
		emit_signal("earth_unblock")
		

func _on_wood_cast():
	wood_cd = 300
	emit_signal("wood_block")

func _on_water_cast():
	water_cd = 420
	emit_signal("water_block")
	
func _on_earth_cast():
	earth_cd = 150
	emit_signal("earth_block")
	
##
# get the cool down of indicated skill
# name is a String
func _get_cd(skill):
	match skill:
		"Wood":
			return wood_cd
		"Water":
			return water_cd
		"Earth":
			return earth_cd
	
