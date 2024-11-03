class_name AutoBonk extends Node

const DEFAULT_TIME_TO_DOLB = 1.0

var time_to_dolb = DEFAULT_TIME_TO_DOLB
var income_func

# Navite funcs:
func _init(income_func) -> void:
	self.income_func = income_func
	pass

func _process(delta: float) -> void:
	if time_to_dolb < 0:
		income_func.call()
		time_to_dolb = DEFAULT_TIME_TO_DOLB
	time_to_dolb -= delta
	pass
