class_name Worker extends Button
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var worker_animation: AnimatedSprite2D = $WorkerSprite
@onready var anvil_animation: AnimatedSprite2D = $WorkerSprite/Anvil/Particles
var main: Main
var income = 1
var income_cost = 10
var income_cost_increase = 10
var income_cost_increase_raise = 10
var autodolb = null
signal selected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func change_income() -> void:
	income += 1
	income_cost += income_cost_increase
	income_cost_increase += income_cost_increase_raise


func attack() -> void:
	audio_player.play()
	worker_animation.stop()
	worker_animation.play("attack")
	anvil_animation.stop()
	anvil_animation.play("hit")
	main.change_money(income)
	

static func create(main: Node2D) -> Worker:
	var instance = preload("res://worker.tscn").instantiate()
	instance.main = main
	return instance


func _on_pressed() -> void:
	main.selected_worker = self
	main.update_interface()
