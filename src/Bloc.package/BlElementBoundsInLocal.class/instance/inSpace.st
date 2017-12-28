geometry bounds
inSpace
	<return: #BlElementBounds>

	^ BlElementBoundsInSpace new
		referenceElement: self referenceElement;
		bounds: (self localBoundsToSpace: self bounds copy);
		yourself