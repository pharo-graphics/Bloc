manager -> element
offsetPositions: aStartPosition forRemovingLaidOutOrNewElement: anItemCount
	"Ask infinite element to update item positions starting
	at aStartPosition in order to remove by anItemCount defined amount
	of already laid out or new elements.
	aStartPosition must not be nil.
	anItemCount must not be nil"

	^ self subclassResponsibility