class_name Main extends Node2D
@onready var money_label: Label = $Interface/MoneyCount
@onready var income_cost_label: Label = $Interface/IncomeButton/IncomeCost
@onready var autodolb_cost_label: Label = $Interface/AutodolbButton/AutodolbCost
@onready var autodolb_button: Button = $Interface/AutodolbButton
@onready var income_button: Button = $Interface/IncomeButton
@onready var interface: Interface = $Interface
@onready var workers: Array[Worker] = [create_worker(Vector2(400, 250)), create_worker(Vector2(800, 250))]
var money_counter = 0
var autodolb_cost = 200
var selected_worker: Worker = null
const MONEY_FORMAT = "%d$"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	money_label.text = MONEY_FORMAT%[money_counter]
	autodolb_cost_label.text = MONEY_FORMAT%[autodolb_cost]
	update_interface()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_released("cheat_money"):
		cheat_money()
	print(selected_worker)


func cheat_money():
	change_money(300)


func update_interface() -> void:
	if selected_worker:
		show_worker_buttons(selected_worker)
	else:
		income_button.hide()
		autodolb_button.hide()


func show_worker_buttons(worker):
	if worker.autodolb:
		autodolb_button.hide()
	else:
		autodolb_button.show()
	income_cost_label.text = MONEY_FORMAT%[worker.income_cost]
	income_button.show()


func anvil_hit() -> void:
	for worker in workers:
		worker.attack()


func buy_income() -> void:
	if money_counter < selected_worker.income_cost:
		return
	change_money(-selected_worker.income_cost)
	selected_worker.change_income()
	update_interface()


func buy_autodolb() -> void:
	if money_counter < autodolb_cost:
		return
	
	change_money(-autodolb_cost)
	
	selected_worker.autodolb = Autodolb.new(selected_worker.attack)
	selected_worker.add_child(selected_worker.autodolb)
	
	update_interface()


func create_worker(pos: Vector2) -> Worker:
	var worker = Worker.create(self)
	worker.position = pos
	add_child(worker)
	return worker


func change_money(amount: int):
	money_counter += amount
	money_label.text = MONEY_FORMAT%[money_counter]


func _on_interface_attack_button_pressed() -> void:
	anvil_hit()
	update_interface()


func _on_interface_income_button_pressed() -> void:
	buy_income()


func _on_interface_autodolb_button_pressed() -> void:
	buy_autodolb()
