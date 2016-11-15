dispatch
updatePosition: aPosition with: aCommand from: myCommand
	|start end pos|
	pos := aPosition.
	
	myCommand positionStart < myCommand itemCount
		ifTrue: [
			start := myCommand positionStart.
			end := myCommand itemCount ]
		ifFalse: [
			start := myCommand itemCount.
			end := myCommand positionStart ].
		
	(pos >= start and: [ pos <= end ])
		ifTrue: [
			start = myCommand positionStart
				ifTrue: [
					aCommand isAdd
						ifTrue: [ myCommand itemCount: myCommand itemCount + 1 ]
						ifFalse: [ aCommand isRemove
							ifTrue: [ myCommand itemCount: myCommand itemCount - 1 ] ].
					pos := pos + 1 ]
				ifFalse: [ 
					aCommand isAdd
						ifTrue: [ myCommand positionStart: myCommand positionStart + 1 ]
						ifFalse: [ aCommand isRemove
							ifTrue: [ myCommand positionStart: myCommand positionStart - 1 ] ].
					pos := pos - 1 ] ]
		ifFalse: [ 
			(pos < myCommand positionStart) ifTrue: [ 
				aCommand isAdd
					ifTrue: [
						myCommand positionStart: myCommand positionStart + 1.
						myCommand itemCount: myCommand itemCount + 1 ]
					ifFalse: [ aCommand isRemove
						ifTrue: [
							myCommand positionStart: myCommand positionStart - 1.
							myCommand itemCount: myCommand itemCount - 1 ] ] ] ].
	^ pos