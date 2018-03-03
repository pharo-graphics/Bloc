measurement
measureSpan: aBrSpan of: aTextParagraph on: aCanvas with: aSpanMeasurer

	self
		assert: [ self text isEmpty or: [ self text isNotEmpty and: [ aBrSpan isNotEmpty ] ] ]
		description: [ 'Span must not be empty if original text is not empty' ].
	self
		assert: [ self text isNotEmpty or: [ self text isEmpty and: [ aBrSpan isEmpty ] ] ]
		description: [ 'Span must be empty if original text is empty' ].
	
	"initialize a span measurer with span, text paragraph and canvas"
	aSpanMeasurer
		span: aBrSpan
		of: aTextParagraph
		on: aCanvas.

	"// CONFIG: Switch my context by setting span and text run that we want to measure "
	self span: aBrSpan.
	self textRun: aSpanMeasurer textRun.

	[ self wantsMore ] whileTrue: [
		| aParagraphSpan |

		aParagraphSpan := self defaultParagraphSpan.
		aParagraphSpan measurer: aSpanMeasurer.

		aSpanMeasurer
			measure: self textRun
			from: self textRunStart
			to: aSpanMeasurer textRunLength
			width: self availableWidth.
		
		self textRunStart: aSpanMeasurer textRunStart.
		self textRunEnd: aSpanMeasurer textRunEnd.
		
		self
			assert: [ (self textRunStart isZero and: [ self textRunEnd isZero ]) or: [ self textRunStart > 0 ] ]
			description: [ 'If text run start is zero, then text end must be zero too' ].

		self spanStart: aSpanMeasurer spanStart.
		self spanEnd: aSpanMeasurer spanEnd.

		self initializeSpan: aParagraphSpan.
		aSpanMeasurer applyMetricsOn: aParagraphSpan.
		self pushSpan: aParagraphSpan ]