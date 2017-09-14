*Bloc-SVG
translatedBy: aSVGFactory withParent: parentElement
	| translatedElement |
	translatedElement := aSVGFactory generateElementFrom: self.
	self shouldBeAddedToParent
		ifTrue: [ parentElement addChild: translatedElement ].
	^ translatedElement