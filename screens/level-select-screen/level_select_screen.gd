extends CanvasLayer

const LevelRow: PackedScene = preload("res://screens/level-select-screen/level_row.tscn")

export var levels_prev_path: NodePath
export var levels_next_path: NodePath
export var levels_path: NodePath

onready var shop_container = $PanelContainer/VBoxContainer/HBoxContainer/LeftContainer/ShopContainer
var skills_page: int = 0
const SKILLS_PER_PAGE: int = 5

onready var levels_prev: Button = get_node(levels_prev_path)
onready var levels_next: Button = get_node(levels_next_path)
onready var levels: VBoxContainer = get_node(levels_path)
var levels_page: int = 0
const LEVELS_PER_PAGE: int = 10
# CombatScreenData
var level_data: Array = []

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	# TODO test level values
	var data0 := CombatScreenData.new()
	data0.level_name = "Blue Snails Galore"
	data0.spawn_rate = CombatScreenData.SpawnRate.NORMAL
	data0.spawn_type = CombatScreenData.SpawnType.LINEAR
	data0.enemies[CombatScreenData.Enemy.BLUE_SNAIL] = 10
	
	level_data.append(data0)
	
	var data1 := CombatScreenData.new()
	data1.level_name = "Testing lmao"
	data1.spawn_rate = CombatScreenData.SpawnRate.INSTANT
	data1.enemies[CombatScreenData.Enemy.BLUE_SNAIL] = 5
	
	level_data.append(data1)
	
	for i in level_data:
		var row: Control = LevelRow.instance()
		row.data = i
		row.connect("pressed_with_data", self, "_on_level_row_pressed")
		levels.call_deferred("add_child", row)

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_levels_prev() -> void:
	pass

func _on_levels_next() -> void:
	pass

func _on_level_row_pressed(data: CombatScreenData) -> void:
	var screen: Node2D = load("res://screens/combat-screen/combat_screen.tscn").instance()
	screen.data = data
	GameManager.main.change_screen(screen)

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


