measurement
measureSpan: aBrSpan of: aTextParagraph on: aCanvas with: aSpanMeasurer

	self
		assert: [ self text isEmpty or: [ self text isNotEmpty and: [ aBrSpan isNotEmpty ] ] ]
		description: [ 'Span must not be empty if original text is not empty' ].
	self
		assert: [ self text isNotEmpty or: [ self text isEmpty and: [ aBrSpan isEmpty ] ] ]
		description: [ 'Span must be empty if original text is empty' ].
	
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
		self hasTransformation
			ifTrue: [ aParagraphSpan
				transformation: self transformation
				inverted: self inverseTransformation ].
		
		aParagraphSpan measurer: aSpanMeasurer.

		aSpanMeasurer
			measure: self textRun
			from: self textRunStart
			to: Float infinity
			width: self transformedAvailableWidth.

		aSpanMeasurer applyMetricsOn: aParagraphSpan.
		
		self textRunStart: aSpanMeasurer textRunStart.
		self textRunEnd: aSpanMeasurer textRunEnd.

		self spanStart: aSpanMeasurer spanStart.
		self spanEnd: aSpanMeasurer spanEnd.

		self pushSpan: aParagraphSpan ]