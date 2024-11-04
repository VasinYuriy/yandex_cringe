class_name Anvil extends Sprite2D

@onready var effects: Node2D = $Effects

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for effect in effects.get_children():
		if effect.is_stopped:
			effects.remove_child(effect)


func add_effect(income) -> void:
	var effect = EarnEffect.create(income)
	effects.add_child(effect)
