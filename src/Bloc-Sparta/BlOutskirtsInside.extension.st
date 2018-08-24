Extension { #name : #BlOutskirtsInside }

{ #category : #'*Bloc-Sparta' }
BlOutskirtsInside >> drawBackground: aBackgroundBlock border: aBorderBlock of: anElement onSpartaCanvas: aCanvas [

	"draw background"
	
	aCanvas clip
		when: [ anElement border isTransparent not ]
		by:  [ anElement geometry pathOnSpartaCanvas: aCanvas ]
		during: [
			aBackgroundBlock value.
			anElement border isTransparent
				ifFalse: [ aBorderBlock value ] ]
]

{ #category : #'*Bloc-Sparta' }
BlOutskirtsInside >> drawBorder: aBlBorder onSpartaCanvas: aCanvas of: anElement [
	"Draw a border inside of a given element on a provided Sparta Canvas"

	aCanvas stroke
		alpha: aBlBorder opacity;
		paint: aBlBorder paint;
		path: (anElement geometry pathOnSpartaCanvas: aCanvas);
		width: aBlBorder width * 2.0;	 "we draw inside, so should multiply width by 2"
		in: [ :aPainter | aBlBorder style applyOn: aPainter ];
		draw
]
