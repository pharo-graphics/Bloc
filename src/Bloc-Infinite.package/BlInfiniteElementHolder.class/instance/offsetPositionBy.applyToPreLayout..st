private
offsetPositionBy: anOffset applyToPreLayout: shouldApplyOnPreLayout
	
	previousPosition = BlInfiniteElement noPosition
		ifTrue: [ previousPosition := position ].
	
	preLayoutPosition = BlInfiniteElement noPosition
		ifTrue: [ preLayoutPosition := position ].
	
	shouldApplyOnPreLayout
		ifTrue: [ preLayoutPosition := preLayoutPosition + anOffset ].
	
	position := position + anOffset.
	itemElement constraints infinite insetsDirty: true