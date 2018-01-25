geometry
extentFor: anElement
	<return: #Point>

	^ (self overlayElement globalBoundsToLocal: anElement bounds inSpace bounds copy) extent