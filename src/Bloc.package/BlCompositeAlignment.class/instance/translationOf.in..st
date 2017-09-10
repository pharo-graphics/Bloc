translation
translationOf: aBounds in: aContainerBounds
	| h v |
	h := (horizontal directed: direction) translationOf: aBounds in: aContainerBounds.
	v := (vertical directed: direction) translationOf: aBounds in: aContainerBounds.
	^ h + v