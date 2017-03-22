measurement
measure: aTextRun from: aTextRunStart to: aTextRunEnd width: aWidth
	"Measure a given text run from provided start to the end indices limiting available with to aWidth"

	metrics width: aWidth.
	metrics start: aTextRunStart.
	metrics length: aTextRunEnd - aTextRunStart + 1.

	aTextRun measureOn: metrics.

	textRunStart := aTextRunStart.
	textRunEnd := metrics wrappedEnd.
	
	spanStart := textRunIterator position.
	textRunIterator skipUnits: textRunEnd - textRunStart + 1.
	spanEnd := textRunIterator position - 1