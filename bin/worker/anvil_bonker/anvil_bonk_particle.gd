extends AnimatedSprite2D

# Native funcs:
func _ready() -> void:
	set_frame_and_progress(0, 0)
	pass

# Signal handlers:
func _on_animation_looped() -> void:
	stop()
	pass
