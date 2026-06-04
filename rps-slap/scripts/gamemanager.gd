extends Node3D

var is_playing = false

@onready var player = $player
@onready var opponent = $opponent

#var player_is_rock
#var player_is_paper
#var player_is_scissor
var player_choice
var opponent_choice
#var opponent_is_rock
#var opponent_is_paper
#var opponent_is_scissor
@onready var rock_button = $hud/Panel/rock
@onready var paper_button = $hud/Panel/paper
@onready var scissor_button = $hud/Panel/scissor
@onready var start_label = $hud/start_label
@onready var draw_label = $hud/draw_label
@onready var win_label = $hud/win_label
@onready var loose_label = $hud/loose_label
@onready var rock_label = $hud/rock_label
@onready var paper_label = $hud/paper_label
@onready var scissor_label = $hud/scissor_label

###############################################################################
func _ready() -> void:
	is_playing = false
	start_label.visible = true
	
	draw_label.visible = false
	win_label.visible = false
	win_label.visible = false
###############################################################################

func play():
	if is_playing:
		return
	is_playing = true
	start_label.visible = false
	
	rock_button.visible = true
	paper_button.visible = true
	scissor_button.visible = true
	
	await get_tree().create_timer(3).timeout
	is_playing = false

func waiting():
	is_playing = false

func compare_choices():
	if player_choice == opponent_choice:
		draw()
	elif (player_choice == 0 and opponent_choice == 2) or (player_choice == 1 and opponent_choice == 0) or (player_choice == 2 and opponent_choice == 1):
		win()
	else:
		loose()

func draw():
	draw_label.visible = true
	await get_tree().create_timer(2).timeout
	draw_label.visible = false
func win():
	win_label.visible = true
	await get_tree().create_timer(2).timeout
	win_label.visible = false
	player.slap()
	
func loose():
	loose_label.visible = true
	await get_tree().create_timer(2).timeout
	loose_label.visible = false
	opponent.slap()

func _on_rock_pressed() -> void:
	#player_is_rock = true
	player_choice = 0
	rock_button.visible = false
	paper_button.visible = false
	scissor_button.visible = false
	opponent_choice = opponent.pick_random()
	countdown()
	await get_tree().create_timer(3).timeout
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
	compare_choices()

func countdown():
	rock_label.visible = true
	await get_tree().create_timer(1).timeout
	rock_label.visible = false
	paper_label.visible = true
	await get_tree().create_timer(1).timeout
	paper_label.visible = false
	scissor_label.visible = true
	await get_tree().create_timer(1).timeout
	scissor_label.visible = false
