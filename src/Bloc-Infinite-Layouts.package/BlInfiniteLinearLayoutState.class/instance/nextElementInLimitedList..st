private - recycling
nextElementInLimitedList: anIgnoredElement
	| aClosestElement aClosestDistance |
	
	isPreLayout
		ifTrue: [ self error: 'Can not be used in pre layout' ].
	
	aClosestElement := nil.
	aClosestDistance := Float infinity.
	
	scrapList do: [ :anElementHolder | 
		| anElement anInfiniteConstraints |
		anElement := anElementHolder itemElement.
		anInfiniteConstraints := anElement constraints infinite.
		(anElement == anIgnoredElement or: [
			anInfiniteConstraints isItemRemoved ])
				ifFalse: [ 
					| aDistance |
					aDistance := (anInfiniteConstraints elementLayoutPosition - currentPosition) * itemDirection multiplier.
					(aDistance >= 0 and: [ aDistance < aClosestDistance ])
						"item is in current direction and is currently the closest"
						ifTrue: [ 
							aClosestElement := anElement.
							aClosestDistance := aDistance.
							aDistance isZero
								ifTrue: [ ^ aClosestElement ] ] ] ].
	^ aClosestElement