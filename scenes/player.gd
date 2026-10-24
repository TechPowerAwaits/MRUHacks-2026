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
	
	handle_jump()
	handle_move()

	move_and_slide()


func handle_jump():
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			state = PREP_JUMP
			$LongJumpTimer.start()
		if Input.is_action_just_released("jump"):
			$LongJumpTimer.stop()
			if state == PREP_JUMP:
				velocity.y = -short_jump_speed
				state = IDLE


func handle_move():
	if state != PREP_JUMP:
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			state = WALK
			$AnimatedSprite2D.flip_h = (direction < 0)
			$AnimatedSprite2D.play("walking")
			velocity.x = direction * speed
		else:
			state = IDLE
			velocity.x = move_toward(velocity.x, 0, speed)



func _on_animated_sprite_2d_frame_changed() -> void:
	if state == IDLE:
		if ($AnimatedSprite2D.animation == "walking" and
			$AnimatedSprite2D.frame == WALK_TO_IDLE_FRAME):
				$AnimatedSprite2D.play("default")


func _on_long_jump_timer_timeout() -> void:
	if is_on_floor() and state == PREP_JUMP:
		velocity.y = -long_jump_speed
		state = IDLE
