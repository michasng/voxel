extends GridMap
class_name Chunk


const size: Vector3i = Vector3i(16, 16, 16)


func _init(chunk_position: Vector3i, world_mesh_library: MeshLibrary):
	self.cell_size = Vector3(1, 1, 1)
	self.position = chunk_position * size
	self.name = str(chunk_position)
	self.mesh_library = world_mesh_library

