layout
layout: anElement in: aRectangle
	self isStopped
		ifTrue: [ ^ super layout: anElement in: aRectangle ].
	self layout layout: anElement in: aRectangle