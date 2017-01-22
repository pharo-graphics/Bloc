accessing
empty
	^ empty ifNil: [ empty := self paint: BlPaint transparent width: 0 ]