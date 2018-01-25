geometry
positionFor: anElement
	<return: #Point>
	
	^ (self overlayElement globalPointToParent: anElement bounds inSpace position)