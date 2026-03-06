extends "player_inventory.gd"

func _ready() -> void:
	selectSlot(0)

func _physics_process(delta: float) -> void:
	calcMovement(delta)
	updateInventory(delta)
	if Input.is_action_just_pressed("spawn_zombie"):
		var zombieNode = preload("res://Nodes/zombie.tscn").instantiate()
		zombieNode.global_position = Vector2(-161.0, randf_range(434.0,363.0))
		get_tree().current_scene.add_child(zombieNode)
