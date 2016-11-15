private
swapMoveAddIn: aListOfCommands badMoveIndex: movePos nextIndex: addPos
	| moveCommand addCommand offset |
	moveCommand := aListOfCommands at: movePos.
	addCommand := aListOfCommands at: addPos.
	offset := 0.
	
	"going in reverse, first revert the effect of add"
	moveCommand itemCount < addCommand positionStart
		ifTrue: [ offset := offset - 1 ].
	moveCommand positionStart < addCommand positionStart
		ifTrue: [ offset := offset + 1 ].
	addCommand positionStart <= moveCommand positionStart
		ifTrue: [ moveCommand positionStart: moveCommand positionStart + addCommand itemCount ].
	addCommand positionStart <= moveCommand itemCount
		ifTrue: [ moveCommand itemCount: moveCommand itemCount + addCommand itemCount ].
		
	addCommand positionStart: addCommand positionStart + offset.
	aListOfCommands at: movePos put: addCommand.
	aListOfCommands at: addPos put: moveCommand