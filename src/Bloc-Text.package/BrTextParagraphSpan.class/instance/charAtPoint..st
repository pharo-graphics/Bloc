geometry
charAtPoint: aPoint
	<return: #Number>
	| aWidth aMeasurer aSpanIndex aTextRunIndex aTextRunWidth |

	aWidth := (aPoint x - self origin x) max: 0.
	aMeasurer := self measurer.

	aMeasurer
		reset;
		measure: self textRun
		from: self textRunStart
		to: self textRunEnd
		width: aWidth.
	
	"how many complete glyphs fit or 1 if none"
	aTextRunIndex := aMeasurer textRunEnd.
	
	"their width"
	aTextRunWidth := aMeasurer width.
	aSpanIndex := aMeasurer spanEnd.
	
	aTextRunIndex = self textRunEnd
		ifTrue: [ ^ self from + aSpanIndex - 1 ].

	aMeasurer
		reset;
		measure: self textRun
		from: aTextRunIndex + 1
		to: aTextRunIndex + 1
		width: Float infinity.

	aSpanIndex := aWidth < (aTextRunWidth - (aMeasurer width / 2.0))
		ifTrue: [ aSpanIndex - 1 ]
		ifFalse: [ aWidth > (aTextRunWidth + (aMeasurer width / 2.0))
			ifTrue: [ aSpanIndex + 1 ]
			ifFalse: [ aSpanIndex ] ].
	
	^ self from + aSpanIndex - 1