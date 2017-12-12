accessing
zoomLevel
	<return: #Number>

	^ self hasZoomLevel
		ifTrue: [ zoomLevel ]
		ifFalse: [ self computeZoomLevel ]