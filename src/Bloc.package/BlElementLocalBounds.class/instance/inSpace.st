geometry bounds
inSpace
	<return: #BlElementBounds>
	| anElementBounds |
	anElementBounds := self inLocal.
	anElementBounds referenceElement hasParent
		ifFalse: [ self localBoundsToParent: anElementBounds bounds ].
	^ anElementBounds inSpace