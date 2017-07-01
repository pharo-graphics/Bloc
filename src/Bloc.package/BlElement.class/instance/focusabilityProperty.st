accessing properties
focusabilityProperty
	^ focusability ifNil:
			[ focusability := BlFocusabilityProperty 
				on: self 
				named: #focusability 
				default: self defaultFocusability ]