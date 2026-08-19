extends Node3D

# ----------- Bool -------------
var is_playing = false

#var player_is_rock
#var player_is_paper
#var player_is_scissor
var player_choice
var opponent_choice
#var opponent_is_rock
#var opponent_is_paper
#var opponent_is_scissor

# ----------- Reference -----------
@onready var player = $player
@onready var opponent = $opponent
@onready var rock_button = $hud/Panel/rock # ------------ Buttons
@onready var paper_button = $hud/Panel/paper
@onready var scissor_button = $hud/Panel/scissor
@onready var label: Label = $hud/Label # ------------ LABELS
@onready var label_result: Label = $hud/LabelResult
@onready var result_panel: Panel = $hud/ResultPanel

#@onready var draw_label = $hud/draw_label
#@onready var win_label = $hud/win_label
#@onready var loose_label = $hud/loose_label
#@onready var rock_label = $hud/rock_label
#@onready var paper_label = $hud/paper_label
#@onready var scissor_label = $hud/scissor_label

#@onready var match_win_label = $hud/match_win
#@onready var match_loose_label = $hud/match_loose



@onready var hearts: Array[Node] = [
	$hud/HBoxContainer/heart1,
	$hud/HBoxContainer/heart2,
	$hud/HBoxContainer/heart3
]



# ===============================================================================
func _ready() -> void:
	waiting()
	update_hearts(player.max_health)
	#draw_label.visible = false
	#win_label.visible = false
	#loose_label.visible = false
	
# ===============================================================================



func play():
	if is_playing:
		return
	is_playing = true
	#start_label.visible = false
	label.text = ""
	label_result.text = ""
	
	rock_button.visible = true
	paper_button.visible = true
	scissor_button.visible = true
	result_panel.visible = false

func waiting():
	is_playing = false
	#start_label.visible = true
	label.text = "press [SPACE]"
	label_result.text = ""
	player.mouse_capture()
	player.anim_player.play("anim/anim_breathing_idle")

func compare_choices():
	if player_choice == opponent_choice:
		draw()
	elif (player_choice == 0 and opponent_choice == 2) or (player_choice == 1 and opponent_choice == 0) or (player_choice == 2 and opponent_choice == 1):
		win()
	else:
		loose()

func show_obj():
	if opponent_choice == 0:
		opponent.show_rock()
	if opponent_choice == 1:
		opponent.show_paper()
	if opponent_choice == 2:
		opponent.show_scissor()
func draw():
	#draw_label.visible = true
	label_result.modulate = Color.GRAY
	label_result.text = "DRAW"
	await get_tree().create_timer(2).timeout
	#draw_label.visible = false
	label_result.text = ""
	player.hide_obj()
	opponent.hide_obj()
	waiting()

func win():
	#win_label.visible = true
	label_result.modulate = Color.AQUAMARINE
	label_result.text = "WIN"
	await get_tree().create_timer(2).timeout
	#win_label.visible = false
	label_result.text = ""
	player.slap()
	await get_tree().create_timer(0.2).timeout
	opponent.hit()
	await get_tree().create_timer(3.1).timeout
	opponent.minus_health()
	if opponent.current_health > 0:
		player.hide_obj()
		opponent.hide_obj()
		waiting()
	else:
		label_result.modulate = Color.GREEN
		label_result.text = "Congratulation"
		await get_tree().create_timer(5).timeout
		back_to_menu()

func loose():
	#loose_label.visible = true
	label_result.modulate = Color.LIGHT_CORAL
	label_result.text = "LOOSE"
	await get_tree().create_timer(2).timeout
	#loose_label.visible = false
	label_result.text = ""
	opponent.slap() # ------------Slap animation
	await get_tree().create_timer(0.2).timeout
	player.hit() # -------------Hurt animation
	await get_tree().create_timer(3.1).timeout
	player.minus_health() # -------take damage
	update_hearts(player.current_health) # ---------UI hearts
	if player.current_health > 0:
		player.hide_obj()
		opponent.hide_obj()
		waiting()
	else:
		label_result.modulate = Color.RED
		label_result.text = "GameOver"
		await get_tree().create_timer(5).timeout
		back_to_menu()
	
func update_hearts(health: int):                                                                                 
	for i in range(3):                                                                               
		hearts[i].visible = i < health

func _on_rock_pressed() -> void:
	#player_is_rock = true
	player_choice = 0
	rock_button.visible = false
	paper_button.visible = false
	scissor_button.visible = false
	
	opponent_choice = opponent.pick_random()
	countdown()
	await get_tree().create_timer(3).timeout
	player.show_rock()
	show_obj()
	
	player.anim_player.play("anim/anim_talking")
	opponent.anim_player.play("anim/anim_talking")
	await get_tree().create_timer(1).timeout
	compare_choices()

func _on_paper_pressed() -> void:
	#player_is_paper = true
	player_choice = 1
	rock_button.visible = false
	paper_button.visible = false
	scissor_button.visible = false
	
	opponent_choice = opponent.pick_random()
	countdown()
	await get_tree().create_timer(3).timeout
	player.show_paper()
	show_obj()
	
	player.anim_player.play("anim/anim_talking")
	opponent.anim_player.play("anim/anim_talking")
	await get_tree().create_timer(1).timeout
	compare_choices()

func _on_scissor_pressed() -> void:
	#player_is_scissor = true
	player_choice = 2
	rock_button.visible = false
	paper_button.visible = false
	scissor_button.visible = false
	
	opponent_choice = opponent.pick_random()
	countdown()
	await get_tree().create_timer(3).timeout
	player.show_scissor()
	show_obj()
	
	player.anim_player.play("anim/anim_talking")
	opponent.anim_player.play("anim/anim_talking")
	await get_tree().create_timer(1).timeout
	compare_choices()

func countdown():
	#rock_label.visible = true
	label.text = "rock"
	await get_tree().create_timer(1).timeout
	#rock_label.visible = false
	label.text = "paper"
	#paper_label.visible = true
	await get_tree().create_timer(1).timeout
	#paper_label.visible = false
	label.text = "scissor"
	#scissor_label.visible = true
	await get_tree().create_timer(1).timeout
	#scissor_label.visible = false
	label.text = ""

func results():
	label.text = "str"

func back_to_menu():
	get_tree().change_scene_to_file("res://scene/main_menu.tscn")
