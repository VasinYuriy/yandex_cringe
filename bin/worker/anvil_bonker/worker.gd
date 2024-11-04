class_name Worker extends Button

const NODE_NAME_FORMAT = "ENTITY_WORKER_%d"

@onready var audio_player: AudioStreamPlayer = $BonkSound
@onready var worker_animation: AnimatedSprite2D = $WorkerSprite
@onready var anvil_animation: AnimatedSprite2D = $WorkerSprite/Anvil/BonkParticles
@onready var earn_animation: AnimationPlayer = $WorkerSprite/Anvil/AnimationPlayer
@onready var anvil: Anvil = $WorkerSprite/Anvil

var main: Main
var income = 1
var income_cost = 10
var income_cost_increase = 10
var income_cost_increase_raise = 10
var auto_bonk

# Static funcs
static var _next_id = 0
static func _get_node_name() -> String:
	var result = NODE_NAME_FORMAT%[_next_id]
	_next_id += 1
	return result
	
static func create(main: Node2D, pos: Vector2, scale: float) -> Worker:
	var instance = preload("res://bin/worker/anvil_bonker/worker.tscn").instantiate()
	instance.name = _get_node_name()
	instance.main = main
	main.add_child(instance)
	instance.position = pos
	instance.scale = Vector2(scale/100.0, scale/100.0)
	return instance

# Native funcs:
func _ready():
	var shader: Shader = preload("res://assets/shaders/outline_outer.gdshader")
	var material: ShaderMaterial = ShaderMaterial.new()
	material.shader = shader
	worker_animation.material = material
	set_outline(Color.TRANSPARENT, 0)
	pass

# Custom logic:
func change_income() -> void:
	income += 1
	income_cost += income_cost_increase
	income_cost_increase += income_cost_increase_raise
	pass
	

func play_effect() -> void:
	anvil.add_effect(income)
	print(anvil.effects.get_children())
	
func attack() -> void:
	audio_player.play()
	worker_animation.stop()
	worker_animation.play("attack")
	anvil_animation.stop()
	anvil_animation.play("hit")
	main.change_money(income)
	play_effect()
	pass
	
func set_outline(color: Color, size: float) -> void:
	var material: ShaderMaterial = worker_animation.material
	if (material != null):
		material.set_shader_parameter("line_color", color)
		material.set_shader_parameter("line_thickness", size)
	pass

# Signal handlers:
func _on_pressed() -> void:
	main.selected_worker = self
	main.interface.update_interface(self)
	main.update_workers_outline()
	set_outline(Color.from_string("#00ff00", Color.BLACK), 1.0)
	pass
