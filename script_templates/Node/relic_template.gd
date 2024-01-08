# meta-name: Relic
# meta-description: Create a Relic which can be acquired by the player.
class_name MyAwesomeRelic
extends Relic

var member_var := 0


func initialize_relic(_owner: RelicUI) -> void:
	print("this happens once when we gain a new relic")


func activate_relic(_owner: RelicUI) -> void:
	print("this happens at specific times based on the Relic.Type property")
	print("we need to emit this signal when we're done")
	relic_activated.emit(self)


# we can provide unique tooltips per relic if we want to
func get_tooltip() -> String:
	return tooltip
