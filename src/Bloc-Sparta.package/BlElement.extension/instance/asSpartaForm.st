*Bloc-Sparta
asSpartaForm
	| aCanvas aBoundsInParent aBoundsInLocal |

	self forceLayout.

	aBoundsInLocal := (self effectBounds: BlBounds new)
		merge: self boundsInLocal;
		merge: self visualBounds.

	aBoundsInParent := self localBoundsToParent: aBoundsInLocal copy.

	aCanvas := Bloc preferableSpartaCanvas extent: (aBoundsInParent extent max: 1@1).

	aCanvas transform during: [ :aTransform |
		aTransform
			translateBy: (aBoundsInParent origin) negated;
			apply.
		self fullDrawOnSpartaCanvas: aCanvas ].

	^ aCanvas asForm