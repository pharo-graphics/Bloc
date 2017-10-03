layout
layoutIgnored: anElement
	"Layout children ignored by layout so that their measured bounds
	become actual bounds in parent"
	
	anElement children
		select: [ :aChild | aChild constraints ignoredByLayout ]
		thenDo: [ :aChild | aChild applyLayoutIn: aChild measuredBounds asRectangle ]