manager -> element
attachChild: anElement at: anIndex
	"Adds child to infinite element without redraw or layout requests.
	anElement must not be nil.
	anIndex must not be nil"
	
	^ self subclassResponsibility