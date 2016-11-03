computing
maxIndex
	^ maxIndex == UNDEFINED
		ifTrue: [ maxIndex := 0 max: self calculateMaxIndex ]
		ifFalse: [ maxIndex ]