layout
onMeasure: anExtentMeasurementSpec
	super onMeasure: anExtentMeasurementSpec.
	(self measuredWidth isZero not and: [self paragraph width > self measuredWidth]) ifTrue: [				 
		| dotsParagraph cutSubText |
		dotsParagraph := self defaultTextParagraph.
		dotsParagraph text: '...' asRopedText.
		dotsParagraph measureOn: self defaultOffscreenCanvas.
		cutSubText := self originalText copy
			from: 1
			to: (self paragraph indexAtPosition: (self measuredWidth - (dotsParagraph width)) - 1 @ 1).
		text := cutSubText insertString: '...' at: cutSubText size.
		paragraph := nil.
		super onMeasure: anExtentMeasurementSpec ]