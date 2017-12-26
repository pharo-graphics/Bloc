event handling
switchDeactivated
	thumb constraintsDo: [ :c | c frame horizontal alignRight ].
	thumb background: (self deactivatedColor)