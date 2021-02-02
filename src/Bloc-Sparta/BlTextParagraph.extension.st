Extension { #name : #BlTextParagraph }

{ #category : #'*Bloc-Sparta' }
BlTextParagraph >> createSpartaTextPainter: aBrSpan on: aSpartaCanvas [
	"I create and return a sparta text painter for given span (BrRope) and sparta canvas.
	Additionally I also initialize a corresponding font group according to span's attributes.
	Note: I assume that a given rope is homogeneous of type character; every item has the same attributes and type"

	<return: #SpartaTextPainter>
	| aFontBuilder aTextPainter theAttributes |
	theAttributes := aBrSpan attributes.
	aTextPainter := aSpartaCanvas text.
	aFontBuilder := aSpartaCanvas font.
	theAttributes
		do: [ :anAttribute | 
			anAttribute applyOnSpartaFontBuilder: aFontBuilder.
			anAttribute applyOnSpartaTextPainter: aTextPainter ].
	aTextPainter font: aFontBuilder build.
	aTextPainter
		string:
			(String
				streamContents: [ :aStream | aBrSpan do: [ :anItem | anItem textRunOn: aStream ] ]).
	^ aTextPainter
]

{ #category : #'*Bloc-Sparta' }
BlTextParagraph >> drawOnSpartaCanvas: aCanvas [
	self subclassResponsibility
]
