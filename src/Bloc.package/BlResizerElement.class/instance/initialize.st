initialization
initialize
	| topLeftResizer topCenterResizer topRightResizer middleLeftResizer middleRightListener bottomLeftListener bottomCenterResizer bottomRightListener |
	super initialize.
	
	self border: (BlBorder paint: (Color blue alpha: 0.1) width: 5).
	
	topLeft := self newHandle.
	topLeft constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignTop ].
	
	topLeftResizer := BlResizerTopLeftListener new.
	topLeft addEventHandler: topLeftResizer.
	
	topCenter := self newHandle.
	topCenter constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignTop ].
	
	topCenterResizer := BlResizerTopListener new.
	topCenter addEventHandler: topCenterResizer.
	
	topRight := self newHandle.
	topRight constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignTop ].
	
	topRightResizer := BlResizerTopRightListener new.
	topRight addEventHandler: topRightResizer.
	
	middleLeft := self newHandle.
	middleLeft constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter ].
	
	middleLeftResizer := BlResizerLeftListener new.
	middleLeft addEventHandler: middleLeftResizer.
	
	middleRight := self newHandle.
	middleRight constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignCenter ].
	
	middleRightListener := BlResizerRightListener new.
	middleRight addEventHandler: middleRightListener.
	
	bottomLeft := self newHandle.
	bottomLeft constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignBottom ].
	
	bottomLeftListener := BlResizerBottomLeftListener new.
	bottomLeft addEventHandler: bottomLeftListener.
	
	bottomCenter := self newHandle.
	bottomCenter constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignBottom ].
	
	bottomCenterResizer := BlResizerBottomListener new.
	bottomCenter addEventHandler: bottomCenterResizer.
	
	bottomRight := self newHandle.
	bottomRight constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignBottom ].

	bottomRightListener := BlResizerBottomRightListener new.
	bottomRight addEventHandler: bottomRightListener.
	
	resizerListeners := { topLeftResizer . topCenterResizer . topRightResizer . middleLeftResizer . middleRightListener . bottomLeftListener . bottomCenterResizer . bottomRightListener }.

	self addChildren: {
		topLeft . topCenter . topRight .
		middleLeft . middleRight .
		bottomLeft . bottomCenter . bottomRight .
	}