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
	
	var total_dist = $CD.position.x - player_start_pos.x
	var player_dist = $Player.position.x - player_start_pos.x
	var progress = player_dist / total_dist

	if progress < 1.0 / 3.0:
		pass
	if !$MusicAudio.is_playing() && progress > 0.5:
		$MusicAudio.play()
	
	$MusicAudio.volume_db = linear_to_db(progress)
	$StaticAudio.volume_db = linear_to_db(1-progress)
		
	
	#progress
	


func _on_cd_cd_contact() -> void:
	get_tree().change_scene_to_file("res://scenes/expo1.tscn")
	pass # Replace with function body.

func _on_player_died() -> void:
	get_tree().change_scene_to_file("res://scenes/death.tscn")
