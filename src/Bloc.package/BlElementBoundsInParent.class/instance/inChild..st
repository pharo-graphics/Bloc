geometry bounds
inChild: anElement
	<return: #BlElementBounds>
	| aParentElement |
	
	aParentElement := self referenceElement hasParent
		ifTrue: [ self referenceElement parent ]
		ifFalse: [ self referenceElement ].

	^ BlElementBoundsInChild new
		originalElement: self originalElement;
		referenceElement: anElement;
		bounds: (anElement globalBoundsToMine: self bounds copy fromParent: aParentElement);
		yourself