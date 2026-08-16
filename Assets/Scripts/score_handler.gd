extends Label




func _process(delta: float) -> void:
	text="Fruits collected: "+str(SaveData.FruitAmount)
