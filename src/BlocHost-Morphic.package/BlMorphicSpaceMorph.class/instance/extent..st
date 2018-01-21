geometry
extent: aPoint
	super extent: aPoint.
	
	"morph may resize before host space is created"
	self hostSpace
		ifNil: [ ^ self ].
	
	self resizeDuring: [
		BlMorphicWindowResizeEvent new
			width: self width;
			height: self height;
			sentTo: eventHandler ]