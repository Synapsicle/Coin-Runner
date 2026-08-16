extends Area2D

@export var id: int

@onready var fruit_sprite = $"Fruit sprite"

var fruit_sprites = [
	preload("res://Assets/Art/Fruit/bananas.png"),
	preload("res://Assets/Art/Fruit/blackberry.png"),
	preload("res://Assets/Art/Fruit/grapes.png"),
	preload("res://Assets/Art/Fruit/orange.png"),
	preload("res://Assets/Art/Fruit/pinapple.png"),
	preload("res://Assets/Art/Fruit/strawberry.png")
]


func _ready() -> void:
	SaveData.fruit_spawn.connect(spawn_fruit)


func spawn_fruit(spawner_id: int) -> void:
	if spawner_id != id:
		return
	
	fruit_sprite.texture = fruit_sprites[randi_range(0, fruit_sprites.size() - 1)]
	
	SaveData.isFruitSpawned = true
	
	print("Spawner ", id, " has a fruit")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and fruit_sprite.texture != null:
		SaveData.FruitAmount += 1
		
		fruit_sprite.texture = null
		SaveData.isFruitSpawned = false
