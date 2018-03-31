children - accessing
referenceChildWithin: anIndexInterval between: aPositionInterval recycler: aBlInfiniteRecycler state: aBlInfiniteState
	"Return a child that is suitable to be considered as an anchor child.
	Due to ambiguous data source updates or children being removed, some children's positions may be invalid.
	I am a best effort to find a position within data source bounds if possible.
	I also prioritize children that are within the visible bounds"
	<return: #BlElement or: nil>
	| anInvalidElement anOutOfBoundsElement aStart anEnd aStep |

	anInvalidElement := nil.
	anOutOfBoundsElement := nil.
	aStart := self orientation startWithPadding.
	anEnd := self orientation endWithPadding.
	aStep := (anIndexInterval last > anIndexInterval first)
		ifTrue: [ 1 ]
		ifFalse: [ -1 ].
	
	anIndexInterval first to: anIndexInterval last by: aStep do: [ :anIndex |
		| anElement aPosition |
		anElement := self childAt: anIndex.
		aPosition := self childPositionOf: anElement.
		(aPosition between: aPositionInterval first and: aPositionInterval last)
			ifTrue: [ 
				anElement constraints infinite isItemRemoved
					"removed item, least preferred"
					ifTrue: [ anInvalidElement ifNil: [ anInvalidElement := anElement ] ]
					ifFalse: [
						((self orientation decoratedStart: anElement) >= anEnd or: [ 
							(self orientation decoratedEnd: anElement) < aStart ])
								"item is not visible, less preferred"
								ifTrue: [ anOutOfBoundsElement ifNil: [ anOutOfBoundsElement := anElement ] ]
								"exactly what we want"
								ifFalse: [ ^ anElement ] ] ] ].
	
	^ anOutOfBoundsElement ifNil: [ anInvalidElement ]