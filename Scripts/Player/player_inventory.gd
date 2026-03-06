extends "player_movement.gd"

@export var inventorySlots := 3
@export var inventorySelectorColor := Color.YELLOW

@onready var inventoryNode := $UI/InventoryWheel
var currentSlot := -1

func updateInventory(delta : float):
	updateSelection()
	if get_global_mouse_position().distance_to(inventoryNode.global_position) < 64.0:
		inventoryNode.modulate.a = move_toward(inventoryNode.modulate.a, 1.0, delta * 12.0)
	else:
		inventoryNode.modulate.a = move_toward(inventoryNode.modulate.a, 0.0, delta * 4.0)

func updateSelection() -> void:
	var finalSelect
	
	#Mousewheel Select
	if Input.is_action_just_pressed("inventory_prev"):
		finalSelect = currentSlot - 1
		if finalSelect < 0:
			finalSelect += inventorySlots
	if Input.is_action_just_pressed("inventory_next"):
		finalSelect = currentSlot + 1
		if finalSelect >= inventorySlots:
			finalSelect -= inventorySlots
	
	#Number Select
	for i in range(inventorySlots):
		if Input.is_action_pressed("inventory_select_{0}".format([str(i)])):
			finalSelect = i
	if finalSelect != null:
		selectSlot(finalSelect)

func selectSlot(item : int):
	if currentSlot == item:
		return
	currentSlot = item
	inventoryNode.modulate.a = 1.0
	var no := -1
	for i in inventoryNode.get_node("Selectors").get_children():
		no += 1
		if no == item:
			i.modulate = inventorySelectorColor
		else:
			i.modulate = Color.TRANSPARENT
