*Bloc-Sparta
fullDrawOnSpartaCanvas: aCanvas
	| anEffectBounds |

	"We do not draw transparent elements at all"
	self isTransparent
		ifTrue: [ ^ self ].

	"invisible elements are not rendered too"
	self isVisible
		ifFalse: [ ^ self ].
	
	aCanvas layer
		alpha: self opacity;
		when: [ self isTranslucent ]
		during: [

			anEffectBounds := self effectBounds: BlBounds new.
			"No need to render elements smaller than half of a pixel"
			(anEffectBounds width min: anEffectBounds height) < 1
				ifTrue: [ ^ self ].

			(aCanvas clip containsLocal: (self localBoundsToParent: anEffectBounds copy))
				ifFalse: [ ^ self ].

			aCanvas transform
				by: self transform
				translated: self position
				during: [

					aCanvas clip
						when: [ self clipChildren ]
						by: [ (self visualBounds: BlBounds new on: aCanvas) merge: anEffectBounds ]
						during: [
							self effect
								applyEffectOnSpartaCanvas: aCanvas
								for: self
								around: [ 
									self drawOnSpartaCanvas: aCanvas.
									self drawChildrenOnSpartaCanvas: aCanvas ] ].
						misc debug ifTrue: [
							self drawDebugInfoOnSpartaCanvas: aCanvas ] ] ]