extends CharacterBody2D

# Exports
@export var MAX_SPEED := 300
@export var ACCELERATION := 500
@export var FRICTION := 500
# Signals

# State
enum STATE {
	MOVE,
	INTERACT
}
var state : int = STATE.MOVE
var interacting := false
# References
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():

	# --- CONNECT TO SIGNALS ---
	pass

func get_input() -> Vector2:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	return input_direction

func _physics_process(delta: float) -> void:
	match state:
		STATE.MOVE:
			move_state(delta)
		STATE.INTERACT:
			interact_state(delta)
	move_and_slide()

func move_state(delta: float) -> void:
	var input_direction := get_input()
	if input_direction == Vector2.ZERO:
		velocity.x = move_toward(velocity.x, Vector2.ZERO.x, FRICTION * delta)
		velocity.y = move_toward(velocity.y, Vector2.ZERO.y, FRICTION * delta)
		animation_player.play("Idle")
	else:
		animation_player.play("Fly")
		velocity.x = max(move_toward(velocity.x, MAX_SPEED, input_direction.x * ACCELERATION * delta), -MAX_SPEED)
		velocity.y = max(move_toward(velocity.y, MAX_SPEED, input_direction.y * ACCELERATION * delta), -MAX_SPEED)

	# Orientation
	sprite_2d.flip_h = input_direction.x > 0
	var moving_top_right = input_direction.y < 0 and input_direction.x > 0
	var moving_bottom_right = input_direction.y > 0 and input_direction.x > 0
	var moving_top_left = input_direction.y < 0 and input_direction.x < 0
	var moving_bottom_left = input_direction.y > 0 and input_direction.x < 0
	var moving_down = input_direction.x == 0 and input_direction.y > 0
	var moving_up = input_direction.x == 0 and input_direction.y < 0
	if moving_top_right:
		sprite_2d.rotation_degrees = -45
	elif moving_bottom_right:
		sprite_2d.rotation_degrees = 45
	elif moving_top_left:
		sprite_2d.rotation_degrees = 45
	elif moving_bottom_left:
		sprite_2d.rotation_degrees = -45
	elif moving_down:
		sprite_2d.rotation_degrees = -90
	elif moving_up:
		sprite_2d.rotation_degrees = 90
	else:
		sprite_2d.rotation_degrees = 0


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		state = STATE.INTERACT


## --- INTERACT ---
func interact_state(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	if not interacting:
		sprite_2d.rotation_degrees = 0
#		animation_state.travel('Interact')
		interacting = true
		# Slow down
		await get_tree().create_timer(0.45).timeout
		interacting = false
		state = STATE.MOVE

# --- HANDLE SIGNALS ---

