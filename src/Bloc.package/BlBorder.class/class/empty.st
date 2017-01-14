accessing
empty
	^ empty ifNil: [ empty := self paint: Color transparent width: 0 ]