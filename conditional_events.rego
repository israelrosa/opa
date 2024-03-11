package conditional_events

valid_schema := json.match_schema(input, data.schema)

valid_events contains event.event if {
	some event in data.events
	some facts in event.conditions
	every fact in facts {
		selected_fact := input[fact.fact]
		selected_value := selected_fact[fact.path]
		operator(fact.operator, selected_value, fact.value)
	}
}

operator(operator, value1, value2) if {
	operator == "greaterThan"
	value1 > value2
}

operator(operator, value1, value2) if {
	operator == "lessThan"
	value1 < value2
}

operator(operator, value1, value2) if {
	operator == "greaterThanInclusive"
	value1 >= value2
}

operator(operator, value1, value2) if {
	operator == "lessThanInclusive"
	value1 <= value2
}

operator(operator, value1, value2) if {
	operator == "equal"
	value1 == value2
}
