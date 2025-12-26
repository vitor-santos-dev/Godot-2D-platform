extends CharacterBody2D

@onready var player_sprites: AnimatedSprite2D = $"player-sprites"

const SPEED = 30.0
const JUMP_VELOCITY = -300.0

# Called when the node enters the scene tree for the first time.
func _horizontal_movements() -> void:
	 
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		velocity.x = direction * SPEED
		player_sprites.flip_h = true
		player_sprites.play("walk")
	elif direction == 1:
		velocity.x = direction * SPEED
		player_sprites.flip_h = false
		player_sprites.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		player_sprites.play("idle")
	
	move_and_slide()
	
func _jump(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	move_and_slide()
