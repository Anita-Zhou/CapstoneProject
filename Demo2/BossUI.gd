extends Control

var health = 1000 setget set_health
var max_health = 1000 setget set_max_health

onready var label = $Label
onready var healthBar = $TextureProgress
onready var update_tween = $UpdateTween
var boss;

#export(Color) var healthy_color = Color.green
#export(Color) var caution_color = Color.yellow
#export(Color) var danger_color = Color.red
#export(float, 0, 1, 0.05) var caution_zone = 0.5
#export(float, 0, 1, 0.05) var danger_zone = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	var SceneName = get_tree().current_scene.get_name()
	if(SceneName == "World1"):
		boss = $"../../Boar"
	elif (SceneName == "Tutorial"):
		boss = $"../../Dummy"
		label.text = "Scarecrow"
	elif (SceneName == "World2"):
		boss = $"../../ZhuRong"
		label.text = "Pyrolord, the God of Fire"
		
		
	print("boss:", boss)
	var boss_stats = boss.get_stats()
	self.max_health = boss_stats.max_health
	self.health = boss_stats.health
	boss_stats.connect("health_changed", self, "set_health")

func set_health(value):
	health = clamp(value, 0, max_health)
	print("boss set_health called. boss health: ", health)
	#emit_signal("health_updated")
	#update progress bar
	#_assign_color(health)
	## TODO: here is hard coded, need to hange health value altered 
	update_tween.interpolate_property(healthBar, "value", healthBar.value, \
	health/10, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	update_tween.start()
	
	#update label
	#if label != null:
	#	label.text = "HP = " + str(health)
func _assign_color(health):
	pass
	
func set_max_health(value):
	max_health = max(value, 1)
	#emit_signal("max_health_updated")

