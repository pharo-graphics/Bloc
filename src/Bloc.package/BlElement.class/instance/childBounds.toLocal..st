geometry bounds convertion
childBounds: aBlBounds toLocal: anElement
	"In-place transform provided bounds from coordinate system of a given descendant element
	to my local coordinates and return a result"
	<return: #BlBounds>
	| aParentElement |
	
	anElement == self
		ifTrue: [ ^ self ].
		
	self
		assert: [ anElement hasParent ]
		description: [ 'An element must be my descendant (at least have a parent)' ].
	
	aParentElement := anElement.
	
	[ aParentElement localBoundsToParent: aBlBounds.
		self
			assert: [ aParentElement hasParent ]
			description: [ 'A child element must be my descentant (be in my children composition tree)' ].
		
		aParentElement := aParentElement parent ]
			doWhileFalse: [ aParentElement == self ].
			
	^ aBlBounds