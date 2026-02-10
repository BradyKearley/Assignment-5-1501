extends Node2D

static var currently_picked_up_block: Node2D = null

var mouseHover: bool = false
var isPickedUp: bool = false
@export var offset: Vector2

func is_overlapping_other_blocks() -> bool:
	var area = $Sprite2D/Area2D
	var overlapping_areas = area.get_overlapping_areas()
	# Check if any overlapping other blocks
	for other_area in overlapping_areas:
		var other_block = other_area.get_parent().get_parent()
		if other_block != self and other_block.is_in_group("Block"):
			return true
	return false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if isPickedUp:
			# Trying to place down - check for overlaps
			if not is_overlapping_other_blocks():
				isPickedUp = false
				currently_picked_up_block = null
				$Heavy.pitch_scale = randf_range(0.9, 1.1)
				$Heavy.play()
		elif mouseHover:
			# Picking up - check if no other block is picked up
			if currently_picked_up_block == null:
				isPickedUp = true
				currently_picked_up_block = self
				$Light.pitch_scale = randf_range(0.9, 1.1)
				$Light.play()

func _process(delta: float) -> void:
	#Deletes blocks off screen
	if global_position.y > 750:
		if isPickedUp:
			currently_picked_up_block = null
		queue_free()
	
	#This code basicaly makes snapping work on all blocks was a huge pain with rotations and everything but it works
	if isPickedUp:
		var rotated_offset = offset.rotated(rotation)
		var addition_offset = Vector2(0, 0)
		if int(rotation_degrees) % 180 == 0:
			addition_offset = Vector2(12, 12)
		global_position = get_global_mouse_position().snapped(Vector2(24, 24)) + rotated_offset + addition_offset
	
	if isPickedUp and Input.is_action_just_pressed("Rotate"):
		rotation += deg_to_rad(90)


func _on_area_2d_mouse_entered() -> void:
	mouseHover = true


func _on_area_2d_mouse_exited() -> void:
	mouseHover = false
