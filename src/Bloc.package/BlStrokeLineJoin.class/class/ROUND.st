predefined instances
ROUND
	^ Round ifNil: [ Round := self new beRound ]