Extension { #name : #BlDropShadowEffect }

{ #category : #'*Bloc-Sparta' }
BlDropShadowEffect >> applyBeforeOnSpartaCanvas: aSpartaCanvas for: anElement [
	| anEffectExtent anExtraShadowSpace aShadowPath |

	anEffectExtent := anElement effectBounds extent.
	anExtraShadowSpace := self extraShadowSpace.
	aShadowPath := anElement geometry pathOnSpartaCanvas: aSpartaCanvas.

	"state is not valid, recreate caches and redraw"
	(session ~~ Smalltalk session or: [ cachedSurface isNil or: [ cachedPath ~= aShadowPath ] ]) ifTrue: [
		| aShadowCanvas aCacheCanvas |
		
		aShadowCanvas := aSpartaCanvas similar: anEffectExtent.	
		aShadowCanvas transform
			by: [ :t | t translateBy: anExtraShadowSpace ]
			during: [
				aShadowCanvas fill
					paint: self color;
					path: aShadowPath;
					draw ].
		aCacheCanvas := aSpartaCanvas similar: anEffectExtent.
		aCacheCanvas filter
			area: aShadowCanvas bounds;
			type: (aShadowCanvas gaussianBlurFilter
				stdDeviation: (self width max: 0);
				source: aShadowCanvas);
			draw.

		cachedSurface := aCacheCanvas surface.
		cachedPath := aShadowPath.
		session := Smalltalk session.
		
		aShadowCanvas release.
		aCacheCanvas release ].

	aSpartaCanvas fill
		paint: cachedSurface;
		path: (cachedSurface bounds translateBy: anExtraShadowSpace asPoint negated + self offset);
		draw
]
