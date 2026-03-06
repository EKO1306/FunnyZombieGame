extends TextureButton

@export var selectorNo := 0

func _pressed() -> void:
	get_parent().get_parent().get_parent().get_parent().selectSlot(selectorNo)
