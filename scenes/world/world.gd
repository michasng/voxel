extends GridMap
class_name World


var chunks: Dictionary = {} # Dictionary[Vector3i, Chunk]


func place_chunk_items(chunk_position: Vector3i, items: Dictionary):
	var world_position = chunk_position * Chunk.size
	for position_in_chunk in items:
		set_cell_item(world_position + position_in_chunk, items[position_in_chunk])
	print("placed chunk items: ", chunk_position)


func get_chunk(chunk_position: Vector3i) -> Chunk:
	return chunks[chunk_position]


func to_chunk(world_position: Vector3) -> Vector3i:
	return Vector3i(
		floori(world_position.x / Chunk.size.x),
		floori(world_position.y / Chunk.size.y),
		floori(world_position.z / Chunk.size.z)
	)

