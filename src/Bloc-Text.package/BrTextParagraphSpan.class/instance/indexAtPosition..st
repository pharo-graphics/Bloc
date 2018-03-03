geometry
indexAtPosition: aPoint
	<return: #Number>
	| aWidth aMeasurer |

	aWidth := (aPoint x - self origin x) max: 0.
	aMeasurer := self measurer.

	(aWidth <= 0)
		ifTrue: [ ^ (self from - 1) max: 0 ].
	(aWidth >= self width)
		ifTrue: [ ^ self to ].

	^ (self textRunStart to: self textRunEnd)
		findBinary: [ :anIndex |
			aMeasurer
				reset;
				measure: self textRun
				from: self textRunStart
				to: anIndex
				width: self width.
			(aWidth - aMeasurer width) sign ]
		"exact match"
		do: [ :anIndex | self from + aMeasurer spanEnd - 1 ]

		"need to measure a bit more"
		ifNone: [ :a :b |
			| leftIndex rightIndex leftWidth leftSpanIndex rightWidth rightSpanIndex spanIndex |
			leftIndex := a ifNil: [ self textRunStart - 1 ].
			rightIndex := b ifNil: [ self textRunEnd + 1 ].
			
			leftIndex < self textRunStart
				ifTrue: [
					leftWidth := 0.
					leftSpanIndex := (self spanStart - 1) max: 0 ]
				ifFalse: [
					aMeasurer
						reset;
						measure: self textRun
							from: self textRunStart
							to: leftIndex
						width: self width.
					leftWidth := aMeasurer width.
					leftSpanIndex := aMeasurer spanEnd ].

			rightIndex > self textRunEnd
				ifTrue: [
					rightWidth := self width.
					rightSpanIndex := self spanEnd ]
				ifFalse: [
					aMeasurer
						reset;
						measure: self textRun
							from: self textRunStart
							to: rightIndex
						width: self width.
					rightWidth := aMeasurer width.
					rightSpanIndex := aMeasurer spanEnd ].

			spanIndex := aWidth <= (leftWidth + ((rightWidth - leftWidth) / 2.0))
				ifTrue: [ leftSpanIndex ]
				ifFalse: [ rightSpanIndex ].

			self from + spanIndex - 1 ]