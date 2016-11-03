as yet unclassified
initialize
	super initialize.
	self border: (BlBorder color: Color black width: 2 radius: 30).
	self extent: self class pxBodyWidth @ self class pxBodyHeight.
	self padding: (BlInsets all: 5).
	self constraintsDo: [ :c| 
		 c linear horizontal alignCenter.
		 c linear vertical alignCenter ].
	self
		addChild: BlMobileContent new;
		addChild: BlMobileGlass new