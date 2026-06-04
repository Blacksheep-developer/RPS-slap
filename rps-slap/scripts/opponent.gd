extends Node3D

enum choice { ROCK, PAPER, SCISSOR}
var current_choice: choice

###############################################################################
func _ready() -> void:
	randomize()

func pick_random() -> choice:
	current_choice = choice.values().pick_random()
	print(choice.keys()[current_choice])
	return current_choice

func slap():
	pass
	#anim_player.play("slap")
