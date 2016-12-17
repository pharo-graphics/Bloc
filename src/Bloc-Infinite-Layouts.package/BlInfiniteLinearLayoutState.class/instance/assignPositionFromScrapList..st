private - recycling
assignPositionFromScrapList: anIgnoredElement
	| aClosestElement |
	
	aClosestElement := self nextElementInLimitedList: anIgnoredElement.
	currentPosition := aClosestElement
		ifNil: [ NoPosition ]
		ifNotNil: [ :anElement | anElement constraints infinite elementLayoutPosition ]