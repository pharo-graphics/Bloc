translation
translate: aBounds in: aContainerBounds
	| h v |
	h := (horizontal directed: direction) translate: aBounds in: aContainerBounds.
	v := (vertical directed: direction) translate: aBounds in: aContainerBounds.
	^ h + v