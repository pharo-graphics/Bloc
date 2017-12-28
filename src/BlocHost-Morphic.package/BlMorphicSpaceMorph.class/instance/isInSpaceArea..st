testing
isInSpaceArea: anEvent
	"Return true if given morphic event is within space area, false otherwise"
	<return: #Boolean>
	
	^ self bounds containsPoint: anEvent position