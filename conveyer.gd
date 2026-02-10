extends Area2D

@export var direction: Vector2 = Vector2.RIGHT 
@export var speed: float = 100.0

func _physics_process(delta: float) -> void:
	for area in get_overlapping_areas():
		#Gets area but we want to move the node
		var block_root = area.get_parent().get_parent()
		if block_root and block_root.is_in_group("Block"):
			block_root.global_position += direction.normalized() * speed * delta
