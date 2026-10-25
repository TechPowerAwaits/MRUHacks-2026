extends AudioStreamPlayer

#consant 
const PLAYER_MIN_X: float = -4.6
const PLAYER_MAX_X: float = 2.8
const ZERO_VOLUME: int = -40


@export var player: Node2D
@export var transition: float 

var xmin: float
var xmax:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_transition(0.1) 

func set_transition(value: float):
	transition = value
	compute_x_bounds()
	
func compute_x_bounds():
	var d = PLAYER_MAX_X - PLAYER_MIN_X
	xmin= PLAYER_MIN_X + (d-d*transition)/2.0
	xmax= PLAYER_MAX_X + (d-d*transition)/2.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float)->void:
	var px = player.position.x
	var r = inverse_lerp(xmin, xmax, px)
	
	stream.set_sync_stream_volume(0,
		min(ZERO_VOLUME +
		r*(-ZERO_VOLUME), 0.0))
		
	stream.set_sync_stream_volume(1,
		min(ZERO_VOLUME +
		(1.0-r)*(-ZERO_VOLUME),0.0))
