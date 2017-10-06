initialization
initialize
	super initialize.
	
	self constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	
	leftParentheses := self newParenthesesElement.
	leftParentheses text: (self asParenthesesText: '⟮').

	rightParentheses := self newParenthesesElement.
	rightParentheses text: (self asParenthesesText: '⟯').

	gridElement := self newGridElement.
	
	self addChildren: { self asScalableElement: leftParentheses . gridElement . self asScalableElement: rightParentheses }