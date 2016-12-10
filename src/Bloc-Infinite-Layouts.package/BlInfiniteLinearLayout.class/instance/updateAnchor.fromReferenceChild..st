layout - anchor
updateAnchor: anAnchorInfo fromReferenceChild: anElement
	
	anAnchorInfo assignFromElement: anElement in: self.
	"If all visible elements are removed in 1 pass, reference child might be out of bounds.
	If that is the case, offset it back to 0 so that we use these pre-layout children."
	(self state isPreLayout not and: [ self supportsPredictiveItemAnimations ])
		ifTrue: [ 
			| isNotVisible | 
			"validate reference element is at least partially visible. if not, offset it to start"
			isNotVisible := (self orientation decoratedStart: anElement) >= self orientation endWithPadding or: [ 
				(self orientation decoratedEnd: anElement) < self orientation startWithPadding ].
			isNotVisible
				ifTrue: [ 
					anAnchorInfo coordinate: (anAnchorInfo layoutFromEnd
						ifTrue: [ self orientation endWithPadding ]
						ifFalse: [ self orientation startWithPadding ]) ] ]