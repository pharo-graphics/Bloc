Extension { #name : #BlOverlayEffect }

{ #category : #'*Bloc-Sparta' }
BlOverlayEffect >> applyOnSpartaCanvas: aSpartaCanvas for: anElement [
	aSpartaCanvas fill
		path: anElement effectBounds;
		paint: self paint;
		draw
]
