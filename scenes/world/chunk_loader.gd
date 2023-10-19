extends Node
class_name ChunkLoader

@export var world: World
@export var world_generator: WorldGenerator
@export var center_body: Node3D
@export var chunk_load_distance: float = 1

var thread: Thread = Thread.new()
var semaphore: Semaphore = Semaphore.new()
var chunks_to_load: Array[Vector3i] = []
var chunks_to_place: Array[Vector3i] = []
var mutex: Mutex = Mutex.new()
var exit_thread: bool = false


var shape: Shape3D

func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", _chunk_loader_update)
	timer.start(0.1)
	thread.start(_generate_chunks_loop)


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
			world.chunks[chunk_position] = Chunk.new(chunk_position, items)
		chunks_to_place.append_array(chunks_to_load)
		chunks_to_load.clear()
		mutex.unlock()


func _chunk_loader_update():
	if not chunks_to_place.is_empty():
		world.place_chunk_at(chunks_to_place.back())
		chunks_to_place.remove_at(chunks_to_place.size() - 1)
	_find_chunks_to_load()
	if not chunks_to_load.is_empty():
		semaphore.post()


func _find_chunks_to_load():
	var first_chunk = world.to_chunk(center_body.position - chunk_load_distance * Chunk.size)
	var last_chunk = world.to_chunk(center_body.position + chunk_load_distance * Chunk.size)
	mutex.lock()
	for x in range(first_chunk.x, last_chunk.x + 1):
		for y in range(first_chunk.y, last_chunk.y + 1):
			for z in range(first_chunk.z, last_chunk.z + 1):
				var chunk_position = Vector3i(x, y, z)
				if chunk_position in world.chunks or chunk_position in chunks_to_load:
					continue
				chunks_to_load.append(chunk_position)
	mutex.unlock()


func _unload_chunks():
	pass


func _exit_tree():
	mutex.lock()
	exit_thread = true
	mutex.unlock()
	semaphore.post()
	thread.wait_to_finish()

