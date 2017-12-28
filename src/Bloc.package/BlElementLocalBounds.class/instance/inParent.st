geometry bounds
inParent
	<return: #BlElementBounds>
	
	^ BlElementBoundsInParent new
		originalElement: self referenceElement;
		referenceElement: self referenceElement;
		bounds: (self localBoundsToParent: (BlBounds new left: 0 top: 0 corner: self extent));
		yourself