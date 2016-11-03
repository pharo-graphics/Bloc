converting
asFocusInEvent
	^ BlFocusInEvent new
		copyFrom: self;
		canBePropagated: false;
		yourself