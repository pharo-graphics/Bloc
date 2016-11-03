accessing
focusedProperty
	^ focused
		ifNil: [ focused := BlObjectProperty
				on: self
				named: #focused
				default: false ]