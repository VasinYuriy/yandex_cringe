extends AnimatedSprite2D
var current_animation


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass



func _on_animation_looped() -> void:
	if self.animation == "attack":
		self.play("idle")
