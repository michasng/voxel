extends Object
class_name Chunk


const size: Vector3i = Vector3i(16, 16, 16)

var position: Vector3i
var items: Dictionary # Dictionary[Vector3i, int]


func _init(chunk_position: Vector3i, chunk_items: Dictionary):
	self.position = chunk_position
	self.items = chunk_items

