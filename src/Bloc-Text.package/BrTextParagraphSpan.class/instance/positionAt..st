geometry
positionAt: anIndex
	<return: #Point>
	| aSpanIndex aMeasurer aPositionY |

	aSpanIndex := anIndex - self from + 1.
	aMeasurer := self measurer.
	
	aPositionY := self origin y + (self height / 2.0).

	anIndex isZero
		ifTrue: [ ^ 0 @ aPositionY ].
	
	aMeasurer
		reset;
		measure: self textRun
		from: 1
		to: aSpanIndex
		width: Float infinity.
		
	^ (self origin x + aMeasurer width) @ aPositionY