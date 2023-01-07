extends Node
class_name ChunkLoader

@export var world: World
@export var world_generator: WorldGenerator
@export var center_body: Node3D
@export var chunk_load_distance: float = 1


func _ready():
	_unload_chunks()
	_load_chunks()


func _load_chunks():
	var first_chunk = world.to_chunk(center_body.position - chunk_load_distance * Chunk.size)
	var last_chunk = world.to_chunk(center_body.position + chunk_load_distance * Chunk.size)
	print("loading chunks from ", first_chunk, " to ", last_chunk)
	for x in range(first_chunk.x, last_chunk.x + 1):
		for y in range(first_chunk.y, last_chunk.y + 1):
			for z in range(first_chunk.z, last_chunk.z + 1):
				var chunk_position = Vector3i(x, y, z)
				if world.get_chunk(chunk_position):
					continue
				var chunk = world.create_chunk(chunk_position)
				world_generator.generate_chunk(chunk)


func _unload_chunks():
	pass

