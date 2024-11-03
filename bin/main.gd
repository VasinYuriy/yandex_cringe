class_name Main extends Node2D

@onready var money_label: Label = $Interface/MoneyCount
@onready var income_cost_label: Label = $Interface/IncomeButton/IncomeCost
@onready var auto_bonk_cost_label: Label = $Interface/AutoBonkButton/AutoBonkCost
@onready var auto_bonk_button: Button = $Interface/AutoBonkButton
@onready var income_button: Button = $Interface/IncomeButton
@onready var interface: Interface = $Interface
@onready var workers: Array[Worker] = [Worker.create(self, Vector2(100, 400), 200), Worker.create(self, Vector2(250, 400), 200)]

const MONEY_FORMAT = "%d$"

var money_counter = 0
var auto_bonk_cost = 200
var selected_worker: Worker = null

# Native funcs:
func _ready() -> void:
	money_label.text = MONEY_FORMAT%[money_counter]
	auto_bonk_cost_label.text = MONEY_FORMAT%[auto_bonk_cost]
	update_interface()
	pass

func _process(_delta: float) -> void:
	if Input.is_action_just_released("cheat_money"):	# Debug feature
		cheat_money()									# Debug feature								# Debug feature
	if Input.is_action_just_released("right_click"):
		selected_worker = null
		update_interface()
		update_workers_outline()
	pass

# Custom logic:
func cheat_money():										# Debug feature
	change_money(300)									# Debug feature
	pass												# Debug feature

func update_workers_outline():
	for worker in workers:
		worker.set_outline(Color.TRANSPARENT, 0)

func update_interface() -> void:
	if selected_worker:
		print(selected_worker)
		show_worker_buttons(selected_worker)
	else:
		income_button.hide()
		auto_bonk_button.hide()
	pass

func show_worker_buttons(worker):
	if worker.auto_bonk:
		auto_bonk_button.hide()
	else:
		auto_bonk_button.show()
	income_cost_label.text = MONEY_FORMAT%[worker.income_cost]
	income_button.show()
	pass

func anvil_hit() -> void:
	for worker in workers:
		worker.attack()
	pass

func buy_income() -> void:
	if money_counter < selected_worker.income_cost:
		return
	change_money(-selected_worker.income_cost)
	selected_worker.change_income()
	update_interface()
	pass

func buy_auto_bonk() -> void:
	if money_counter < auto_bonk_cost:
		return
	change_money(-auto_bonk_cost)
	selected_worker.auto_bonk = AutoBonk.new(selected_worker.attack)
	selected_worker.add_child(selected_worker.auto_bonk)
	update_interface()
	pass

func change_money(amount: int):
	money_counter += amount
	money_label.text = MONEY_FORMAT%[money_counter]
	pass

# Signals handlers:
func _on_interface_attack_button_pressed() -> void:
	anvil_hit()
	update_interface()
	pass

func _on_interface_income_button_pressed() -> void:
	buy_income()
	pass

func _on_interface_autodolb_button_pressed() -> void:
	buy_auto_bonk()
	pass
