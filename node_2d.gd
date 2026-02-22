extends Node2D

@onready var sound1 = $AudioStreamPlayer2D
@onready var sound2 = $AudioStreamPlayer2D2
@onready var sound3 = $AudioStreamPlayer2D3
@onready var anim = $AnimatedSprite2D
var random = RandomNumberGenerator.new()
var played = false
var timer = 0.0

func _process(delta: float) -> void:
	timer += 1 * delta
	if timer >= 30:
		anim.play()
		if !played:
			var randomint = random.randi_range(1,3)
			if randomint == 1:
				sound1.play()
			elif randomint == 2:
				sound2.play()
			else:
				sound3.play()
			played = true
	else:
		anim.pause()
		anim.frame = 0

func _on_audio_stream_player_2d_finished() -> void:
	timer = 0
	played = false

func _on_audio_stream_player_2d_2_finished() -> void:
	timer = 0
	played = false

func _on_audio_stream_player_2d_3_finished() -> void:
	timer = 0
	played = false
