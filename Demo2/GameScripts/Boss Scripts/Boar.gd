extends KinematicBody2D


var count = 0
var timer = 0
var stop_timer = 0
var rng = RandomNumberGenerator.new()

var speed = 40
var direction = Vector2(0, 0)
var temp_direction = Vector2(0, 0)
var distance2hero = float("inf")

var anim_sprite = null
var player = null
var should_stop = false
var second_phase = false
var stone_timer = 0
var spike_timer = 0

enum{
	IDLE,
	WALK,
	CHARGE_PREP,
	CHARGE,
	STOP
}
var state = WALK

onready var stoneSkill = get_node("fallingStone")
onready var spikeSkill = get_node("EarthSpike")
onready var screenSize = get_viewport().get_visible_rect().size
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var stats = $Stats


# Called when the node enters the scene tree for the first time.
func _ready():
	anim_sprite = get_node("BoarAnimation")
	player = get_parent().get_node("Player")

func _physics_process(delta):
	if(is_instance_valid(player)):
		direction = player.position - self.position
		distance2hero = self.position.distance_to(player.position)
	direction = direction.normalized()

	var motion = direction * speed
	animationTree.set("parameters/Walk/blend_position", direction)
	animationTree.set("parameters/ChargePrep/blend_position", direction)
	animationTree.set("parameters/Idle/blend_position", direction)
	
	match state:
		IDLE:
			motion = direction * 0
			if timer < 60:
				animationState.travel("Idle")
				timer = timer + 1
			else:
				state = WALK
				timer = 0
		WALK:
			motion = direction * speed
			if distance2hero > 300:
				animationState.travel("Walk")
			else:
				state = CHARGE_PREP
				$PrepSound.play()
		CHARGE_PREP:
			motion = direction * 0
			if timer < 100:
				animationState.travel("ChargePrep")
				timer = timer + 1
			else:
				temp_direction = direction
				animationTree.set("parameters/Charge/blend_position", direction)
				state = CHARGE
				$ChargeSound.play()
				timer = 0
		CHARGE:
			motion = temp_direction * speed * 6
			if timer < 60:
				animationState.travel("Charge")
				timer = timer + 1
			else:
				state = IDLE
				timer = 0
		STOP:
			motion = direction * 0
			if stop_timer < 180:
				animationState.travel("Idle")
				stop_timer = stop_timer + 1
			else:
				temp_direction = direction
				animationTree.set("parameters/Charge/blend_position", direction)
				state = WALK
				timer = 0

	if(second_phase):
		if(stone_timer < 60):
			stone_timer = stone_timer + 1
		else:
			var fall_position = Vector2(rng.randi_range(0,screenSize.x), rng.randi_range(100,screenSize.y))
			stoneSkill.being_cast(fall_position)
			stone_timer = 0
			
	if(spike_timer < 360):
		spike_timer = spike_timer + 1
	else:
		if(state == WALK):
			spikeSkill.being_cast()
			state = IDLE
			spike_timer = 0
			
	move_and_slide(motion)
	move_and_collide(motion * delta)
	
	
		

func _process(delta):
	if(is_instance_valid(player)):
		distance2hero = self.position.distance_to(player.position)

	
#	AnimationProcess()
#	if(count > 0):
#		count -= 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func AnimationProcess():
	if(direction.x < 0):
		anim_sprite.set_flip_h(false)
	else:
		anim_sprite.set_flip_h(true)
	anim_sprite.play("boar_run")
	# need to do more
	if(distance2hero < 150 and count == 0):
		print("stop and charge")
		should_stop = true
		#anim_sprite.stop()
		anim_sprite.play("boar_charge")
		anim_sprite.connect("animation_finished", self, "handle_charge_stop")
		print("boar_charge played")
		

func handle_charge_stop():
	print("handle_charge_stop")
	anim_sprite.disconnect("animation_finished", anim_sprite, "handle_charge_stop")
	should_stop = false
	print("should_stop", should_stop)
	anim_sprite.play("boar_run")
	print("replay run")
	count = 20

func _on_Hurtbox_area_entered(area):
	print(area.get_parent().get_name() + " entered boss")
	if("WoodIdle" in area.get_parent().get_name()):
		fix_position(false)
	elif("WoodSkill" in area.get_parent().get_name()):
		fix_position(true)
	else:
		take_damage(area)
	if stats.health < stats.max_health/2:
		second_phase = true


func take_damage(area):
	stats.health -= 53
#	emit_signal("boss_damage")
	animationPlayer.play("Hurt")


func fix_position(check):
	if(!check):
		stop_timer = 90
		if(state != CHARGE):
			state = STOP
	else:
		stop_timer = stop_timer - 90
		
func get_stats():
	return stats

func _on_Stats_no_health():
	PlayerStats.num_skills += 1
	queue_free()
