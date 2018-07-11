geometry bounds convertion
localBoundsToMine: aBlBounds fromChild: anElement
	"In-place transform provided bounds from coordinate system of a given descendant element
	to my local coordinates and return a result"
	<return: #BlBounds>
	| aParentElement |
	
	anElement == self
		ifTrue: [ ^ aBlBounds ].
		
	self
		assert: [ anElement hasParent: self ]
		description: [ 'A child element must be my descentant (be in my children composition tree)' ].
	
	aParentElement := anElement.
	
	[
		aParentElement localBoundsToParent: aBlBounds.
		aParentElement := aParentElement parent
	] doWhileFalse: [ aParentElement == self ].
			
	^ aBlBounds