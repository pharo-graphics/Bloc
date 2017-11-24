geometry
positionAt: anIndex
	<return: #Point>
	| aSpanIndex aSpanIterator currentEnd transformedSpanIndex aMeasurer aPositionY aPositionX |

	aPositionY := self baseline y.
	aPositionX := self baseline x.

	(anIndex = (self from - 1))
		ifTrue: [ ^ aPositionX @ aPositionY ].
	(anIndex = self to)
		ifTrue: [ ^ (aPositionX + self width) @ aPositionY ].

	aSpanIndex := anIndex - self from + 1.
	aSpanIterator := span iterator: 1 to: aSpanIndex.	
	
	currentEnd := 0.
	transformedSpanIndex := 0.
	[ aSpanIterator hasNext and: [ currentEnd < aSpanIndex ] ]
		whileTrue: [ (aSpanIterator next = Character tab)
			ifTrue: [ transformedSpanIndex := transformedSpanIndex + 3 ]	"3 is how many spaces one tab is. #FIXME"
			ifFalse: [ transformedSpanIndex := transformedSpanIndex + 1 ].
			currentEnd := currentEnd + 1 ].

	aMeasurer := self measurer.

	transformedSpanIndex isZero
		ifTrue: [ ^ aPositionX @ aPositionY ].
	
	aMeasurer
		reset;
		measure: self textRun
		from: 1
		to: transformedSpanIndex
		width: Float infinity.
		
	^ (aPositionX + aMeasurer width) @ aPositionY