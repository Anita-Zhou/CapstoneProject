extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var count = 0
# var rng = RandomNumberGenerator.new()
var speed = 40
var direction = Vector2(0, 0)
var distance2hero = float("inf")
var anim_sprite = null
var player = null
var should_stop = false



# Called when the node enters the scene tree for the first time.
func _ready():
	anim_sprite = get_node("BoarAnimation")
	player = $"../Player"

func _physics_process(delta):
	direction = player.position - self.position
	direction = direction.normalized()
	#print("direction", direction)
	# if(count == 0):
	# 	direction.x = rng.randf_range(-2, 2)
	# 	direction.y = rng.randf_range(-2, 2)
	# 	count = 40
	# count -= 1
	var motion = direction * speed
	if(should_stop == false):
		move_and_slide(motion)
		move_and_collide(motion * delta)
		

func _process(delta):
	distance2hero = self.position.distance_to(player.position)
	AnimationProcess()
	if(count > 0):
		count -= 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func AnimationProcess():
	anim_sprite.play("boar_run")
	# need to do more
	if(distance2hero < 2 and count == 0):
		print("stop and charge")
		should_stop = true
		anim_sprite.play("boar_charge")
		print("boar_charge played")
		anim_sprite.connect("animation_finished", anim_sprite, "handle_charge_stop")

func handle_charge_stop():
	print("handle_charge_stop")
	anim_sprite.disconnect("animation_finished", anim_sprite, "handle_charge_stop")
	should_stop = false
	anim_sprite.play("boar_run")
	print("replay run")
	count = 20


	
