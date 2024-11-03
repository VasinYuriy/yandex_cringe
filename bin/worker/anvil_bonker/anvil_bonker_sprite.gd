extends AnimatedSprite2D

var current_animation

# Native funcs:
func _ready() -> void:
	self.play("idle")

# Signal handlers:
func _on_animation_looped() -> void:
	if self.animation == "attack":
		self.play("idle")
		pass
