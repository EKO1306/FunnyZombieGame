extends CharacterBody2D

@onready var playerNode = get_tree().current_scene.get_node("Player")

@onready var navAgentNode = $NavigationAgent2D

var targetPos : Vector2
var agentRefreshTimer : float
var agentRefreshMaxTimer := 0.5
@export var _base_speed = 20.0
@export var _accel_speed = 60.0
var staggerTime = 0.0

func _ready() -> void:
	agentRefreshTimer = randf_range(0.0,agentRefreshMaxTimer)

func _physics_process(delta: float) -> void:
	move(delta)
	
func move(delta):
	if staggerTime > 0.0:
		staggerTime -= delta
		modulate = Color.WHITE.darkened(0.25)
		move_and_slide()
		return
	modulate = Color.WHITE
	agentRefreshTimer -= delta
	if agentRefreshTimer <= 0:
		agentRefreshTimer += agentRefreshMaxTimer
		updateNavAgentPath()
	velocity = velocity.move_toward(global_position.direction_to(targetPos) * _base_speed, delta * _accel_speed)
	if playerNode.global_position <= global_position:
		$Sprite.scale.x = -1.0
	else:
		$Sprite.scale.x = 1.0
	move_and_slide()

func updateNavAgentPath() -> void:
	navAgentNode.target_position = playerNode.global_position
	agentRefreshTimer += agentRefreshMaxTimer
	targetPos = navAgentNode.get_next_path_position()
