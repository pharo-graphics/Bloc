Extension { #name : #BlBlurEffect }

{ #category : #'*Bloc-Sparta' }
BlBlurEffect >> applyOnSpartaCanvas: aSpartaCanvas for: anElement [
	| anEffectBounds aWindowScale |

	anEffectBounds := anElement localBoundsToWindow: (anElement effectBounds: BlBounds new).

	aWindowScale := anElement isAttachedToSceneGraph
		ifTrue: [ anElement space windowScale ]
		ifFalse: [ 1 ].
	
	aSpartaCanvas clip
		by: (anElement geometry pathOnSpartaCanvas: aSpartaCanvas)
		during: [
			aSpartaCanvas transform
				by: [ :t | t scaleBy: 1.0 / aWindowScale ]
				during: [
					aSpartaCanvas filter
						area: anEffectBounds; "source in device window coordinates"
						to: 0@0; "destination in local coordinates of canvas"
						type: (aSpartaCanvas gaussianBlurFilter
							stdDeviation: self radius;
							source: aSpartaCanvas);
						draw ] ]
]
