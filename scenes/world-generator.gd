extends Node
class_name WorldGenerator

@export var base_terrain_height: int = 50
@export var height_noise: FastNoiseLite
@export var height_amplitude: int = 3

@export var world: World


func _ready():
	height_noise.seed = randi()


func generate_chunk(chunk_position: Vector3i) -> Dictionary:
	var items = {} # Dictionary[Vector3i, int]
	for x in range(Chunk.size.x):
		for y in range(Chunk.size.y):
			for z in range(Chunk.size.z):
				var position_in_chunk = Vector3i(x, y, z)
				var world_position = chunk_position * Chunk.size + position_in_chunk
				items[position_in_chunk] = get_block(world_position)
	return items


func get_block(world_position: Vector3i) -> int:
	var height = get_height(world_position.x, world_position.z)
	if world_position.y < height:
		return 0
	return GridMap.INVALID_CELL_ITEM


func get_height(x: int, z: int):
	var height = base_terrain_height + int(height_noise.get_noise_2d(x, z) * height_amplitude)
	return height

