geometry bounds
inParent
	<return: #BlElementBoundsInParent>

	self referenceElement hasParent
		ifFalse: [ ^ self ].

	^ BlElementBoundsInParent new
		originalElement: self originalElement;
		referenceElement: self referenceElement;
		bounds: (self referenceElement localBoundsToParent: self bounds copy);
		yourself