displaying
show
	
	"self doStyle."
	self hostSpace ifNil: [ BlUniverse default createSpaceWindow: self ] ifNotNil: [ :hw | hw show ].
	self requestNextPulse.