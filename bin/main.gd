class_name Main extends Node2D

@onready var interface: Interface = $Interface
@onready var workers: Array[Worker] = []

var available_worker_positions = _get_array()
var money_counter = 0
var selected_worker: Worker = null

const WORKER_POS_Y_MARGIN = 30
const WORKER_POS_X_MARGIN = 120
const WORKER_POS_Y_SIZE = 150
const WORKER_POS_X_SIZE = 160
const MAX_WORKER_LIMIT_Y = 6
const MAX_WORKER_LIMIT_X = 4

func _get_array() -> Array[Vector2]:
	var arr: Array[Vector2] = []
	for i in range(MAX_WORKER_LIMIT_X):
		for j in range(MAX_WORKER_LIMIT_Y):
			var vector = Vector2(WORKER_POS_X_MARGIN + WORKER_POS_X_SIZE * j, WORKER_POS_Y_MARGIN + WORKER_POS_Y_SIZE * i)
			arr.append(vector)
			print(vector)
	return arr

# Native funcs:
func _ready() -> void:
	available_worker_positions.shuffle()
	create_random_worker()
	interface.set_money(money_counter)
	interface.update_interface(selected_worker)
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_released("cheat_money"):	# Debug feature
		cheat_money()									# Debug feature
	if Input.is_action_just_released("right_click"):
		selected_worker = null
		interface.update_interface(selected_worker)
		update_workers_outline()
	pass


# Custom logic:
func cheat_money():										# Debug feature
	change_money(300)									# Debug feature
	pass												# Debug feature

func update_workers_outline():
	for worker in workers:
		worker.set_outline(Color.TRANSPARENT, 0)
	pass


func change_money(amount: int):
	money_counter += amount
	interface.set_money(money_counter)
	pass

func create_random_worker() -> void:
	workers.append(Worker.create(self, available_worker_positions[0], 200))
	available_worker_positions.remove_at(0)
