manager -> element
offsetPositions: startPosition forRemovingLaidOutOrNewElement: itemCount
	"Ask infinite element to update item positions starting
	at startPosition in order to remove by itemCount defined amount
	of already laid out or new elements.
	startPosition must not be nil.
	itemCount must not be nil"

	^ self subclassResponsibility