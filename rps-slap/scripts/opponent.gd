extends Node3D
@onready var anim_player: AnimationPlayer = $AnimationPlayer
enum choice { ROCK, PAPER, SCISSOR}
var current_choice: choice

@onready var rock_obg = $mannequin/Skeleton3D/BoneAttachment3D/rock
@onready var paper_obg = $mannequin/Skeleton3D/BoneAttachment3D/paper
@onready var scissor_obg = $mannequin/Skeleton3D/BoneAttachment3D/scissor

@onready var gamemanager = owner

var max_health = 3
var current_health



# ==============================================================================
func _ready() -> void:
	randomize()
	current_health = max_health
# ==============================================================================



func pick_random() -> choice:
	current_choice = choice.values().pick_random()
	print(choice.keys()[current_choice])
	return current_choice

func slap():
	anim_player.play("anim/anim_right_hook")

func hit():
	anim_player.play("anim/anim_kick_to_the_groin")

func minus_health():
	current_health -= 1
	#if current_health <= 0:
		#gamemanager.back_to_menu()

func show_rock():
	rock_obg.visible = true
func show_paper():
	paper_obg.visible = true
func show_scissor():
	scissor_obg.visible = true

func hide_obj():
	rock_obg.visible = false
	paper_obg.visible = false
	scissor_obg.visible = false
