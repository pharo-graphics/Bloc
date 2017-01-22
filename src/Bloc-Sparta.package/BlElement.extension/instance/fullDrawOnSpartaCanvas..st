*Bloc-Sparta
fullDrawOnSpartaCanvas: aCanvas
	| aClippingBounds anEffectBounds needsTransformation aTransformationBuilder |
	
	anEffectBounds := self effectBounds: BlBounds new.
	"No need to render elements smaller than half of a pixel"
	(anEffectBounds width min: anEffectBounds height) < 1
		ifTrue: [ ^ self ].

	(aCanvas clip containsLocal: (self localBoundsToParent: anEffectBounds copy))
		ifFalse: [ ^ self ].

	self isVisible
		ifFalse: [ ^ self ].

	needsTransformation := (self position isZero and: [ transform isPureTranslation ]) not.
	needsTransformation ifTrue: [ 
		aTransformationBuilder := aCanvas transform
			push;
			translateBy: self position;
			multiplyBy: transform;
			apply ].

	aClippingBounds := (self visualBounds: BlBounds new on: aCanvas) merge: anEffectBounds.

	aCanvas clip
		push: aClippingBounds.

	[ self drawOnSpartaCanvas: aCanvas ] ensure: [
		"We should pop clip and transform in reversed exact order,
		otherwise backend transformation matrix may become broken"
		aCanvas clip pop.

		misc debug ifTrue: [
			self drawDebugInfoOnSpartaCanvas: aCanvas ].

		needsTransformation
			ifTrue: [ aTransformationBuilder pop ] ]