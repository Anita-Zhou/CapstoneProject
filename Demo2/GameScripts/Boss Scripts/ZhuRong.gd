extends KinematicBody2D

var FRAME_RATE = 60

# Sppeds
var speed = 40
# Directions
var direction2hero = Vector2(0, 0)
var horizontal_dirc2hero = Vector2(0, 0)
var direction_to_mid = Vector2(0, 0)
var direction_to_avoid = Vector2(0, 0)
var temp_direction = Vector2(0, 0)
# Distances
var distance2hero = float("inf")
var horizontal_dist2hero = float("inf")

var anim_sprite = null
var player = null
var second_phase = false
#var second_phase_sound_played = false

enum{
	IDLE,
	AVOID, 
	MOVE,
	MOVE_STAFF, 
	MELEE_ATK,
	ENRAGE,
	STOP
}
var state = IDLE
var rng = RandomNumberGenerator.new()

onready var screenSize = get_viewport().get_visible_rect().size
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var stats = $Stats

#fixed point
onready var mid_scrn = Vector2.ZERO
onready var abv_plat = Vector2.ZERO
onready var player_pos = Vector2.ZERO
onready var left_edge = Vector2.ZERO
onready var right_edge = Vector2.ZERO

# Timers for scripts
var timer = 0
var stop_timer = 0 # timer for wood skill

# Skill timer
var fireball_timer = 0
var fireball_timer2 = 0
var firebeam_timer = 0
var lava_timer = 0
var meleeAtk_timer = 0
var playerAway_timer = 0
var chase_timer = 0

# State timer
var restrained_timer = 0
# =========
var avoiding = false 
var should_avoid = false
var after_avoid = 0
# =========
var hurt_timer = 0 
var hurt_cnt = 0

# Helper var
var meleeAtk = false
var arrived = false
var rageMelee = true

# Combined timer check 
var ready_to_cast = false
var ready_to_atk = true

var rageFire = null

# Thresholds
var melee_thd = FRAME_RATE * 12

# Signals
signal zr_half_health

#skills
onready var fireBall = get_node("FireBall")
onready var lavaPond = get_node("LavaPond")
onready var fireBeam = get_node("FireBeam")

#world 
onready var world = get_tree().current_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_sprite = get_node("AnimatedSprite")
	player = get_parent().get_node("Player")
	# Can only be set once by this, indicating the center of the screen
	#  where all casting os spells happneing 
	mid_scrn = self.global_position
	abv_plat = mid_scrn + Vector2(0, -70)
	player_pos = player.global_position
	

# Debug
var prev_state = IDLE

func _physics_process(delta):
	
	## DEBUG! 
	if(prev_state != state):
		print( "State change from ", prev_state, " to ", state)
	prev_state = state
	
	# If player is not dead, calculate distance and direction between boss and hero.
	if(is_instance_valid(player)):
		direction2hero = player.position - self.position
		distance2hero = self.position.distance_to(player.position)
		horizontal_dist2hero = abs(self.position.x - player.position.x)
	direction2hero = direction2hero.normalized()
	# Decide horizontal moving direction
	horizontal_dirc2hero = Vector2(direction2hero.x, 0).normalized()
	# Deicide the way back 
	direction_to_mid = (mid_scrn - self.position).normalized()
	direction_to_avoid = (abv_plat - self.position).normalized()
	
	# Combined state detect
	if (fireball_timer > FRAME_RATE * 5 or firebeam_timer > FRAME_RATE * 12):
		ready_to_cast = true
	if (playerAway_timer > FRAME_RATE * 20 or meleeAtk_timer > melee_thd):
		ready_to_atk = true
	# If get hurt, start counting how many times of hurt taken
	# within limited time range
	if (hurt_timer > 0):
		hurt_timer -= 1
		
#	# TODO: explain
#	if restrained_timer > FRAME_RATE * 5:
#		rageMelee = true
#	if restrained_timer < FRAME_RATE * 3 and second_phase:
#		state = IDLE
#		rageFire.restrained()
#	else:
#		state = MELEE_ATK
	
	# Update timers
	fireball_timer += 1
	firebeam_timer += 1
	meleeAtk_timer += 1
	restrained_timer += 1

	# Second phase random generation of lava pools
	# TODO: lava pools are generated random within a frame close to player's position
	if(second_phase):
		# Create the rage fire once into second ohase and only once
		if rageFire == null:
			var RageFire = load("res://GameScns/BossScns/ZhuRongSkill/RageFire.tscn")
			rageFire = RageFire.instance()
			var boss = get_tree().current_scene.get_node("ZhuRong")
			boss.add_child(rageFire)
		# Cast consecutive fireballs
		if horizontal_dist2hero < 300 and fireball_timer2 > FRAME_RATE * 5:
			fireBall.being_cast(direction2hero)
			fireBall.being_cast(direction2hero)
			fireBall.being_cast(direction2hero)
			fireball_timer2 = 0
		fireball_timer2 += 1
		
##		# I don't think this is needed 
#		if second_phase_sound_played == false:
#			$Second_phase.play()
#			second_phase_sound_played = true
		
		if(lava_timer < FRAME_RATE * 2):
			lava_timer = lava_timer + 1
		else:
			var lava_pos = Vector2(rng.randi_range(0,screenSize.x), rng.randi_range(250,screenSize.y-100))
			lavaPond.being_cast(lava_pos)
			lava_timer = 0

	var motion = direction2hero * speed
	animationTree.set("parameters/Idle/blend_position", direction2hero)
	animationTree.set("parameters/Move/blend_position", direction2hero)
	animationTree.set("parameters/MoveStaff/blend_position", direction2hero)
	animationTree.set("parameters/MeleeAttack/blend_position", direction2hero)
	
	match state:
		IDLE:
			motion = Vector2.ZERO
			animationState.travel("Idle")
			# Since we can be avoiding while doing other works
			# have to check whether if is avoiding and deduce timer
			if (avoiding):
				if (after_avoid < 0):
					state = AVOID
				else:
					after_avoid -= 1
#					if(after_avoid % FRAME_RATE == 0):
#						print("after_avoid: ", after_avoid / FRAME_RATE)
				
			# Prioritize avoiding too much attack from player 
			if (should_avoid):
				state = AVOID
			# Prioritize melee attack when player's been away for too long
			if (ready_to_atk):
				# Designated to state in cahrge of throw melee attack
				state = MELEE_ATK
			# If able to cast skills, cast skills
			elif (ready_to_cast):
				state = MOVE_STAFF
			# If player is away but not for too long, horizontally trace player
			elif (horizontal_dist2hero > 40):
				state = MOVE
				
#		# Avoid attack by getting way from the platform	
#		# Also responsible for getting out of AVOID if hide for long enough
		AVOID:
			if (not avoiding):
				should_avoid = false
				# Start to avoid attack
				motion = direction_to_avoid * 80
				# If have gotten to escape place, change to IDLE
				if (self.position.distance_to(abv_plat) < 5):
#					print("======AVOID========  Avoiding at above\n")
					avoiding = true
					after_avoid = FRAME_RATE * 4
					state = IDLE
			else:
				motion = direction_to_mid * 80
				if (self.position.distance_to(mid_scrn) < 5):
#					print("======AVOID========  Avoiding back at\n")
					avoiding = false
					after_avoid = 0
					state = IDLE
			animationState.travel("Move")
				
		# Horizontally move, either go for melee attack or go for idle
		MOVE:
			if (avoiding):
				if (after_avoid < 0):
					state = AVOID
				else:
					after_avoid -= 1
#					# DEBUG
#					if(after_avoid % FRAME_RATE == 0):
#						print("after_avoid: ", after_avoid / FRAME_RATE)
				
			motion = horizontal_dirc2hero * 20
			animationState.travel("Move")
			if (ready_to_atk):
#				print("ready_to_atk")
				state = MELEE_ATK
			elif (ready_to_cast):
#				print("ready_to_cast")
				state = MOVE_STAFF
		
		# Prepare to cast magic attack, decide on what magic attack to do
		MOVE_STAFF:
			if (avoiding):
				if (after_avoid < 0):
					state = AVOID
				else:
					after_avoid -= 1
#					if(after_avoid % FRAME_RATE == 0):
#						print("after_avoid: ", after_avoid / FRAME_RATE)
			motion = Vector2.ZERO
			# Prepare for attack
			animationState.travel("MoveStaff")
			
		ENRAGE:
			print("!!!!! Is in state ENRAGE !!!!!")
			# Display rage melee right after enraged
			$Second_phase.play()
			melee_thd = FRAME_RATE * 8
			world.change_bgm()
			state = MELEE_ATK
			
			
			
		MELEE_ATK:
			should_avoid = false
			
			# If chase for too long or if player is close, indicate arrived
			if (distance2hero < 30 || chase_timer > FRAME_RATE * 6):
				arrived = true
				chase_timer = 0
			##
			# Melee attack is separated into three states:
			# before attack, while attack, and after attatck
			#
			# If has neither arrived nor attacked
			if(!arrived && !meleeAtk):
				# Move towards player
				motion = direction2hero * 100
				animationState.travel("Move")
				chase_timer += 1
			# If has arrived but has not attack
			elif(arrived && !meleeAtk):
				motion = Vector2.ZERO
				# ATTACK based on phase
				# Phase 1
				if (!second_phase):
					animationState.travel("MeleeAttack")
				# Phase 2
				else:
					if(distance2hero > 30):
						motion = direction2hero * 70
					if rageMelee:
						animationState.travel("RageMelee")
			# If has arrived and has attacked 
			elif(arrived && meleeAtk):
				# Getting back to center
				motion = direction_to_mid * 90
				animationState.travel("Move")
				# If have gotten back to mid screen, change to IDLE
				if (self.position.distance_to(mid_scrn) < 30):
					state = IDLE
					# Back to as if has never throw melee attack
					arrived = false
					meleeAtk = false
					meleeAtk_timer = 0
					playerAway_timer = 0
					# Reset ready_to_atk
					ready_to_atk = false
			else:
				print("===== ERROR: has not arrived but attacked =====")

		# Being stopped by the vines (is it useful?)
		STOP:
			motion = horizontal_dirc2hero * 0
			if stop_timer < 180:
				animationState.travel("Idle")
				stop_timer = stop_timer + 1
			else:
				temp_direction = horizontal_dirc2hero
				state = MOVE
				timer = 0
			
	move_and_slide(motion)
	move_and_collide(motion * delta)

func get_stats():
	return self.stats

func get_direction2hero():
	return direction2hero

func back_to_normal():
	# move state to idle
	state = IDLE

# Helper function that modify meleeAtk after finished boss melee attack
func finished_melee_attack():
	meleeAtk = true
	
func handle_magic_cast():
	# Prioritize firebeam
	if (firebeam_timer > FRAME_RATE * 14):
#		var fireBeamChoices = [2,3,4]
#		var fireBeamNum = fireBeamChoices[randi() % fireBeamChoices.size()]
#
#		while fireBeamNum > 0:
#			var dirChosen = null
#			if fireBeamNum > 1:	
#				var dirChoices = [1, 2, 3]
#				dirChosen = dirChoices[randi() % dirChoices.size()]
#			else:
#				dirChosen = 2
		fireBeam.being_cast()
#			fireBeamNum -= 1
		firebeam_timer = 0
		fireball_timer = 0
	# Then consider fireball
	elif (fireball_timer > FRAME_RATE * 5):
		if (horizontal_dist2hero < 300):
			fireBall.being_cast(direction2hero)
			fireball_timer = 0
	# Reset ready_to_cast so that it can prepare for 
	ready_to_cast = false
	# Always get back to IDLE after casting magic
	state = IDLE

func _on_Hurtbox_area_entered(area):
	print(area.get_parent().get_name() + " entered boss")
	if("WoodIdle" in area.get_parent().get_name()):
		fix_position(false)
	elif("WoodSkill" in area.get_parent().get_name()):
		fix_position(true)
	elif area.get_parent().get_name() == "WaterSkill":
		restrained_timer = 0
		
	else:
		take_damage(area)
	if stats.health < stats.max_health/2:
		second_phase = true

func fix_position(check):
	if(!check):
		stop_timer = 90
		if(state != IDLE):
			state = IDLE
	else:
		stop_timer = stop_timer - 90

func take_damage(area):
	#TODO: distinguish area 
	stats.health -= 35
	# Activate hurt_timer count down
	hurt_timer = FRAME_RATE * 3
	# If the timer is activated, count how many hurts is taken within the count down
	if (hurt_timer > 0):
		hurt_cnt += 1
		# If taking 3 damages within 3 seconds, avoid attack
		if (hurt_cnt > 3):
			should_avoid = true
			state = IDLE
			# Default hurt count and hurt timer
			hurt_cnt = 0
			hurt_timer = 0
		
#	emit_signal("boss_damage")
	animationPlayer.play("Hurt")
	print("zhu rong health", stats.health)


func _on_Stats_no_health():
	queue_free()

func _on_Stats_half_health():
	state = ENRAGE
