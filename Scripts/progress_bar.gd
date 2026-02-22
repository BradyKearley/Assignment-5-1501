extends ProgressBar

var current_shape: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("get_shape")


func get_shape() -> void:
	# Get the current shape
	current_shape = get_tree().get_first_node_in_group("Shape")
	if !current_shape:
		call_deferred("get_shape")


func update_progress() -> void:
	# Update progress
	value = current_shape.shape_progress
