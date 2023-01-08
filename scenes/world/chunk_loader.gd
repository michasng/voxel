extends Node
class_name ChunkLoader

@export var world: World
@export var world_generator: WorldGenerator
@export var center_body: Node3D
@export var chunk_load_distance: float = 1

var thread: Thread = Thread.new()
var semaphore: Semaphore = Semaphore.new()
var chunks_to_load: Array[Vector3i] = Array()
var loaded_chunks: Dictionary = {} # Dictionary[Vector3i, bool]
var mutex: Mutex = Mutex.new()
var exit_thread: bool = false


func _ready():
	thread.start(_generate_chunks_loop)


func _process(_delta):
	_find_chunks_to_load()


func _generate_chunks_loop():
	while(true):
		semaphore.wait()
		mutex.lock()
		if exit_thread:
			mutex.unlock()
			break
		for chunk_position in chunks_to_load:
			var items = world_generator.generate_chunk(chunk_position)
			# GridMap creation and access is not thread safe
			# https://github.com/godotengine/godot/issues/42917 and 68597
			world.call_deferred("create_chunk", chunk_position, items)
			loaded_chunks[chunk_position] = true
		chunks_to_load.clear()
		mutex.unlock()


func _find_chunks_to_load():
	var first_chunk = world.to_chunk(center_body.position - chunk_load_distance * Chunk.size)
	var last_chunk = world.to_chunk(center_body.position + chunk_load_distance * Chunk.size)
	mutex.lock()
	for x in range(first_chunk.x, last_chunk.x + 1):
		for y in range(first_chunk.y, last_chunk.y + 1):
			for z in range(first_chunk.z, last_chunk.z + 1):
				var chunk_position = Vector3i(x, y, z)
				if chunk_position in loaded_chunks or chunk_position in chunks_to_load:
					continue
				chunks_to_load.append(chunk_position)
	if not chunks_to_load.is_empty():
		semaphore.post()
	mutex.unlock()


func _unload_chunks():
	pass


func _exit_tree():
	mutex.lock()
	exit_thread = true
	mutex.unlock()
	semaphore.post()
	thread.wait_to_finish()

