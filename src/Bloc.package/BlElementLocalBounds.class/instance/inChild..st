geometry bounds
inChild: anElement
	<return: #BlElementBounds>

	^ BlElementBoundsInChild new
		originalElement: self referenceElement;
		referenceElement: anElement;
		bounds: (anElement globalBoundsToMine: (BlBounds new left: 0 top: 0 corner: self extent) fromParent: self referenceElement);
		yourself