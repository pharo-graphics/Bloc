geometry bounds
inParent
	<return: #BlElementBoundsInParent>

	self referenceElement hasParent
		ifFalse: [ ^ self ].

	^ BlElementBoundsInParent new
		originalElement: self originalElement;
		referenceElement: self referenceElement parent;
		bounds: (self referenceElement parent localBoundsToParent: self bounds copy);
		yourself