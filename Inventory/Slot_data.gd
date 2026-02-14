extends Resource

class_name Slot_data

@export var Item_data: Item_data
@export_range(1,10) var quantity : int =1: set = set_quantity


func can_fully_merge_with(other_slot_data:Slot_data) -> bool:
	return Item_data==other_slot_data.Item_data and Item_data.stakable # can add max stack size
	
func fully_merge_with(other_slot_data:Slot_data) -> void:
	quantity+=other_slot_data.quantity
	
func set_quantity(value: int)-> void:
	quantity=value
	if quantity>1 and not Item_data.stakable:
		quantity =1
		print("not stakable")
		
