instance creation
nearestTo: aNearestElement from: aReferenceElement
	<return: #BlNearestPositionAnchor>

	^ self new
		referenceElement: aReferenceElement;
		nearestToElement: aNearestElement