extends CharacterBody2D

@export var speed = 300.0
@export var short_jump_speed = 500.0
## The short_jump_speed is added to this speed.
@export var long_jump_speed = 400.0

@onready var jumping = false

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
	
	var collision = get_last_slide_collision()
	if collision:
		handle_special_properties(collision.get_collider())


func handle_jump():
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			jumping = true
			velocity.y += -short_jump_speed
			await get_tree().create_timer(0.3, true, true).timeout
			if Input.is_action_pressed("jump"):
				velocity.y += -long_jump_speed
	else:
		jumping = false


func handle_move():
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		$AnimatedSprite2D.flip_h = (direction < 0)
		$AnimatedSprite2D.play("walking")
		velocity.x = direction * speed
	else:
		$AnimatedSprite2D.play("default")
		velocity.x = move_toward(velocity.x, 0, speed)


func handle_special_properties(obj: Object):
	if obj.get_meta("Slippery", false):
		handle_slippery_slope()


func handle_slippery_slope():
	var facing_right = not $AnimatedSprite2D.flip_h
	velocity.x = (speed / 2) * (-1 if facing_right else 1)
	move_and_slide()
