extends Node2D
@onready var player_animation: AnimatedSprite2D = $Player/AnimatedSprite2D
@onready var money_label: Label = $Interface/MoneyCount
@onready var income_cost_label: Label = $Interface/IncomeButton/IncomeCost
var money_counter = 0
var income = 1
var income_cost = 10
var income_cost_increase = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	money_label.text = str(money_counter)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func anvil_hit() -> void:
	change_money(income)


func buy_income() -> void:
	if money_counter < income_cost:
		return
	
	change_money(-income_cost)
	income += 1
	
	change_income_cost()


func change_income_cost() -> void:
	income_cost += income_cost_increase
	income_cost_increase += 10
	
	income_cost_label.text = str(income_cost) + "$"


func change_money(amount: int):
	money_counter += amount
	money_label.text = str(money_counter)


func _on_interface_attack_button_pressed() -> void:
	anvil_hit()


func _on_interface_income_button_pressed() -> void:
	buy_income()
