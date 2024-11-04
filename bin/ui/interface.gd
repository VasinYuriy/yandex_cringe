class_name Interface extends Control

@onready var money_label: Label = $MoneyCount
@onready var auto_bonk_cost_label: Label = $Buttons/AutoBonkButton/Label
@onready var add_worker_cost_label: Label = $Buttons/AddWorkerButton/Label
@onready var auto_bonk_button: BoxContainer = $Buttons/AutoBonkButton
@onready var income_button: BoxContainer = $Buttons/AddIncomeButton
@onready var income_cost_label: Label = $Buttons/AddIncomeButton/Label
@onready var buttons_layout: BoxContainer = $Buttons

var main: Node2D
var auto_bonk_cost = 200
var worker_cost = 400
var worker_cost_increase = 1000
var worker_cost_increase_raise = 800
const MONEY_FORMAT = "%d$"


func _ready() -> void:
	auto_bonk_cost_label.text = MONEY_FORMAT%[auto_bonk_cost]
	add_worker_cost_label.text = MONEY_FORMAT%[worker_cost]
	main = get_tree().root.get_node("Main")
	print(main)
	pass

func _process(_delta) -> void:
	if Input.is_action_just_released("action"):	# Debug feature
		anvil_hit()

func show_worker_buttons(worker: Worker):
	if worker.auto_bonk:
		auto_bonk_button.hide()
	else:
		auto_bonk_button.show()
	income_cost_label.text = MONEY_FORMAT%[worker.income_cost]
	income_button.show()
	pass


func update_interface(selected_worker: Worker) -> void:
	add_worker_cost_label.text = MONEY_FORMAT%[worker_cost]
	if selected_worker:
		print(selected_worker)							# Debug feature
		show_worker_buttons(selected_worker)
		buttons_layout.size.y = get_tree().root.size.y
	else:
		income_button.hide()
		auto_bonk_button.hide()
		buttons_layout.size.y = 0
	pass


func set_money(amount) -> void:
	money_label.text = MONEY_FORMAT%[amount]


func anvil_hit() -> void:
	for worker in main.workers:
		worker.attack()
	pass


func buy_auto_bonk() -> void:
	if main.money_counter < auto_bonk_cost:
		return
	main.change_money(-auto_bonk_cost)
	main.selected_worker.auto_bonk = AutoBonk.new(main.selected_worker.attack)
	main.selected_worker.add_child(main.selected_worker.auto_bonk)
	update_interface(main.selected_worker)
	pass


func buy_income() -> void:
	if not main.selected_worker:
		return
	if main.money_counter < main.selected_worker.income_cost:
		return
	main.change_money(-main.selected_worker.income_cost)
	main.selected_worker.change_income()
	update_interface(main.selected_worker)
	pass

func buy_worker() -> void:
	if main.money_counter < worker_cost:
		return
	
	main.change_money(-worker_cost)
	worker_cost += worker_cost_increase
	worker_cost_increase += worker_cost_increase_raise
	update_interface(main.selected_worker)
	
	main.create_random_worker()


# Signal handlers:
func _on_income_button_pressed() -> void:
	buy_income()
	pass

func _on_autodolb_button_pressed() -> void:
	buy_auto_bonk()
	pass

func _on_screen_clicker_pressed() -> void:
	anvil_hit()
	pass

func _on_add_worker_button_pressed() -> void:
	buy_worker()
	pass
