"
I sort element according to their visual layout and geometry

"
Class {
	#name : #BlFocusFinderComparator,
	#superclass : #Object,
	#instVars : [
		'rootElement',
		'firstBounds',
		'secondBounds'
	],
	#category : #'Bloc-FocusFinder-Core'
}

{ #category : #private }
BlFocusFinderComparator >> bounds: aBlBounds of: anElement [
	"Store and return visual bounds of a given element in root's coordinates
	that will be used for comparison.
	Note: I return mutable BlBounds instance that is shared between all comparison
	operations. By convention focus search can only be happen from UI thread, so it
	is safe to share bounds instance.
	Answer a `BlBounds`."
	
	anElement boundsInLocal: aBlBounds.
	^ rootElement localBoundsToMine: aBlBounds fromChild: anElement
]

{ #category : #initialization }
BlFocusFinderComparator >> initialize [

	super initialize.

	firstBounds := BlBounds new.
	secondBounds := BlBorder new
]

{ #category : #testing }
BlFocusFinderComparator >> isRightToLeft [
	"Return true if I compare element in a context of right to left layout, false otherwise"

	^ false
]

{ #category : #accessing }
BlFocusFinderComparator >> rootElement [
	"Return an element that plays a role of a root for a visual focus search"
	
	^ rootElement
]

{ #category : #accessing }
BlFocusFinderComparator >> rootElement: anElement [
	"Set an element that should be considered a root during visual focus search.
	Note: element are compared by their visual bounds transformed to local coordinates
	of a root element"
	
	rootElement := anElement
]

{ #category : #evaluating }
BlFocusFinderComparator >> value: aFirstElement value: aSecondElement [
	" I sort elements according to the following strategy:
	
	1) A rectangle that is located higher gets higher priority,
	so A will be higher in the sorted list than B:
	
	|----------|
	|    A     |       
	|__________|      
	
	|-----------|
	|     B     |
	|___________|
	
	2) A rectangle with smaller x coodinate of a left edge gets higher priority,
	A will be before B:
	Note: if layout is left to right, then B should be first (reversed order)
	
	|---------|  |---------|
	|    A    |  |    B    |
	|_________|  |_________|
	"
	<return: #Number>
	
	self bounds: firstBounds of: aFirstElement.
	self bounds: secondBounds of: aSecondElement.
	
	(firstBounds top < secondBounds top)
		ifTrue: [ ^ -1 ].
	
	(firstBounds top > secondBounds top)
		ifTrue: [ ^ 1 ].
	
	(firstBounds left < secondBounds left)
		ifTrue: [ ^ self isRightToLeft
			ifTrue: [ 1 ]
			ifFalse: [ -1 ] ].
	
	(firstBounds left > secondBounds left)
		ifTrue: [ ^ self isRightToLeft
			ifTrue: [ -1 ]
			ifFalse: [ 1 ] ].
	
	(firstBounds bottom < secondBounds bottom)
		ifTrue: [ ^ -1 ].
	
	(firstBounds bottom > secondBounds bottom)
		ifTrue: [ ^ 1 ].
	
	(firstBounds right < secondBounds right)
		ifTrue: [ ^ self isRightToLeft
			ifTrue: [ 1 ]
			ifFalse: [ -1 ] ].
	
	(firstBounds right > secondBounds right)
		ifTrue: [ ^ self isRightToLeft
			ifTrue: [ -1 ]
			ifFalse: [ 1 ] ].
	
	"elements are distinct, treat them as equal"
	^ 0
]
