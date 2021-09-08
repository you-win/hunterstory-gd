extends Node

signal stat_modified(stat, value)
func broadcast_stat_modified(stat: String, value: int) -> void:
	emit_signal("stat_modified", stat, value)

signal stat_points_modified(value)
func broadcast_stat_points_modified(value: int) -> void:
	emit_signal("stat_points_modified", value)

signal stat_points_availability_changed(value)
func broadcast_stat_points_availability_changed(value: bool) -> void:
	emit_signal("stat_points_availability_changed", value)
