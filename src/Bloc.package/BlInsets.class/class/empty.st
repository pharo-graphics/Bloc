instance creation
empty
	^ Empty ifNil: [ Empty := self
		top: 0
		right: 0
		bottom: 0
		left: 0 ]