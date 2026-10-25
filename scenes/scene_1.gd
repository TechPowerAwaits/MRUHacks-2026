extends Node2D


var player_start_pos: Vector2
var resetting: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_start_pos = $Player.position
	$Background.position = player_start_pos
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		resetting = true;
	
	if resetting:
		$Background.position = lerp($Background.position, player_start_pos, 10 * delta)
		$Player.position = lerp($Plaayer.position, player_start_pos, 10 * delta)
		if abs($Background.position.x - player_start_pos.x) < 10:
			resetting = false
		else:
			return
	
	const BACKGROUND_FOLLOW_SPEED = 5
	$Background.position.x = lerp($Background.position.x, $Player.position.x, BACKGROUND_FOLLOW_SPEED * delta)
	$Background.position.y = $Player.position.y
	pass

	
