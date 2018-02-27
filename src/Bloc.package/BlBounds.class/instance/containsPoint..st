testing
containsPoint: aPoint 
	"Answer whether aPoint is within the receiver."
	<return: #Boolean>

	^ self origin <= aPoint and: [ aPoint < self corner ]