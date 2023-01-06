extends Node
class_name WorldGenerator

@export var height_noise: Noise
@export var height_min: int = 50
@export var height_max: int = 100

@export var grid_map: GridMap

func _ready():
	for x in range(100):
		for z in range(100):
			generate(x, z)

func generate(x: int, z: int):
	var height = get_height(x, z)
	for y in range(height + 1):
		grid_map.set_cell_item(Vector3i(x, y, z), 0)

func get_height(x: int, z: int):
	var noise_value = height_noise.get_noise_2d(x, z)
	var height = int(height_min + noise_value * (height_max - height_min))
	return height

	

