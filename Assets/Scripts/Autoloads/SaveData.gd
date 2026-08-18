extends Node

signal fruit_spawn(spawner_id)

var FruitAmount: int = 0
var isFruitSpawned: bool = false
var fruit_spawn_id: int = -1


func pick_fruit_spawner() -> void:
	var total_ids := 8
	
	fruit_spawn_id = randi_range(0, total_ids - 1)
	isFruitSpawned = true
	
	fruit_spawn.emit(fruit_spawn_id)
	
	print("Fruit spawned at spawner ID: ", fruit_spawn_id)
