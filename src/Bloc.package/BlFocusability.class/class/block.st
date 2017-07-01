accessing
block
	^ block ifNil: [ block := BlFocusabilityBlock new ]