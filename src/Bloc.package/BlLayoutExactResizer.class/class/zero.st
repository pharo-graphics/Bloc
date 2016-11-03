accessing
zero
	^ zero ifNil: [ zero := self new size: 0 ]