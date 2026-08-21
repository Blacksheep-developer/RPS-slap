extends Control

@onready var title: Label = $Title
@onready var results: Label = $Results



# ===================================================================================================
func _ready() -> void:
	if Autoloaded.is_win:
		win()
	else:
		loose()
# ===================================================================================================



func win():
	title.modulate = Color.GREEN
	title.text = "Congratulation"
	results.text = "You won " + str(Autoloaded.invested_money * 2) + " €"
	await get_tree().create_timer(5).timeout
	Autoloaded.invested_money = 0
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")
	
func loose():
	title.modulate = Color.RED
	title.text = "GameOver"
	results.text = "You lost " + str(Autoloaded.invested_money) + " €"
	await get_tree().create_timer(5).timeout
	Autoloaded.invested_money = 0
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")
