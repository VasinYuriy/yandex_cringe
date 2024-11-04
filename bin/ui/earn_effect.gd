class_name EarnEffect extends Node2D

@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_started: bool = false
var is_stopped: bool = false
var income

const MONEY_FORMAT = "%d$"
const NODE_NAME_FORMAT = "EARN_EFFECT_%d"

static var _next_id = 0
static func _get_node_name() -> String:
	var result = NODE_NAME_FORMAT%[_next_id]
	if _next_id == 9223372036854775807:
		_next_id = 0
	_next_id += 1
	return result


static func create(income) -> EarnEffect:
	var instance = preload("res://bin/ui/earn_effect.tscn").instantiate()
	instance.name = _get_node_name()
	instance.income = income
	return instance


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.text = MONEY_FORMAT%[income]	
	animation_player.play("earn")
	is_started = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_started and not is_stopped:
		if not animation_player.current_animation:
			is_stopped = true
