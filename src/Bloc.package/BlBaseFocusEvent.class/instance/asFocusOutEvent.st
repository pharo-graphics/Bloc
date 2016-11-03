converting
asFocusOutEvent
	^ BlFocusOutEvent new
		copyFrom: self;
		canBePropagated: false;
		yourself