extends Node3D

var is_playing = false
var is_waiting = false

@onready var player: Node3D = get_node("../player")
@onready var opponent: Node3D = get_node("../opponent")

func _ready() -> void:
	is_waiting = true
func play():
	is_playing = true
func waiting():
	is_waiting = true
	
