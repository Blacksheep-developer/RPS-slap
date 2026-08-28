extends CharacterBody3D

# ------- Movement ------------
@export var speed: int = 3

# --------------- References ---------------
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var game: Node3D = get_node("..")
@onready var room: Node3D = $"../room"
const breathing_anim = preload("uid://c622uejyuckmt")


@onready var rock_obg = $Skeleton/BoneAttachment3D2/rock
@onready var paper_obg = $Skeleton/BoneAttachment3D2/paper
@onready var scissor_obg = $Skeleton/BoneAttachment3D2/scissor
enum choice { ROCK, PAPER, SCISSOR}

var is_rotating: bool = false
var is_lerping: bool = false

var target_y: float = 89.5
var rotation_speed: float = 3
var mouse_sensitivity: float = 0.002
var mouse_rotation_enabled: bool = true

var max_health = 3
var current_health

@onready var gamemanager = owner
var play_position: Vector3
var lerp_speed: float = 1

const BLEND_TIME = 0.4



# =================================================================================================
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	current_health = max_health
	room.player_detected.connect(_on_player_detected)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and mouse_rotation_enabled:
		rotate_y(-event.relative.x * mouse_sensitivity)

func _process(delta: float) -> void:
	var input := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input.x,  0, input.y)).normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	#move_and_slide()

	#if Input.is_action_just_pressed("start"):
		#if game.is_playing:
			#return
		#game.play()
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#mouse_rotation_enabled = false
		#rotating = true

	if is_rotating:
		rotation.y = lerp_angle(rotation.y, target_y, rotation_speed * delta)
		if abs(rotation.y - target_y) < 0.01:
			rotation.y = target_y
			is_rotating = false
	if is_lerping:
		global_position = global_position.lerp(play_position, lerp_speed * delta)
		if global_position.distance_to(play_position) < 0.1:
			global_position = play_position
			is_lerping = false

	move_and_slide()
# =================================================================================================



func _on_player_detected(target: Vector3) -> void: # fix player position and rotation
	if game.is_playing:
		return
	play_position = target
	game.play()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_rotation_enabled = false
	speed = 0
	is_rotating = true
	is_lerping = true

func slap():
	anim_player.play("player/slap", BLEND_TIME)
func hit():
	anim_player.play("player/hit", BLEND_TIME)
func idle():
	anim_player.play("player/idle", BLEND_TIME)
func reveal():
	anim_player.play("player/reveal", BLEND_TIME)

func minus_health():
	current_health -= 1

func mouse_capture():
	mouse_rotation_enabled = true
	is_rotating = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

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
