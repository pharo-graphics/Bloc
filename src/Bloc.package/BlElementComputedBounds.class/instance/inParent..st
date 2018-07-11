geometry bounds
inParent: anElement
	<return: #BlElementBounds>
	| subParent |
	
	subParent := self referenceElement.
	self referenceElement withParentsDo: [ :aParentElement |
		(aParentElement hasParent and: [ aParentElement parent == anElement ])
			ifTrue: [ subParent := aParentElement ] ].

	^ BlElementBoundsInParent new
		originalElement: self referenceElement;
		referenceElement: subParent;
		bounds: (anElement localBoundsToMine: self bounds copy fromChild: self referenceElement);
		yourself