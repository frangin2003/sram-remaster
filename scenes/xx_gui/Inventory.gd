extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("_initialize_inventory")

func _initialize_inventory():
	print(Global.INVENTORY)
	for item in Global.INVENTORY:
		if Global.INVENTORY[item]:
			var node = get_node(item.capitalize())
			if node:
				node.visible = true
			else:
				print("Node for item " + item.capitalize() + " not found.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
