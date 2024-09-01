@tool
extends EditorPlugin

const AUTOLOAD_NAME = "RewindManager"

var properties_dock: Window
var inspector_plugin = preload("res://addons/time_rewind_2d/scripts/editor/time_rewind_inspector_plugin.gd")

func _enter_tree():
	add_autoload_singleton(AUTOLOAD_NAME, "res://addons/time_rewind_2d/scripts/RewindManager.gd")
	
	# Create an instance of your editor window
	properties_dock = preload("res://tree_holder.tscn").instantiate()
	
	inspector_plugin = inspector_plugin.new()
	add_inspector_plugin(inspector_plugin)
	

func _exit_tree():
	remove_autoload_singleton(AUTOLOAD_NAME)

	properties_dock.queue_free()
	
	remove_inspector_plugin(inspector_plugin)
