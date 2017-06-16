*Bloc-Sparta
drawBackground: aBackgroundBlock border: aBorderBlock of: anElement onSpartaCanvas: aCanvas

	"draw background"
	aBackgroundBlock value.

	anElement border isTransparent
		ifTrue: [ ^ self ].

	"remove background where we will draw border"
	aCanvas stroke
		in: [ :Painter | anElement border style applyOn: Painter ];
		path: (anElement pathCache geomPathOnSpartaCanvas: aCanvas);
		width: anElement border width;
		paint: Color white;
		drawOptions: (aCanvas drawOptions composeDestOut; antialiasGray);
		draw.

	"draw border"
	aBorderBlock value