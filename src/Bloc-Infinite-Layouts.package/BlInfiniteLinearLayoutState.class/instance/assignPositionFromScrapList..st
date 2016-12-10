private - recycling
assignPositionFromScrapList: anIgnoredElement
	| aClosestElement |
	
	aClosestElement := self nextElementInLimitedList: anIgnoredElement.
	currentPosition := aClosestElement
		ifNil: [ BlInfiniteElement noPosition ]
		ifNotNil: [ :anElement | anElement constraints infinite elementLayoutPosition ]