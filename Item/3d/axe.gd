extends Node3D

@onready var axe: Node3D = $"."
var player = null
@onready var area: Area3D = $MeshInstance3D/Area
var ITEM_DATA = load("res://Item/Items/Axe.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player and Input.is_action_just_pressed("pick"):
		if player.Inventory.add_item(ITEM_DATA):
			print("pickup success")
			queue_free()

func _on_area_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("player"):
		player = body

func _on_area_body_shape_exited(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	if body == player:
		player = null
