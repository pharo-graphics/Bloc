Extension { #name : #BlOutskirtsCentered }

{ #category : #'*Bloc-Sparta' }
BlOutskirtsCentered >> drawBackground: aBackgroundBlock border: aBorderBlock of: anElement onSpartaCanvas: aCanvas [

	"draw background"
	aBackgroundBlock value.

	"draw border"
	aBorderBlock value
]

{ #category : #'*Bloc-Sparta' }
BlOutskirtsCentered >> drawBorder: aBlBorder onSpartaCanvas: aCanvas of: anElement [
	"Draw a border centered in a given element on a provided Sparta Canvas"

	aCanvas stroke
		alpha: aBlBorder opacity;
		paint: aBlBorder paint;
		path: (anElement geometry pathOnSpartaCanvas: aCanvas);
		width: aBlBorder width;
		in: [ :aPainter | aBlBorder style applyOn: aPainter ];
		draw
]
