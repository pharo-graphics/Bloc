private - alignment
align: anElement bounds: elementBounds in: theParentBounds with: aBlElementAlignment
	| aTranslation alignment allowedBounds |
	
	"take margin into account"
	allowedBounds := anElement margin inset: theParentBounds.
	
	"a composite alignment"
	alignment := aBlElementAlignment directed: self direction.
	aTranslation := alignment translationOf: elementBounds in: allowedBounds.

	aTranslation x isZero
		ifTrue: [ aTranslation := allowedBounds left @ aTranslation y ].
	aTranslation y isZero
		ifTrue: [ aTranslation := aTranslation x @ allowedBounds top ].

	^ elementBounds translateBy: aTranslation