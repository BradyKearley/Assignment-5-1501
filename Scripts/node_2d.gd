extends Node2D

var shapes_done: int = 0
var current_shape: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create the initial shape to create
	create_shape(shapes_done + 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_shape_finished() -> void:
	# Create the next shape to do
	shapes_done += 1
	call_deferred("remove_child", current_shape)
	if shapes_done != 10:
		# If the player is still making shapes
		create_shape(shapes_done + 1)
		# Destroy all blocks in the scene
		for block in get_tree().get_nodes_in_group("Block"):
			block.queue_free()
		# Play victory sound
		$Victory.play()
	else:
		print("Complete")


func create_shape(number: int) -> void:
	# Load the shape
	current_shape = load("res://Scenes/Shapes/shape_" + str(number) + ".tscn").instantiate()
	# Move the shape to the right position
	current_shape.position = Vector2(890, 662)
	# Add the shape to the scene at the front
	call_deferred("add_child", current_shape)
