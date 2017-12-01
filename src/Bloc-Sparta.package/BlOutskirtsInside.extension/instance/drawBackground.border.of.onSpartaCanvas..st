*Bloc-Sparta
drawBackground: aBackgroundBlock border: aBorderBlock of: anElement onSpartaCanvas: aCanvas

	"draw background"
	aBackgroundBlock value.

	anElement border isTransparent
		ifTrue: [ ^ self ].

	aCanvas clip
		by: (anElement pathCache geomPathOnSpartaCanvas: aCanvas)
		during: [ aBorderBlock value ]