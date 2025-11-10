extends Area2D
@export var jump_strenght := 800


func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("player"):
        body.velocity.y = -jump_strenght
