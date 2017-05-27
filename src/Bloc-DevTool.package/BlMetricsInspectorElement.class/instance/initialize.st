initialization
initialize
	super initialize.
		
	labelElement := self newLabelElement.
	labelElement constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignTop ].
	
	topInsetElement := self newInsetElement.
	topInsetElement constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignTop ].

	rightInsetElement := self newInsetElement.
	rightInsetElement constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignCenter ].
	
	bottomInsetElement := self newInsetElement.
	bottomInsetElement constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignBottom ].
	
	leftInsetElement := self newInsetElement.
	leftInsetElement constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter ].

	self spacing: self defaultSpacing.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	
	self addChildren: { 
		labelElement.
		topInsetElement.
		rightInsetElement.
		bottomInsetElement.
		leftInsetElement }