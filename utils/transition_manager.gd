extends Node

const TWEEN_DURATION: float = 3.0
const CLEAR_COLOR := Color(0.0, 0.0, 0.0, 0.0)
const BLACK_COLOR := Color(0.0, 0.0, 0.0, 255.0)

var tween: Tween

var canvas: CanvasLayer
var color_rect: ColorRect

var screen_path_to_change_to: String

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	tween = Tween.new()
	tween.name = "Tween"
	call_deferred("add_child", tween)
	
	tween.connect("tween_step", self, "_on_tween_step")
	
	var viewport_size_half: Vector2 = get_viewport().size / 2
	
	canvas = CanvasLayer.new()
	canvas.layer = 100
	canvas.name = "CanvasLayer"
	
	color_rect = ColorRect.new()
	color_rect.name = "ColorRect"
	color_rect.anchor_left = 0.0
	color_rect.anchor_top = 0.0
	color_rect.anchor_right = 1.0
	color_rect.anchor_bottom = 1.0
	color_rect.rect_pivot_offset = (viewport_size_half)
	color_rect.color = CLEAR_COLOR

func _exit_tree() -> void:
	if tween:
		tween.free()
	if color_rect:
		color_rect.free()

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_first_tween_complete() -> void:
	if get_tree().change_scene(screen_path_to_change_to) != OK:
		GameManager.log_message("Unable to change screen to: %s" % screen_path_to_change_to, true)
	
	yield(get_tree(), "idle_frame")
	
	tween.disconnect("tween_all_completed", self, "_on_first_tween_complete")
	tween.connect("tween_all_completed", self, "_on_second_tween_complete")
	tween.interpolate_property(color_rect, "color:a", color_rect.color.a, CLEAR_COLOR.a, TWEEN_DURATION)
	tween.start()

func _on_second_tween_complete() -> void:
	tween.disconnect("tween_all_completed", self, "_on_second_tween_complete")
	
	canvas.remove_child(color_rect)
	get_tree().root.remove_child(canvas)

func _on_tween_step(object: Object, key: NodePath, elapsed: float, value: Object) -> void:
	print(object.color)
	pass

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func change_screen_to(path: String) -> void:
	screen_path_to_change_to = path
	
	get_tree().root.add_child(canvas)
	canvas.add_child(color_rect)
	
	tween.connect("tween_all_completed", self, "_on_first_tween_complete")
	tween.interpolate_property(color_rect, "color:a", color_rect.color.a, BLACK_COLOR.a, TWEEN_DURATION)
	tween.start()
