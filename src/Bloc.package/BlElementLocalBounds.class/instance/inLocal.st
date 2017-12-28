geometry bounds
inLocal
	<return: #BlElementBounds>

	^ BlElementBoundsInLocal new
		referenceElement: self referenceElement;
		bounds: (BlBounds new left: 0 top: 0 corner: self extent);
		yourself