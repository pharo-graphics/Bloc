manager -> element
offsetPositions: startPositon forRemovingInvisible: itemCount
	"Ask infinite element to update item positions after
	removing invisible elements starting from startPosition
	an amount defined by itemCount.
	startPosition must not be nil.
	itemCount must not be nil"
	
	^ self subclassResponsibility