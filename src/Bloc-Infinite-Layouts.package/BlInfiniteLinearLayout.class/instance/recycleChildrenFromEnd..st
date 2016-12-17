private - recycling
recycleChildrenFromEnd: anOffset
	"Recycle elements that went out of bounds after scrolling towards the start of the layout.
	Checks both layout position and visible position to guarantee that the element is not visible"
	| aLimit aChildCount aStep aStart anEnd |

	anOffset < 0
		ifTrue: [ ^ self ].
		
	self
		assert: [ anOffset >= 0 ]
		description: 'anOffset must not be negative'.
	
	aLimit := self orientation end - anOffset.
	aChildCount := self childrenCount.
	aChildCount isZero
		ifTrue: [ ^ self ].

	aStep := shouldReverseLayout
		ifTrue: [ 1 ]
		ifFalse: [ -1 ].
	
	aStart := shouldReverseLayout
		ifTrue: [ 1 ]
		ifFalse: [ aChildCount ].
	
	anEnd := shouldReverseLayout
		ifTrue: [ aChildCount ]
		ifFalse: [ 1 ].
	
	aStart to: anEnd by: aStep do: [ :anIndex |
		| anElement |
		anElement := self childAt: anIndex.
		((self orientation decoratedStart: anElement) < aLimit
			or: [ (self orientation decoratedStartInParent: anElement) < aLimit ])
				"stop here"
				ifTrue: [
					^ self recycleChildrenWithin: (aStart to: anIndex + 1) inversed ] ]