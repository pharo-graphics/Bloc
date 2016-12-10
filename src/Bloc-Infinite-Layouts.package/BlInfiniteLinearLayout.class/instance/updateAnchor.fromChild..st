layout - anchor
updateAnchor: anAnchorInfo fromChild: anElement
	| anElementSize aStartGap anEndGap |
	
	self
		assert: [ anElement isNotNil ]
		description: [ 'Can not update anchor info from nil element' ].

	anElementSize := self orientation decoratedMeasurement: anElement.
	anElementSize > self orientation totalSpace
		ifTrue: [ 
			"item does not fit. fix depending on layout direction"
			anAnchorInfo assignCoordinateFromPaddingIn: self.
			^ self ].
	
	aStartGap := (self orientation decoratedStart: anElement) - self orientation startWithPadding.
	aStartGap < 0
		ifTrue: [ 
			anAnchorInfo coordinate: self orientation startWithPadding.
			anAnchorInfo layoutFromEnd: false.
			^ self ].
		
	anEndGap := self orientation endWithPadding - (self orientation decoratedEnd: anElement).
	anEndGap < 0
		ifTrue: [ 
			anAnchorInfo coordinate: self orientation endWithPadding.
			anAnchorInfo layoutFromEnd: true.
			^ self ].
	
	anAnchorInfo coordinate: (anAnchorInfo layoutFromEnd
		ifTrue: [ (self orientation decoratedEnd: anElement) + self orientation totalSpaceChange ]
		ifFalse: [ self orientation decoratedStart: anElement ])