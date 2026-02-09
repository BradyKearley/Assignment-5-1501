extends Node2D

var block_scenes = [
	"res://Scenes/block_1.tscn",
	"res://Scenes/block_2.tscn", 
	"res://Scenes/block_3.tscn",
	"res://Scenes/block_4.tscn",
	"res://Scenes/block_5.tscn",
	"res://Scenes/block_6.tscn",
	"res://Scenes/block_7.tscn"
]

func spawn_random_box():
	var random_index = randi() % block_scenes.size()
	var scene_path = block_scenes[random_index]
	
	var scene = load(scene_path)
	var new_block = scene.instantiate()
	
	get_parent().add_child(new_block)
	new_block.global_position = global_position
	

func _on_timer_timeout() -> void:
	spawn_random_box()
