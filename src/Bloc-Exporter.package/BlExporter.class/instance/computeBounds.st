private
computeBounds
	<return: #BlBounds>
	| anElement aBoundsInLocal aBoundsInParent |
	
	anElement := self element.
	
	aBoundsInLocal := (anElement effectBounds: BlBounds new)
		merge: anElement boundsInLocal;
		merge: anElement visualBounds.

	aBoundsInParent := anElement localBoundsToParent: aBoundsInLocal copy.
	
	^ aBoundsInParent