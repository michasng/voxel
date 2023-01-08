extends Node
class_name World

@export var mesh_library: MeshLibrary


var chunk_resource = preload("res://scenes/world/chunk.gd")


func create_chunk(chunk_position: Vector3i, items: Dictionary) -> Chunk:
	var chunk = chunk_resource.new(chunk_position, mesh_library)
	for position_in_chunk in items:
		chunk.set_cell_item(position_in_chunk, items[position_in_chunk])
	add_child(chunk)
	print("created chunk: ", chunk.name)
	return chunk


func get_chunk(chunk_position: Vector3i) -> Chunk:
	return get_node_or_null(str(chunk_position))


func set_cell_item(world_position: Vector3i, item: int):
	var chunk_position = to_chunk(world_position)
	var chunk = get_chunk(chunk_position)
	if not chunk:
		return
	var position_in_chunk = world_position - (chunk_position * Chunk.size)
	chunk.set_cell_item(position_in_chunk, item)


func to_chunk(world_position: Vector3) -> Vector3i:
	return Vector3i(
		floori(world_position.x / Chunk.size.x),
		floori(world_position.y / Chunk.size.y),
		floori(world_position.z / Chunk.size.z)
	)

