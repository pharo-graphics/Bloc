*Bloc-Sparta
createSpartaTextPainter: aBrSpan on: aSpartaCanvas
	"I create and return a sparta text painter for given span (BrRope) and sparta canvas.
	Additionally I also initialize a corresponding font group according to span's attributes.
	Note: I assume that a given rope is homogeneous of type character; every item has the same attributes and type"
	<return: #SpartaTextPainter>
	| aFontBuilder aTextPainter theAttributes |

	theAttributes := aBrSpan attributes.

	aTextPainter := aSpartaCanvas text.
	aFontBuilder := aSpartaCanvas font.

	theAttributes do: [ :anAttribute |
		anAttribute applyOnFont: aFontBuilder with: aBrSpan.
		anAttribute applyOnText: aTextPainter with: aBrSpan ].

	aTextPainter font: aFontBuilder build.
	aTextPainter string: (String new: aBrSpan size streamContents: [ :aStream | aStream nextPutAll: aBrSpan asString ]).

	^ aTextPainter