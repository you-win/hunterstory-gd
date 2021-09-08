extends CanvasLayer

const TransitionScreen: PackedScene = preload("res://screens/transition_screen.tscn")

onready var viewport: Viewport = $ViewportContainer/Viewport

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	GameManager.main = self

###############################################################################
# Connections                                                                 #
###############################################################################

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func change_screen(path: String) -> void:
	var new_scene = load(path).instance()
	
	var transition_screen: CanvasLayer = TransitionScreen.instance()
	var image_data: Image = viewport.get_texture().get_data()
	image_data.flip_y()
	transition_screen.last_screen_image = image_data
	transition_screen.viewport_size = viewport.size
	
	call_deferred("add_child", transition_screen)
	viewport.get_child(0).queue_free()
	
	yield(transition_screen, "faded_out")
	
	viewport.call_deferred("add_child", new_scene)
