hooks - layout
onLayoutDone: anElement
	super onLayoutDone: anElement.
	
	isStopped := true.
	anElement childrenDo: [ :aChildElement | aChildElement measuredBounds position: aChildElement position ].
	measuredExtent := anElement extent