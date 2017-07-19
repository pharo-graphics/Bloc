measurement
measure: aTextRun from: aTextRunStart to: aTextRunEnd width: aWidth
	| aSpanIterator currentEnd actualEnd |
	"Measure a given text run from provided start to the end indices limiting available with to aWidth"

	metrics width: aWidth.
	metrics start: aTextRunStart.
	metrics length: aTextRunEnd - aTextRunStart + 1.

	aTextRun measureOn: metrics.

	textRunStart := aTextRunStart.
	textRunEnd := metrics wrappedEnd.

	spanStart := textRunIterator position.
	textRunIterator skipUnits: textRunEnd - textRunStart + 1.
	spanEnd := textRunIterator position.
	
	aSpanIterator := textSpan iterator: spanStart to: textSpan size.
	currentEnd := spanStart.
	actualEnd := spanStart.
	[ aSpanIterator hasNext and: [ currentEnd < spanEnd ] ]
		whileTrue: [ (aSpanIterator next = Character tab)
			ifTrue: [ currentEnd := currentEnd + textParagraph tabWidth ]
			ifFalse: [ currentEnd := currentEnd + 1 ].
			actualEnd := actualEnd + 1 ].
		
	spanEnd := actualEnd - 1