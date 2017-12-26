initialization
initialize
	super initialize.
	
	border := BlLookProperty
		on: self
		named: #border
		default: BlBorder empty
		invalidated: #onBorderChanged
		when: #hasOwner.

	background := BlLookProperty
		on: self
		named: #background
		default: BlBackground transparent
		invalidated: #onBackgroundChanged
		when: #hasOwner