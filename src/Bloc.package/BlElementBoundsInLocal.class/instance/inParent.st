geometry bounds
inParent
	<return: #BlElementBounds>

	^ BlElementBoundsInParent new
		originalElement: self referenceElement;
		referenceElement: self referenceElement;
		bounds: (self localBoundsToParent: self bounds copy);
		yourself