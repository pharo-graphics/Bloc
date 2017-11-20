*Bloc-Sparta
fullDrawOnSpartaCanvas: aCanvas
	| anEffectBounds |

	"We do not draw transparent elements at all"
	self isTransparent
		ifTrue: [ ^ self ].

	"invisible elements are not rendered too"
	self isVisible
		ifFalse: [ ^ self ].
	
	anEffectBounds := self effectBounds: BlBounds new.
	"No need to render elements smaller than half of a pixel"
	(anEffectBounds width min: anEffectBounds height) < 1
		ifTrue: [ ^ self ].

	(aCanvas clip containsLocal: (self localBoundsToParent: anEffectBounds copy))
		ifFalse: [ ^ self ].

	aCanvas layer
		alpha: self opacity;
		when: [ self isTranslucent ]
		during: [
			aCanvas transform
				by: self transformation
				translated: self position
				during: [ :aTransformedCanvas |
					aTransformedCanvas clip
						when: [ self clipChildren ]
						by: [ (self visualBounds: BlBounds new on: aTransformedCanvas) merge: anEffectBounds ]
						during: [
							self effect
								applyEffectOnSpartaCanvas: aTransformedCanvas
								for: self
								around: [ self drawMeAndChildrenOnSpartaCanvas: aTransformedCanvas ] ].
						misc debug ifTrue: [
							self drawDebugInfoOnSpartaCanvas: aTransformedCanvas ] ] ]