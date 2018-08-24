Extension { #name : #BrTextParagraph }

{ #category : #'*Bloc-Sparta' }
BrTextParagraph >> createSpartaTextPainter: aBrSpan on: aSpartaCanvas [
	"I create and return a sparta text painter for given span (BrRope) and sparta canvas.
	Additionally I also initialize a corresponding font group according to span's attributes.
	Note: I assume that a given rope is homogeneous of type character; every item has the same attributes and type"
	<return: #SpartaTextPainter>
	| aFontBuilder aTextPainter theAttributes |

	theAttributes := aBrSpan attributes.

	aTextPainter := aSpartaCanvas text.
	aFontBuilder := aSpartaCanvas font.

	theAttributes do: [ :anAttribute |
		anAttribute applyOnSpartaFontBuilder: aFontBuilder with: aBrSpan.
		anAttribute applyOnSpartaTextPainter: aTextPainter with: aBrSpan ].

	aTextPainter font: aFontBuilder build.
	aTextPainter string: (String streamContents: [ :aStream |
		aBrSpan do: [ :aChar |
			aChar = Character tab
				ifTrue: [ self tabWidth timesRepeat: [ aStream nextPut: Character space ] ]
				ifFalse: [ aStream nextPut: aChar ] ] ]).
	^ aTextPainter
]

{ #category : #'*Bloc-Sparta' }
BrTextParagraph >> drawOnSpartaCanvas: aCanvas [
	self subclassResponsibility
]

{ #category : #'*Bloc-Sparta' }
BrTextParagraph >> measureOnSpartaCanvas: aSpartaCanvas [
	self subclassResponsibility
]
