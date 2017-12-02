instance creation
element: anElement
	<return: #BlAnchorRelativeToElement>

	^ self new
		referenceElement: anElement;
		yourself