*Bloc-Sparta
drawBackground: aBackgroundBlock border: aBorderBlock of: anElement onSpartaCanvas: aCanvas

	"draw background"
	aBackgroundBlock value.

	anElement border isTransparent
		ifTrue: [ ^ self ].

	aCanvas clip
		by: (anElement geometry pathOnSpartaCanvas: aCanvas)
		during: [ aBorderBlock value ]