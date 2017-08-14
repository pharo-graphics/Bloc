private - measurement
layoutIgnored: anElement in: aRectangle
	"Layout ignored children of a given parent"
	| childBounds |

	childBounds := BlBounds new.
	
	anElement children
		select: [ :aChild | aChild constraints ignoredByLayout ]
		thenDo: [ :aChild | aChild applyLayoutIn: (aChild measuredBounds: childBounds) ]