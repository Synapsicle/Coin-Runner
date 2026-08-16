extends Node2D


func _physics_process(delta: float) -> void:
	if not SaveData.isFruitSpawned:
		SaveData.pick_fruit_spawner()
