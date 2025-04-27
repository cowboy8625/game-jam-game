class_name Player
extends CharacterBody2D

@warning_ignore("unused_signal")
signal coin_collected()

@export var CHEESEBURGERS = 4
@export var HEALTH = 3
@export var TSHIRTSIZE = 2

const DEFAULT_WALK_SPEED = 300.0
const ACCELERATION_SPEED = DEFAULT_WALK_SPEED * 6.0
const JUMP_VELOCITY = -725.0
const TERMINAL_VELOCITY = 700

@export var action_suffix := ""

var gravity: int = ProjectSettings.get("physics/2d/default_gravity")
@onready var platform_detector := $PlatformDetector as RayCast2D
@onready var animated_sprite = $AnimatedSprite2D as AnimatedSprite2D
@onready var shoot_timer := $ShootAnimation as Timer
@onready var jump_sound := $Jump as AudioStreamPlayer2D
@onready var gun: Gun = animated_sprite.get_node(^"Gun")
@onready var camera := $Camera as Camera2D
@onready var StateMachine := self.get_parent().get_parent()
var _double_jump_charged := false

func _ready():
	# Ensure the animation is stopped at the start
	animated_sprite.stop()
	set_tshirt_size()

func _physics_process(delta: float) -> void:
	if is_on_floor():
		_double_jump_charged = true

	if Input.is_action_just_pressed("jump" + action_suffix):
		try_jump()
	elif Input.is_action_just_released("jump" + action_suffix) and velocity.y < 0.0:
		velocity.y *= 0.6

	velocity.y = minf(TERMINAL_VELOCITY, velocity.y + gravity * delta)

	# Recalculate walk_speed based on current TSHIRTSIZE
	var current_walk_speed = DEFAULT_WALK_SPEED * (1.0 - TSHIRTSIZE * 0.1)
	current_walk_speed = max(current_walk_speed, 50.0)  # don't let it go below a minimum

	var direction : float = Input.get_axis("move_left" + action_suffix, "move_right" + action_suffix) * current_walk_speed
	velocity.x = move_toward(velocity.x, direction, ACCELERATION_SPEED * delta)

	var animation := get_new_animation()

	# Handle horizontal flip and animation
	if not is_zero_approx(velocity.x):
		# Play the running animation
		play_animation(animation)
		if velocity.x > 0.0:
			animated_sprite.flip_h = false  # Face right
		else:
			animated_sprite.flip_h = true  # Face left
	else:
		# When idle, play the idle animation
		var idleAnimation = get_new_animation(false, true)
		play_animation(idleAnimation)

	floor_stop_on_slope = not platform_detector.is_colliding()
	move_and_slide()

	# Handle shooting action
	var is_shooting := false
	if Input.is_action_just_pressed("shoot" + action_suffix):
		var shootDirection = 1
		if animated_sprite.flip_h == true:
			shootDirection = -1
		is_shooting = gun.shoot(shootDirection)

func play_animation(animation_name: String):
	if animated_sprite.animation != animation_name:
		animated_sprite.play(animation_name)

func takeDamage() -> void:
	if HEALTH == 0:
		die()
	else:
		HEALTH -= 1

func die() -> void:
	# Restart
	print('restart')
	StateMachine.restartState()


func get_new_animation(is_shooting := false, isIdle := false) -> String:
	var animation_new: String

	if TSHIRTSIZE == TshirtSize.XL:
		animation_new = 'fattest'
	elif TSHIRTSIZE == TshirtSize.L:
		animation_new = 'fat'
	elif TSHIRTSIZE == TshirtSize.M:
		animation_new = 'normal'
	elif TSHIRTSIZE == TshirtSize.S:
		animation_new = 'skinny'
	elif TSHIRTSIZE == TshirtSize.XS:
		animation_new = 'skinniest'
	else:
		animation_new = 'idle'  # Default to idle if no condition matches

	# Append 'Idle' if the player is idle
	if isIdle:
		animation_new += 'Idle'

	return animation_new

func try_jump() -> void:
	if is_on_floor():
		jump_sound.pitch_scale = 1.0 * (1.0 - TSHIRTSIZE * 0.05)
	elif _double_jump_charged:
		_double_jump_charged = false
		velocity.x *= 2.5
		jump_sound.pitch_scale = 1.5 * (1.0 - TSHIRTSIZE * 0.05)
	else:
		return
	velocity.y = JUMP_VELOCITY * (1.0 - TSHIRTSIZE * 0.05)
	jump_sound.play()

func scale_player(delta: float) -> void:
	$AnimatedSprite2D.scale += Vector2(delta, delta)

	var shape = $CollisionShape2D.shape
	if shape is RectangleShape2D:
		shape.extents += Vector2(delta, delta)
	elif shape is CircleShape2D:
		shape.radius += delta

enum TshirtSize {
	XS = 0,
	S = 1,
	M = 2,
	L = 3,
	XL = 4
}

func set_tshirt_size() -> void:
	if CHEESEBURGERS > 8:
		TSHIRTSIZE = TshirtSize.XL
	elif CHEESEBURGERS > 6:
		TSHIRTSIZE = TshirtSize.L
	elif CHEESEBURGERS > 4:
		TSHIRTSIZE = TshirtSize.M
	elif CHEESEBURGERS > 2:
		TSHIRTSIZE = TshirtSize.S
	else:
		TSHIRTSIZE = TshirtSize.XS
