paragraph - measuring
measureOn: aCanvas with: aSpanMeasurer
	"Measure and create lines with text spans from provided rope
	based on attributes and layout properties (maximum width / height)"
	| anIterator aMeasurer |

	aMeasurer := self createMeasurer.

	(self text isEmpty) ifTrue: [ 
		aMeasurer
			measureSpan: (BlSpan text: self text empty attributes: #())
			of: self
			on: aCanvas
			with: aSpanMeasurer ].

	anIterator := text iterator.
	[ anIterator hasNext and: [ line isEmpty or: [ aMeasurer hasAvailableSpace ] ] ] whileTrue: [ 
		"If we pass #hasNext check we will definitely move to the next span,
		so can do the same with position"
		aMeasurer movePosition: anIterator position.
		aMeasurer
			measureSpan: anIterator nextSpan
			of: self
			on: aCanvas
			with: aSpanMeasurer ].

	"measurer creates a line with baseline set to 0@0"
	line := aMeasurer line.
	end := line to