extends Node2D

signal finished_shape

var blocks_in_shape: int = 0
@export var shape_progress: float = 0
var progress_bar: ProgressBar
var areas

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get the scene node and link the finished shape signal
	var node: Node2D = get_node("/root/Node2D")
	finished_shape.connect(node._on_shape_finished)
	areas = $Sprite2D.get_children()
	call_deferred("get_progress_bar")

func get_progress_bar() -> void:
	progress_bar = get_tree().get_first_node_in_group("Progress")
	if !progress_bar:
		call_deferred("get_progress_bar")


func update_correct_blocks(area: Area2D) -> void:
	# Update the number of correct blocks in the shape
	blocks_in_shape = 0
	for check_area: Area2D in areas:
		# Ensure this area does not have multiple blocks overlapping it
		var overlapping_areas = check_area.get_overlapping_areas()
		if overlapping_areas.size() == 1:
			# Ensure the overlapping blocks are not in the incorrect area
			var is_valid: bool = true
			for overlap_area in overlapping_areas:
				if overlap_area.overlaps_area($IncorrectArea2D):
					is_valid = false
					break
			if is_valid:
				blocks_in_shape += 1;

	# Check if the shape is filled
	shape_progress = float(blocks_in_shape) / float(areas.size()) * 100
	if blocks_in_shape == areas.size():
		# If 10 blocks are in the shape emit the finished shape signal
		shape_progress = 0
		finished_shape.emit()
	progress_bar.update_progress()
