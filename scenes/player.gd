extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const WALK_TO_IDLE_FRAME = 2

enum {IDLE, WALK, JUMP}

@onready var state = IDLE


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		state = WALK
		$AnimatedSprite2D.play("walking")
		velocity.x = direction * SPEED
	else:
		state = IDLE
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_animated_sprite_2d_frame_changed() -> void:
	if state == IDLE:
		if ($AnimatedSprite2D.animation == "walking" and
			$AnimatedSprite2D.frame == WALK_TO_IDLE_FRAME):
				$AnimatedSprite2D.play("default")
