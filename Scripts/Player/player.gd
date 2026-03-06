extends "player_inventory.gd"

func _ready() -> void:
	selectSlot(0)

func _physics_process(delta: float) -> void:
	calcMovement(delta)
	updateInventory(delta)
