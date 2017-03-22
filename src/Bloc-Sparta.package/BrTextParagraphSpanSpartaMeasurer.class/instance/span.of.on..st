initialization
span: aBrSpan of: aTextParagraph on: aSpartaCanvas
	"Prepare and configure me for a given text span within a paragraph"
	| aTextPainter |

	aTextPainter := aTextParagraph
		createSpartaTextPainter: aBrSpan
		on: aSpartaCanvas.

	textRun := aTextPainter textRun.
	
	self
		assert: [ textRun isNull not ]
		description: [ 'Created text run must not be nullptr' ].
	
	aTextParagraph wantsAutoRelease
		ifTrue: [ textRun autoRelease ].

	textRunIterator := textRun iterator.
	metrics := aTextPainter metrics.