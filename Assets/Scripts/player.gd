extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -300.0

@export var BLUE_JUMP_PAD_BOOST = -800
@export var KNOCKBACK_STRENGTH = 500.0
@export var KNOCKBACK_TIME = 0.2

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var is_knocked_back := false


func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_knocked_back:
		velocity.y = JUMP_VELOCITY

	# Horizontal movement
	if not is_knocked_back:
		var direction := Input.get_axis("left", "right")

		if direction:
			sprite.flip_h = direction < 0
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	# Animations
	if is_knocked_back:
		sprite.play("hurt")
	elif not is_on_floor():
		sprite.play("falling")
	elif Input.get_axis("left", "right"):
		sprite.play("running")
	else:
		sprite.play("Idle")

	move_and_slide()


func knockback(from_position: Vector2, strength: float) -> void:
	var direction := global_position - from_position
	direction = direction.normalized()

	velocity = direction * strength
	is_knocked_back = true

	await get_tree().create_timer(KNOCKBACK_TIME).timeout

	is_knocked_back = false


func _on_jump_pad_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		velocity.y = BLUE_JUMP_PAD_BOOST


func _on_spike_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.knockback(global_position, KNOCKBACK_STRENGTH)
