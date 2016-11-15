manager -> element
offsetPositions: fromPosition forMove: toPosition
	"Ask infinite element to update item positions in order
	to move items from fromPosition to toPosition
	fromPosition must not be nil
	toPosition must not be nil"
	
	^ self subclassResponsibility