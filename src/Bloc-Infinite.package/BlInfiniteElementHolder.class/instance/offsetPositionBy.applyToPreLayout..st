private
offsetPositionBy: anOffset applyToPreLayout: shouldApplyOnPreLayout
	
	previousPosition = NoPosition
		ifTrue: [ previousPosition := position ].
	
	preLayoutPosition = NoPosition
		ifTrue: [ preLayoutPosition := position ].
	
	shouldApplyOnPreLayout
		ifTrue: [ preLayoutPosition := preLayoutPosition + anOffset ].
	
	position := position + anOffset.
	itemElement constraints infinite insetsDirty: true