initialization
initialize
	super initialize.
	self border: (BlBorder paint: Color black width: 2).
	self geometry: (BlRectangle cornerRadius: 20).
	self size: self class pxBodyWidth @ self class pxBodyHeight.
	self padding: (BlInsets all: 5).
	self constraintsDo: [ :c| 
		 c linear horizontal alignCenter.
		 c linear vertical alignCenter ].
	self
		addChild: BlMobileContent new;
		addChild: BlMobileGlass new