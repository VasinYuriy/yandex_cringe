class_name Interface extends Control

signal attack_button_pressed
signal income_button_pressed
signal autodolb_button_pressed

# Signal handlers:
func _on_income_button_pressed() -> void:
	emit_signal("income_button_pressed")
	pass

func _on_autodolb_button_pressed() -> void:
	emit_signal("autodolb_button_pressed")
	pass

func _on_pressed() -> void:
	emit_signal("attack_button_pressed")
	pass
