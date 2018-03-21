*Bloc-Sparta
drawBackground: aBackgroundBlock border: aBorderBlock of: anElement onSpartaCanvas: aCanvas

	"draw background"
	
	aCanvas clip
		when: [ anElement border isTransparent not ]
		by:  [ anElement geometry pathOnSpartaCanvas: aCanvas ]
		during: [
			aBackgroundBlock value.
			anElement border isTransparent
				ifFalse: [ aBorderBlock value ] ]