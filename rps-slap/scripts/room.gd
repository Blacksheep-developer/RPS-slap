extends Node3D

signal player_detected(play_position: Vector3)
@onready var play_position: Marker3D = $PlayPosition

func _on_play_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player_detected.emit(play_position.global_position) # lerp towards play position  
