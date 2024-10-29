extends Node2D
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var player_animation: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interface_attack_button_pressed() -> void:
	audio_player.play()
	player_animation.stop()
	player_animation.play("attack")
