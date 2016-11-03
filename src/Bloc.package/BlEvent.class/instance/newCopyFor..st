firing
newCopyFor: aTarget
	^ self class new
		copyFrom: self;
		target: aTarget;
		yourself