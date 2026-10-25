extends CharacterBody2D

enum {IDLE, WALK, PREP_JUMP, JUMP}

@export var speed = 300.0
@export var short_jump_speed = 400.0
@export var long_jump_speed = 800.0

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
	# Bugged. Sometimes causes the player to be embedded within the platforms.
	#handle_angles()

	move_and_slide()


func handle_jump():
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			state = PREP_JUMP
			$LongJumpTimer.start()
		if Input.is_action_just_released("jump"):
			$LongJumpTimer.stop()
			if state == PREP_JUMP:
				velocity.y += -short_jump_speed
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
			$AnimatedSprite2D.play("default")
			velocity.x = move_toward(velocity.x, 0, speed)


func handle_angles():
	var platform_angle = get_floor_angle() * sign(get_floor_normal().x)

	if platform_angle != 0:
		set_rotation(platform_angle)
		velocity.x += sign(platform_angle) * speed / 2


func _on_long_jump_timer_timeout() -> void:
	if is_on_floor() and state == PREP_JUMP:
		velocity.y += -long_jump_speed
		state = IDLE
