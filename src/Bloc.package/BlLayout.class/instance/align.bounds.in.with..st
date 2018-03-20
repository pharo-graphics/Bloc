private - alignment
align: anElement bounds: elementBounds in: theParentBounds with: aBlElementAlignment
	"I don't additionally take element margin or parent padding"
	| aTranslation alignment |
	
	"a composite alignment"
	alignment := aBlElementAlignment directed: self direction.
	aTranslation := alignment translationOf: elementBounds in: theParentBounds.

	aTranslation x isZero
		ifTrue: [ aTranslation := theParentBounds left @ aTranslation y ].
	aTranslation y isZero
		ifTrue: [ aTranslation := aTranslation x @ theParentBounds top ].

	^ elementBounds translateBy: aTranslation