extends Node3D

enum choice { ROCK, PAPER, SCISSORS}

###############################################################################
func pick_random() -> choice:
	return choice.values().pick_random()
	print(choicekeys()[result])
