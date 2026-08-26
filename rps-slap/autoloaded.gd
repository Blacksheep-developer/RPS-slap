extends Node

var current_money: int = 1000
var invested_money: int
var is_win: bool # called in win/loose func in gamemanager
var is_result: bool = false
var is_musik_on: bool = false
var was_playing: bool = false


# ----------- Audio -----------
const MUSIK_TRACK = preload("uid://bndof2o6w4sy2")
var musik_player: AudioStreamPlayer



# ==============================================================================
func _ready() -> void:
	musik_player = AudioStreamPlayer.new()
	musik_player.stream = MUSIK_TRACK
	musik_player.volume_db = -10
	add_child(musik_player)
	musik_player.play()
	was_playing = false

func _process(_delta: float) -> void:
	if not is_result:
		#is_musik_on = true
		musik_player.stream_paused = false
	else:
		musik_player.stream_paused = true
# ==============================================================================
