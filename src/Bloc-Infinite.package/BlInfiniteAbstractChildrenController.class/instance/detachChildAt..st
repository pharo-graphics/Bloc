manager -> element
detachChildAt: anIndex
	"Remove a child from infinite element at anIndex without
	redraw and layout requests.
	anIndex must not be nil"
	
	^ self subclassResponsibility