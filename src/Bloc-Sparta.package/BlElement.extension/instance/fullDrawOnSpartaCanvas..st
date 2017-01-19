*Bloc-Sparta
fullDrawOnSpartaCanvas: aCanvas
	| aClippingBounds anEffectBounds |
	
	anEffectBounds := self effectBounds: SpartaRectangle new.
	"No need to render elements smaller than half of a pixel"
	(anEffectBounds width min: anEffectBounds height) < 1
		ifTrue: [ ^ self ].

	(aCanvas clip containsLocal: (self localBoundsToParent: anEffectBounds copy))
		ifFalse: [ ^ self ].

	self isVisible
		ifFalse: [ ^ self ].

	aCanvas transform
		push;
		translateBy: self position;
		multiplyBy: self transform;
		apply.

	aClippingBounds := (self visualBounds: SpartaRectangle new on: aCanvas) merge: anEffectBounds.

	aCanvas clip
		push: aClippingBounds.

	[ self drawOnSpartaCanvas: aCanvas ] ensure: [
		"We should pop clip and transform in reversed exact order,
		otherwise backend transformation matrix may become broken"
		aCanvas clip pop.

		misc debug ifTrue: [
			self drawDebugInfoOnSpartaCanvas: aCanvas ].

		aCanvas transform pop ]