extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 40
var direction = Vector2(0, 0)
var temp_direction = Vector2(0, 0)
var distance2hero = float("inf")

var anim_sprite = null
var player = null
var second_phase = false

enum{
	IDLE
}
var state = IDLE

onready var screenSize = get_viewport().get_visible_rect().size
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var stats = $Stats

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func _physics_process(delta):
	if(is_instance_valid(player)):
		direction = player.position - self.position
		distance2hero = self.position.distance_to(player.position)
	direction = direction.normalized()

	var motion = direction * speed
	
	match state:
		IDLE:
			motion = direction * 0
			animationPlayer.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
