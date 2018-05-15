layout
onMeasure: anExtentMeasurementSpec
	super onMeasure: anExtentMeasurementSpec.
	(self measuredWidth isZero not and: [self paragraph width > self measuredWidth]) ifTrue: [				 
		| dotsParagraph cutSubText toPosition |
		dotsParagraph := self defaultTextParagraph.
		dotsParagraph text: '...' asRopedText.
		dotsParagraph measureOn: self defaultOffscreenCanvas.
		toPosition := self paragraph indexAtPosition: (self measuredWidth - (dotsParagraph width)) - 1 @ 1.
		toPosition >=1 ifTrue: [
			cutSubText := self originalText copy from: 1 to: toPosition.
			text := cutSubText insertString: '...' at: cutSubText size.
			paragraph := nil.
			super onMeasure: anExtentMeasurementSpec ] ]