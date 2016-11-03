computing styles
matchingTransitions
	| thePseudoClassStates matchingTrans |
	thePseudoClassStates := self transitionStates.
	matchingTrans := Dictionary new.
	self transitions
		select: [ :t | t matchesStyleable: self styleable pseudoClassStates: thePseudoClassStates ]
		thenDo: [ :t | matchingTrans at: t transition property put: t transition ].
	^ matchingTrans