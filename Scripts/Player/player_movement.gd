extends CharacterBody2D

@export_category("Movement")
@export var _base_walkSpeed := 60.0
@export var _base_runSpeed := 100.0
@export var _base_walkAccelSpeed := 300.0

@export_category("Stamina")
@export var _base_maxStamina := 4.0
@export var _base_staminaRegenMax := 1.0
@export var _base_maxSprintRegenTimeBoost := 2.0

var stamina = _base_maxStamina
var timeSinceRun := 0.0
var staminaEmptied = false
var isRunning = false

func calcMovement(delta : float) -> void:
	var moveAxis = Vector2(Input.get_axis("move_left","move_right"),Input.get_axis("move_up","move_down")).normalized()
	
	isRunning = false
	if Input.is_action_pressed("run"):
		if not staminaEmptied:
			if velocity.length() > _base_runSpeed * 0.5:
				isRunning = true
	
	if isRunning:
		stamina -= delta
		timeSinceRun = 0.0
		if stamina <= 0:
			staminaEmptied = true
			stamina = 0
		velocity = velocity.move_toward(moveAxis * _base_runSpeed, delta * _base_walkAccelSpeed)
	else:
		timeSinceRun += delta
		stamina += _base_staminaRegenMax * min(1.0, timeSinceRun / _base_maxSprintRegenTimeBoost) * delta
		if stamina >= _base_maxStamina:
			stamina = _base_maxStamina
			staminaEmptied = false
		velocity = velocity.move_toward(moveAxis * _base_walkSpeed, delta * _base_walkAccelSpeed)
	if global_position.x <= get_global_mouse_position().x:
		$Sprite.scale.x = 1.0
	else:
		$Sprite.scale.x = -1.0

	calcCollisions()
	
	$UI/ProgressBar.max_value = _base_maxStamina
	$UI/ProgressBar.value = stamina
	if staminaEmptied:
		$UI/ProgressBar.modulate = Color.DARK_RED
	else:
		$UI/ProgressBar.modulate = Color.LIME

func calcCollisions() -> void:
	var prevVelocity = velocity
	var collision = move_and_slide()
	if collision:
		collision = get_last_slide_collision()
		var collObject = collision.get_collider()
		if collObject.is_in_group("Zombie"):
			if isRunning:
				collObject.velocity = prevVelocity.normalized().rotated(deg_to_rad((randf_range(-45,45)))) * 32.0
				collObject.staggerTime = 0.25
