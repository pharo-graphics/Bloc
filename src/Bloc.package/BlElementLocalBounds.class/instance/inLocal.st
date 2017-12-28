geometry bounds
inLocal
	<return: #BlElementBounds>

	^ BlElementComputedBounds new
		referenceElement: self referenceElement;
		bounds: (BlBounds new left: 0 top: 0 corner: self extent);
		yourself