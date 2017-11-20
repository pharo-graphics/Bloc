*Bloc-Sparta
drawOnSpartaCanvas: aCanvas
	| theAttributes aTextPainter |

	theAttributes := self attributes.

	aTextPainter := aCanvas text.
	theAttributes
		do: [ :anAttribute |
			anAttribute drawBelowOnSpartaCanvas: aCanvas with: self.
			anAttribute applyOnSpartaTextPainter: aTextPainter with: self ].

	aTextPainter
		text: self textRun;
		start: self textRunStart;
		end: self textRunEnd;
		baseline: self baseline;
		draw.

	"And finally let attributes to render above the text"
	theAttributes do: [ :anAttribute |
		anAttribute drawAboveOnSpartaCanvas: aCanvas with: self ]