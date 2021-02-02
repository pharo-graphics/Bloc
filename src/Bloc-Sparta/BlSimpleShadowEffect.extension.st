Extension { #name : #BlSimpleShadowEffect }

{ #category : #'*Bloc-Sparta' }
BlSimpleShadowEffect >> applyBeforeOnSpartaCanvas: aSpartaCanvas for: anElement [
	| anExtraShadowSpace aShadowPath |

	anExtraShadowSpace := self extraShadowSpace.
	aShadowPath := anElement geometry pathOnSpartaCanvas: aSpartaCanvas of: anElement.

	aSpartaCanvas transform
		by: [ :t | t translateBy: anExtraShadowSpace + self offset ]
		during: [
			aSpartaCanvas fill
				paint: self color;
				path: aShadowPath;
				draw ]
]
