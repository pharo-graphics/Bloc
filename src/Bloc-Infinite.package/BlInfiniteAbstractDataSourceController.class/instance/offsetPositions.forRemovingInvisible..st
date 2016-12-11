manager -> element
offsetPositions: aStartPosition forRemovingInvisible: anItemCount
	"Ask infinite element to update item positions after
	removing invisible elements starting from aStartPosition
	an amount defined by anItemCount.
	aStartPosition must not be nil.
	anItemCount must not be nil"
	
	^ self subclassResponsibility