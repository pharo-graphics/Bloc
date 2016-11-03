displaying
show
	
	"self doStyle."
	self hostWindow ifNil: [ BlUniverse default createSpaceWindow: self ] ifNotNil: [ :hw | hw show ].
	self requestNextPulse.