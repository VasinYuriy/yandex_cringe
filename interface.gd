extends Control
signal attack_button_pressed
signal income_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_attack_button_pressed() -> void:
	self.emit_signal("attack_button_pressed")


func _on_income_button_pressed() -> void:
	self.emit_signal("income_button_pressed")