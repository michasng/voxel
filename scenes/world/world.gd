extends GridMap
class_name World


var chunks: Dictionary = {} # Dictionary[Vector3i, Chunk]


func place_chunk_at(chunk_position: Vector3i):
	var chunk = chunks[chunk_position]
	var world_position = chunk.position * Chunk.size
	for position_in_chunk in chunk.items:
		set_cell_item(world_position + position_in_chunk, chunk.items[position_in_chunk])
	print("placed chunk: ", chunk.position)


func get_chunk(chunk_position: Vector3i) -> Chunk:
	return chunks[chunk_position]


func to_chunk(world_position: Vector3) -> Vector3i:
	return Vector3i(
		floori(world_position.x / Chunk.size.x),
		floori(world_position.y / Chunk.size.y),
		floori(world_position.z / Chunk.size.z)
	)

