geometry
positionAt: anIndex
	<return: #Point>
	| aSpanIndex aSpanIterator currentEnd transformedSpanIndex aMeasurer aPositionY |

	aPositionY := self origin y + (self height / 2.0).
	
	(anIndex = (self from - 1))
		ifTrue: [ ^ (self origin x) @ aPositionY ].
	(anIndex = self to)
		ifTrue: [ ^ (self origin x + self width) @ aPositionY ].

	aSpanIndex := anIndex - self from + 1.
	aSpanIterator := span iterator: 1 to: aSpanIndex.	
	
	currentEnd := 0.
	transformedSpanIndex := 0.
	[ aSpanIterator hasNext and: [ currentEnd < aSpanIndex ] ]
		whileTrue: [ (aSpanIterator next = Character tab)
			ifTrue: [ transformedSpanIndex := transformedSpanIndex + 3 ]
			ifFalse: [ transformedSpanIndex := transformedSpanIndex + 1 ].
			currentEnd := currentEnd + 1 ].

	aMeasurer := self measurer.

	transformedSpanIndex isZero
		ifTrue: [ ^ 0 @ aPositionY ].
	
	aMeasurer
		reset;
		measure: self textRun
		from: 1
		to: transformedSpanIndex
		width: Float infinity.
		
	^ (self origin x + aMeasurer width) @ aPositionY