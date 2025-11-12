extends CharacterBody2D

@export var speed := 120.0
@export var jump_force := 350.0
@export var gravity := 900.0

@onready var sprite: AnimatedSprite2D =  $AnimatedSprite2D
var jumping := false
var jump_count := 0
const MAX_JUMPS := 2
func _ready() -> void:
	# Force grounded animation on start
	sprite.animation = "idle"
	sprite.play()
	self.add_to_group("Player")

func _physics_process(delta: float) -> void:
	var dir : float = Input.get_axis("left","right")
	# Horizontal
	self.velocity.x = dir * speed
	# Jump (double jump)
	if Input.is_action_just_pressed("jump") and jump_count < MAX_JUMPS:
		jumping=true
		self.velocity.y = -jump_force
		jump_count += 1
		sprite.animation = "jump"; sprite.play()

	# Move & check floor
	if self.is_on_floor():
		jump_count = 0
	else:
		self.velocity.y += gravity * delta # Grav
	handleAnimations()
	self.move_and_slide()

func handleAnimations() -> void:
	if velocity.x > 0.0:
		sprite.flip_h = true
	elif velocity.x < 0.0:
		sprite.flip_h = false
	# Animations
	var animToPlay : String = ""
	if !self.is_on_floor() and jumping:
		if sprite.animation != "jump":
			animToPlay = "jump"; 
	elif velocity.x != 0.0:
			animToPlay = "walking"
	else:
			animToPlay = "idle";
	if sprite.animation != animToPlay:
		sprite.play(animToPlay)
