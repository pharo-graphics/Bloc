accessing properties
positionProperty
	^ position ifNil: [ position := BlDelegateProperty on: self named: #position delegateTo: self hostWindowProperty ]