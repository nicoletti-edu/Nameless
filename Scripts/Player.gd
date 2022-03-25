extends KinematicBody2D

#speed = 400
#gravity = 1200

export var speed = 400
export var jump_speed = -600
var GRAVITY = 1700
var jumping
var right
var left
var attack
var velocity = Vector2()
onready var _animations = $animations

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	velocity.x = 0
	right = Input.is_action_pressed('Right')
	left = Input.is_action_pressed('Left')
	attack = Input.is_action_just_pressed('Attack')
	var jump = Input.is_action_just_pressed('Up')

	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x += speed
	if left:
		velocity.x -= speed

func _process(_delta):
	_playAnimations(_delta)
	flip()

func _physics_process(_delta):
	get_input()
	velocity.y += GRAVITY * _delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))

func flip():
	_animations.flip_h = left

func _playAnimations(_delta):
	if velocity.x != 0 and is_on_floor():
		_animations.play("Run")
	elif !is_on_floor() and velocity.y < 0:
		_animations.play("Jump")
	elif !is_on_floor() and velocity.y > 0:
		_animations.play("Fall")
	else:
		_animations.play("Idle")

