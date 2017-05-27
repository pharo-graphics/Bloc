*Bloc-Sparta
fullDrawOnSpartaCanvas: aCanvas
	| aClippingBounds anEffectBounds needsTransformation aTransformationBuilder isTranslucent |

	"We do not draw transparent elements at all"
	self isTransparent
		ifTrue: [ ^ self ].

	"invisible elements are not rendered too"
	self isVisible
		ifFalse: [ ^ self ].
	
	isTranslucent := self isTranslucent.	
	
	[ isTranslucent
			ifTrue: [
				aCanvas layer
					alpha: self opacity;
					push ].
	
	anEffectBounds := self effectBounds: BlBounds new.
	"No need to render elements smaller than half of a pixel"
	(anEffectBounds width min: anEffectBounds height) < 1
		ifTrue: [ ^ self ].

	(aCanvas clip containsLocal: (self localBoundsToParent: anEffectBounds copy))
		ifFalse: [ ^ self ].

	needsTransformation := (self position isZero and: [ transform isIdentity ]) not.
	needsTransformation ifTrue: [ 
		aTransformationBuilder := aCanvas transform
			push;
			translateBy: self position;
			multiplyBy: transform;
			apply ].

	self clipChildren ifTrue: [
		aClippingBounds := (self visualBounds: BlBounds new on: aCanvas) merge: anEffectBounds.
		aCanvas clip push: aClippingBounds ].

	[ self effect
		applyEffectOnSpartaCanvas: aCanvas
		for: self
		around: [ 
			self drawOnSpartaCanvas: aCanvas.
			self drawChildrenOnSpartaCanvas: aCanvas ] ] ensure: [
		"We should pop clip and transform in reversed exact order,
		otherwise backend transformation matrix may become broken"
		self clipChildren ifTrue: [ aCanvas clip pop ].

		misc debug ifTrue: [
			self drawDebugInfoOnSpartaCanvas: aCanvas ].

		needsTransformation
			ifTrue: [ aTransformationBuilder pop ] ] ]
	ensure: [ 
		isTranslucent ifTrue: [ aCanvas layer pop ] ].