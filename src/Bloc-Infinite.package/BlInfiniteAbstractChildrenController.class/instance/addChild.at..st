manager -> element
addChild: anElement at: anIndex
	"Add anElement as direct child to infinite element at anIndex.
	anElement must not be nil
	anIndex must not be nil"
	
	^ self subclassResponsibility