manager -> element
offsetPositions: aStartPosition forAdd: anItemCount
	"Ask infinite element to update item positions from startPosition
	in order to add anItemCount amount of new items.
	aStartPosition must not be nil
	anItemCount must not be nil"
	
	^ self subclassResponsibility