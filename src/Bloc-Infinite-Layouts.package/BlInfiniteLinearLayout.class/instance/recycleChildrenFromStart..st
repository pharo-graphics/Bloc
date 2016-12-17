private - recycling
recycleChildrenFromStart: anOffset
	"Recycle elements that went out of bounds after scrolling towards the end of the layout.
	Checks both layout position and visible position to guarantee that the element is not visible"
	| aLimit aChildCount aStep aStart anEnd |
	
	anOffset < 0
		ifTrue: [ ^ self ].
	
	self
		assert: [ anOffset >= 0 ]
		description: 'anOffset must not be negative'.
	
	aLimit := anOffset.
	aChildCount := self childrenCount.
	aChildCount isZero
		ifTrue: [ ^ self ].
	
	aStep := shouldReverseLayout
		ifTrue: [ -1 ]
		ifFalse: [ 1 ].
	
	aStart := shouldReverseLayout
		ifTrue: [ aChildCount ]
		ifFalse: [ 1 ].
	
	anEnd := shouldReverseLayout
		ifTrue: [ 1 ]
		ifFalse: [ aChildCount ].
	
	aStart to: anEnd by: aStep do: [ :anIndex |
		| anElement |
		anElement := self childAt: anIndex.
		((self orientation decoratedEnd: anElement) > aLimit
			or: [ (self orientation decoratedEndInParent: anElement) > aLimit ])
				"stop here"
				ifTrue: [ ^ self recycleChildrenWithin: (anIndex - 1 to: aStart) inversed ] ]