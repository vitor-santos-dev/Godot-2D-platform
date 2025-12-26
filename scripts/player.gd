extends CharacterBody2D

@onready var player_sprites: AnimatedSprite2D = $"player-sprites"

const SPEED = 30.0
const JUMP_VELOCITY = -300.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if is_on_floor():
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
	else:
		if direction == -1:
			velocity.x = direction * SPEED
			player_sprites.flip_h = true
			player_sprites.play("walk")
		elif direction == 1:
			velocity.x = direction * SPEED
			player_sprites.flip_h = false
			player_sprites.play("walk")
		player_sprites.play("jump")

	move_and_slide()
