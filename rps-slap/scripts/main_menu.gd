extends Control

@onready var spinbox_input: SpinBox = $Control/Panel/SpinBox
@onready var money_label: Label = $Panel/MoneyLabel
var is_pressed: bool = false
const CASH_REGISTERER_TRACK = preload("uid://iupaw6t6pvw6")
var audio_stream_player: AudioStreamPlayer




# ==============================================================================
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	update_money()
	audio_stream_player = AudioStreamPlayer.new()
	audio_stream_player.stream = CASH_REGISTERER_TRACK
	audio_stream_player.volume_db = -10
	add_child(audio_stream_player)
	if Autoloaded.was_playing:
		audio_stream_player.play()
# ==============================================================================



func _on_play_pressed() -> void:
	if is_pressed:
		return
	audio_stream_player.play()
	is_pressed = true
	Autoloaded.invested_money = int(spinbox_input.value)
	Autoloaded.current_money -= Autoloaded.invested_money
	update_money()
	Autoloaded.was_playing = false
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scene/game.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func update_money():
	money_label.text = "€   " + str(Autoloaded.current_money)
