extends CharacterBody2D

const WALK_TO_IDLE_FRAME = 2

enum {IDLE, WALK, PREP_JUMP, JUMP}

@export var speed = 300.0
@export var short_jump_speed = 400.0
@export var long_jump_speed = 800.0
@export var long_jump_activation_time = 1

@onready var state = IDLE

func _ready():
	# There is supposed to be a property that allows you to autoplay an animation.
	# I do not see it in the inspector, so here is this hack.
	$AnimatedSprite2D.play("default")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			state = PREP_JUMP
			await get_tree().create_timer(long_jump_activation_time, true, true)
			if state == PREP_JUMP:
				velocity.y = -long_jump_speed
		if Input.is_action_just_released("jump"):
			if state == PREP_JUMP:
				velocity.y = -short_jump_speed
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -short_jump_speed

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		state = WALK
		$AnimatedSprite2D.play("walking")
		velocity.x = direction * speed
	else:
		state = IDLE
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func _on_animated_sprite_2d_frame_changed() -> void:
	if state == IDLE:
		if ($AnimatedSprite2D.animation == "walking" and
			$AnimatedSprite2D.frame == WALK_TO_IDLE_FRAME):
				$AnimatedSprite2D.play("default")
