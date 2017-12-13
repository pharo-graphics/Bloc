layout
onMeasure: anExtentMeasurementSpec
	super onMeasure: anExtentMeasurementSpec.
	(self measuredWidth isZero not and: [self paragraph width > self measuredWidth]) ifTrue: [				 
		| dotsParagraph cutString |
		dotsParagraph := self defaultTextParagraph.
		dotsParagraph text: '...' asRopedText.
		dotsParagraph measureOn: self defaultOffscreenCanvas.
		cutString := self originalText 
			copyFrom: 1
			to: (self paragraph indexAtPosition: (self measuredWidth - (dotsParagraph width)) - 1 @ 1).
		self text: (cutString, '...') asRopedText.
		super onMeasure: anExtentMeasurementSpec ]
