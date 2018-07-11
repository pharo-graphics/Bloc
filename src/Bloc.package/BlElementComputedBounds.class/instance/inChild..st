geometry bounds
inChild: anElement
	<return: #BlElementBounds>

	^ BlElementBoundsInChild new
		originalElement: self originalElement;
		referenceElement: anElement;
		bounds: (anElement globalBoundsToMine: self bounds copy fromParent: self referenceElement);
		yourself