extends Node2D

var mouseHover: bool = false
var isPickedUp: bool = false
@export var offset: Vector2

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and mouseHover:
		isPickedUp = !isPickedUp

func _process(delta: float) -> void:
	#Deletes blocks off screen
	if global_position.y > 750:
		queue_free()
	
	#This code basicaly makes snapping work on all blocks was a huge pain with rotations and everything but it works
	if isPickedUp:
		var rotated_offset = offset.rotated(rotation)
		var addition_offset = Vector2(0, 0)
		if int(rotation_degrees) % 180 == 0:
			addition_offset = Vector2(12, 12)
		global_position = get_global_mouse_position().snapped(Vector2(24, 24)) + rotated_offset + addition_offset
	
	if mouseHover and Input.is_action_just_pressed("Rotate"):
		rotation += deg_to_rad(90)


func _on_area_2d_mouse_entered() -> void:
	mouseHover = true


func _on_area_2d_mouse_exited() -> void:
	mouseHover = false
