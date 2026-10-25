extends Node2D

var player_start_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_start_pos = $Player.position
	$Background.position = player_start_pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	const BACKGROUND_FOLLOW_SPEED = 5
	$Background.position.x = lerp($Background.position.x, $Player.position.x, BACKGROUND_FOLLOW_SPEED * delta)
	$Background.position.y = $Player.position.y


func _on_cd_cd_contact() -> void:
	get_tree().change_scene_to_file("res://scenes/expo1.tscn")
	pass # Replace with function body.

func _on_player_died() -> void:
	get_tree().change_scene_to_file("res://scenes/death.tscn")
