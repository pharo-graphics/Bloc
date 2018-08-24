Extension { #name : #BlBlurEffect }

{ #category : #'*Bloc-Sparta' }
BlBlurEffect >> applyOnSpartaCanvas: aSpartaCanvas for: anElement [
	| anEffectBounds aWindowScale skipTransformation |

	anEffectBounds := anElement localBoundsToWindow: (anElement effectBounds: BlBounds new).

	aWindowScale := anElement isAttachedToSceneGraph
		ifTrue: [ anElement space windowScale ]
		ifFalse: [ 1 ].
	
	"check if we may skip transformation"
	skipTransformation := aWindowScale = 1 or: [ aWindowScale x = 1 and: [ aWindowScale y = 1 ] ].
	
	aSpartaCanvas clip by: (anElement geometry pathOnSpartaCanvas: aSpartaCanvas) during: [
		skipTransformation ifFalse: [ 
			aSpartaCanvas transform
				push;
				scaleBy: 1.0 / aWindowScale;	"window scale is never 0"
				apply ].
	
		aSpartaCanvas filter
			area: anEffectBounds; "source in device window coordinates"
			to: 0@0; "destination in local coordinates of canvas"
			type: (aSpartaCanvas gaussianBlurFilter
				stdDeviation: self radius;
				source: aSpartaCanvas);
			draw.

		skipTransformation
			ifFalse: [ aSpartaCanvas transform pop ] ].
]
