extends CharacterBody2D

const RUN_SPEED = 160
const JUMP_VELOCITY = -300

var gravity = ProjectSettings.get("physics/2d/default_gravity") as float
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var isDoubleJump = true


func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	var dir = Input.get_axis("move_left", "move_right")
	if (is_on_floor() or isDoubleJump) and Input.is_action_just_pressed("jump"):
		jump()
	
	if Input.is_action_just_released("jump") and velocity.y < JUMP_VELOCITY / 2:
		velocity.y = JUMP_VELOCITY / 2
	
	if is_on_floor():
		isDoubleJump = true
		if is_zero_approx(dir):
			idle()
		else: 
			running()
	
	if not is_zero_approx(dir):
		sprite_2d.flip_h = dir < 0
		
	
	if Input.is_action_just_pressed("attack"):
		attack()
	
	move_and_slide()

func jump():
	velocity.y = JUMP_VELOCITY
	animation_player.play("jump")
	if isDoubleJump:
		isDoubleJump = false
		
func running():
	var dir = Input.get_axis("move_left", "move_right")
	velocity.x = dir * RUN_SPEED
	animation_player.play("running")
	
func idle():
	animation_player.play("idle")

func attack():
	animation_player.play("attack1")
	
	
	
