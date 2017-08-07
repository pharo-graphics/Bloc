geometry
indexAtPosition: aPoint
	<return: #Number>
	| aWidth aMeasurer |

	aWidth := (aPoint x - self origin x) max: 0.
	aMeasurer := self measurer.
	
	(aWidth <= 0)
		ifTrue: [ ^ self from - 1 ].
	(aWidth >= self width)
		ifTrue: [ ^ self to ].

	^ (self textRunStart to: self textRunEnd)
		findBinary: [ :anIndex |
			aMeasurer
				reset;
				measure: self textRun
				from: self textRunStart
				to: anIndex
				width: Float infinity.
			(aWidth - aMeasurer width) sign ]
		"exact match"
		do: [ :anIndex | self from + aMeasurer spanEnd - 1 ]
		
		"need to measure a bit more"
		ifNone: [ :a :b |
			| leftIndex rightIndex leftWidth leftSpanIndex rightWidth rightSpanIndex spanIndex |
			leftIndex := a ifNil: [ self textRunStart - 1 ].
			rightIndex := b ifNil: [ self textRunEnd + 1 ].

			aMeasurer
				reset;
				measure: self textRun
				from: self textRunStart
				to: leftIndex
				width: Float infinity.
			leftWidth := aMeasurer width.
			leftSpanIndex := aMeasurer spanEnd.

			aMeasurer
				reset;
				measure: self textRun
				from: self textRunStart
				to: rightIndex
				width: Float infinity.
			rightWidth := aMeasurer width.
			rightSpanIndex := aMeasurer spanEnd.

			spanIndex := aWidth < (leftWidth + ((rightWidth - leftWidth) / 2.0))
				ifTrue: [ leftSpanIndex ]
				ifFalse: [ rightSpanIndex ].

			self from + spanIndex - 1 ]