manager -> element
offsetPositions: startPosition forAdd: itemCount
	"Ask infinite element to update item positions from startPosition
	in order to add itemCount amount of new items.
	startPosition must not be nil
	itemCount must not be nil"
	
	^ self subclassResponsibility