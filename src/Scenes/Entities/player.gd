extends Node2D

@export var speed := 120.0
@export var jump_force := 350.0
@export var gravity := 900.0

@onready var body: CharacterBody2D = $CharacterBody2D
@onready var sprite: AnimatedSprite2D = $CharacterBody2D/AnimatedSprite2D
var jumping := false
var jump_count := 0
const MAX_JUMPS := 2
func _ready() -> void:
	# Force grounded animation on start
	sprite.animation = "idle"
	sprite.play()

func _physics_process(delta: float) -> void:
	var dir := 0.0
	if Input.is_action_pressed("right"): dir += 1.0
	if Input.is_action_pressed("left"):  dir -= 1.0

	# Horizontal
	body.velocity.x = dir * speed

	# Gravity
	body.velocity.y += gravity * delta

	# Jump (double jump)
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMPS:
		jumping=true
		body.velocity.y = -jump_force
		jump_count += 1
		sprite.animation = "jump"; sprite.play()

	# Move & check floor
	body.move_and_slide()
	if body.is_on_floor():
		jump_count = 0
		# clamp tiny drift
		if abs(dir) < 0.001:
			body.velocity.x = 0.0

	# Flip (assumes art faces RIGHT by default)
	if dir != 0.0:
		sprite.flip_h = dir > 0.0

	# Animations
	if !body.is_on_floor() and jumping:
		if sprite.animation != "jump":
			sprite.animation = "jump"; sprite.play()
	elif dir != 0.0:
		if sprite.animation != "walking":
			sprite.animation = "walking"; sprite.play()
	else:
		if sprite.animation != "idle":
			sprite.animation = "idle"; sprite.play()



#extends Node2D
#
#@export var speed = 120
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#@onready var sprite: AnimatedSprite2D = $CharacterBody2D/AnimatedSprite2D # rename to your node
#
#var jumping := false
#@export var jump_force := 350.0
#
#
#func _process(delta: float) -> void:
	#var movement := Vector2.ZERO
	#if Input.is_action_pressed("right"): movement.x += 2
	#if Input.is_action_pressed("left"):  movement.x -= 2
	#if Input.is_action_pressed("down"):  movement.y += 1
	#if Input.is_action_pressed("up"):    movement.y -= 1
	## Start jump animation (once)
	#if Input.is_action_just_pressed("jump") and !jumping:
		#jumping = true
		#sprite.animation = "jump"
		#sprite.play()
	#
	## If currently playing jump, don’t override with walking/idle
	#if jumping:
		#if sprite.animation != "jump":
			#sprite.animation = "jump"
		## end jump when the animation finishes (non-looping jump)
		#if !sprite.is_playing():
			#jumping = false
		#return  # prevent walking/idle code from running this frame
	#if movement != Vector2.ZERO:
		#movement = movement.normalized()
		## Flip: assume the sprite faces RIGHT by default
		#sprite.flip_h = movement.x > 0
		#if sprite.animation != "walking":
			#sprite.animation = "walking"
		#if !sprite.is_playing():
			#sprite.play()
	#
	#else:
		#sprite.flip_h = sprite.flip_h  # unchanged
		#if sprite.animation != "idle":
			#sprite.animation = "idle"
		#if !sprite.is_playing():
			#sprite.play()
	#position += movement * speed * delta






#
#var screen_size: Vector2
#signal bumped_with(other: Node)
## Each instance chooses its own action names in the Inspector
#@export var up_action: StringName = "up1"
#@export var down_action: StringName = "down1"
#@export var left_action: StringName = "left1"
#@export var right_action: StringName = "right1"
#var has_potato := false
#@export var player_id: int = 1   # set this per instance in the Inspector
#@export var flame_scene: PackedScene
#@onready var other_player: CharacterBody2D = null
#
#var pow_speed : float = speed
#var can_throw_flames := false
##@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
#
##func play_move(dir: Vector2) -> void:
	##if dir != Vector2.ZERO:
		##anim.play("default" + str(player_id))  # e.g. "move_1" or "move_2"
	##else:
		##anim.play("idle" + str(player_id))  # e.g. "idle_1" or "idle_2"
#func _ready():
#
	#get_node("player"+str(player_id)).visible=false
	#screen_size = get_viewport_rect().size
	#var players = get_tree().get_nodes_in_group("players")
	#for p in players:
		#if p != self:
			#other_player = p
			#break
#
#func _physics_process(_delta):
	#const _PADDING := Vector2(16, 16)
	#var input_vector = Vector2.ZERO
	#var _is_moving = false
	#
	#if Input.is_action_pressed(right_action):
		#input_vector.x += 1
	#if Input.is_action_pressed(left_action):
		#input_vector.x -= 1
	#if Input.is_action_pressed(down_action):
		#input_vector.y += 1
	#if Input.is_action_pressed(up_action):
		#input_vector.y -= 1
#
	#if input_vector != Vector2.ZERO:
		#input_vector = input_vector.normalized()
		#velocity = input_vector * speed
		#
#
#
		## Animation for moving
		#$player1.play("default1")
		#$player2.play("default2")
		#$player1.flip_h = input_vector.x < 0
		#$player2.flip_h = input_vector.x < 0
	#else:
		#velocity = Vector2.ZERO
		#$player1.play("idle1")
		#$player2.play("idle2")
	#move_and_slide()
	#global_position = global_position.clamp(_PADDING, screen_size - _PADDING)
