accessing properties
visibilityProperty
	^ visibility ifNil:
			[ visibility := BlVisibilityProperty 
				on: self 
				named: #visibility 
				default: BlVisibility visible ]