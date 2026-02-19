extends Label
var time = 0
func _on_timer_timeout() -> void:
	time+=1
	text = "Time: " + str(time)
