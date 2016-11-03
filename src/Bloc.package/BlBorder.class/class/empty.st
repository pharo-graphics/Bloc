instance creation
empty
	^ Empty ifNil: [ Empty := self color: Color transparent width: 0 ]