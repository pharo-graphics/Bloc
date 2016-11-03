computing styles
matchingStyleMap
	| thePseudoClassStates matchingStyles |
	thePseudoClassStates := self transitionStates.
	matchingStyles := Dictionary new.
	self styles
		select: [ :s | s matchesStyleable: self styleable pseudoClassStates: thePseudoClassStates ]
		thenDo: [ :s | matchingStyles at: s declaration property put: s declaration value ].
	^ matchingStyles