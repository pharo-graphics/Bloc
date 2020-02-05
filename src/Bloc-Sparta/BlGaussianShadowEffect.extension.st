Extension { #name : #BlGaussianShadowEffect }

{ #category : #'*Bloc-Sparta' }
BlGaussianShadowEffect >> applyBeforeOnSpartaCanvas: aSpartaCanvas for: anElement [
	aSpartaCanvas stroke
		path: (anElement geometry pathOnSpartaCanvas: aSpartaCanvas);
		paint: (aSpartaCanvas paint boxShadow
			color: color;
			offset: offset;
			radius: width);
		width: width;
		draw
]
