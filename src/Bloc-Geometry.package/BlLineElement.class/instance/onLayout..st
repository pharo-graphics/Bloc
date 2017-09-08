layout
onLayout: aBounds
	| anOrigin aCorner |
	
	ContextStackSignal emit.

	anOrigin := self originPosition.
	aCorner := self cornerPosition.
	
	WrapperSignal emit: (Rectangle encompassing: { anOrigin. aCorner }).
	
	self halt.
	
	super onLayout: (Rectangle encompassing: { anOrigin. aCorner })