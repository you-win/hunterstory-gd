extends CanvasLayer

const LevelSelectScreen: PackedScene = preload("res://screens/level-select-screen/level_select_screen.tscn")

export var continue_game_path: NodePath
export var new_game_path: NodePath
export var options_path: NodePath
export var quit_path: NodePath

onready var continue_game: Button = get_node(continue_game_path)
onready var new_game: Button = get_node(new_game_path)
onready var options: Button = get_node(options_path)
onready var quit: Button = get_node(quit_path)

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	continue_game.connect("pressed", self, "_on_continue_game")
	new_game.connect("pressed", self, "_on_new_game")
	options.connect("pressed", self, "_on_options")
	quit.connect("pressed", self, "_on_quit")

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_continue_game() -> void:
	pass

func _on_new_game() -> void:
#	GameManager.main.change_screen("res://screens/combat-screen/combat_screen.tscn")
	GameManager.new_game_data()
	var screen = LevelSelectScreen.instance()
	GameManager.main.change_screen(screen)

func _on_options() -> void:
	pass

func _on_quit() -> void:
	get_tree().quit()

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################


