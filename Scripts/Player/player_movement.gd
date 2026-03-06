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

func calcMovement(delta : float) -> void:
	var xMove = Input.get_axis("move_left","move_right")
	var yMove = Input.get_axis("move_up","move_down")
	
	var isRunning = false
	if Input.is_action_pressed("run"):
		if not staminaEmptied:
			isRunning = true

	if isRunning:
		stamina -= delta
		timeSinceRun = 0.0
		if stamina <= 0:
			staminaEmptied = true
			stamina = 0
		velocity.x = move_toward(velocity.x, xMove * _base_runSpeed, delta * _base_walkAccelSpeed)
		velocity.y = move_toward(velocity.y, yMove * _base_runSpeed, delta * _base_walkAccelSpeed)
	else:
		timeSinceRun += delta
		stamina += _base_staminaRegenMax * min(1.0, timeSinceRun / _base_maxSprintRegenTimeBoost) * delta
		if stamina >= _base_maxStamina:
			stamina = _base_maxStamina
			staminaEmptied = false
		velocity.x = move_toward(velocity.x, xMove * _base_walkSpeed, delta * _base_walkAccelSpeed)
		velocity.y = move_toward(velocity.y, yMove * _base_walkSpeed, delta * _base_walkAccelSpeed)
	if global_position.x <= get_global_mouse_position().x:
		$Sprite.scale.x = 1.0
	else:
		$Sprite.scale.x = -1.0

	move_and_slide()
	
	$UI/ProgressBar.max_value = _base_maxStamina
	$UI/ProgressBar.value = stamina
	if staminaEmptied:
		$UI/ProgressBar.modulate = Color.DARK_RED
	else:
		$UI/ProgressBar.modulate = Color.LIME
