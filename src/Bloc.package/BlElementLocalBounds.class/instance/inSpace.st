geometry bounds
inSpace
	<return: #BlElementBounds>
	
	^ BlElementBoundsInSpace new
		referenceElement: self referenceElement;
		bounds: (self localBoundsToSpace: (BlBounds new left: 0 top: 0 corner: self extent));
		yourself