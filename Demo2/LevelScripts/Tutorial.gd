extends Node2D

const DeathScn = preload("res://GameScns/UIScns/DeathUI/DeathScreen.tscn")
const PauseScn = preload("res://GameScns/UIScns/PauseUI/PauseScreen.tscn")
const WinScn = preload("res://GameScns/UIScns/WinUI/WinScreen.tscn")

var is_paused = false
onready var enemy = $Dummy
onready var portal = $Portal
onready var dialogue = $TutorialDialogue
#onready var arrow = $Arrow

# Called when the node enters the scene tree for the first time.
func _ready():
	SplashBgm.stop_music()
	PlayerStats.connect("no_health", self, "_handle_death")
	enemy.stats.connect("no_health", self, "_handle_win")
	enemy.stats.connect("no_health", portal, "_on_enemy_died")
#	enemy.stats.connect("no_health", arrow, "_on_enemy_died")
	dialogue.connect("end_dialogue", enemy, "_on_dialogue_ended")
#	var fireBall = load("res://GameScns/BossScns/fireBall.tscn")
#	var fb = fireBall.instance()
#	self.add_child(fb)
#	fb.set_global_position(Vector2(100, 100))

func _unhandled_input(event):
	if(event.is_action_pressed("pause")):
		if(is_paused == false):
			var pause_menu = PauseScn.instance()
			add_child(pause_menu)
			is_paused = true
		else:
			is_paused = false

		
func _handle_death():
	var death_menu = DeathScn.instance()
	add_child(death_menu)
	
func _handle_win():
	var win_menu = WinScn.instance()
	add_child(win_menu)

func _process(delta):
	if $BGM.playing == false:
		$BGM.play()

