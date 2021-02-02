Extension { #name : #BlOutskirtsOutside }

{ #category : #'*Bloc-Sparta' }
BlOutskirtsOutside >> drawBackground: aBackgroundBlock border: aBorderBlock of: anElement onSpartaCanvas: aCanvas [

	"If border is transparent there is no need to render it"
	anElement border isTransparent
		ifFalse: [
			"draw order"
			aBorderBlock value.

			"remove parts of the border where we will draw background"	
			aCanvas clip
				by: (anElement geometry pathOnSpartaCanvas: aCanvas of: anElement)
				during: [
					aCanvas fill
						path: (anElement geometry pathOnSpartaCanvas: aCanvas of: anElement);
						paint: Color white;
						drawOptions: (aCanvas drawOptions composeDestOut; antialiasGray);
						draw ] ].

	"draw background"
	aBackgroundBlock value
]

{ #category : #'*Bloc-Sparta' }
BlOutskirtsOutside >> drawBorder: aBlBorder onSpartaCanvas: aCanvas of: anElement [
	"Draw a border outside of a given element on a provided Sparta Canvas"

	aCanvas stroke
		alpha: aBlBorder opacity;
		paint: aBlBorder paint;
		path: (anElement geometry pathOnSpartaCanvas: aCanvas of: anElement);
		width: aBlBorder width * 2.0;	 "we draw outside, so should multiply width by 2"
		in: [ :aPainter | aBlBorder style applyOn: aPainter ];
		draw
]
