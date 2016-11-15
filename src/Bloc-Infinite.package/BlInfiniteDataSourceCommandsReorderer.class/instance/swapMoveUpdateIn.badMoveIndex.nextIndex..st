private
swapMoveUpdateIn: aListOfCommands badMoveIndex: movePos nextIndex: updatePos
	| moveCommand updateCommand extraUp1 extraUp2 |
	moveCommand := aListOfCommands at: movePos.
	updateCommand := aListOfCommands at: updatePos.

	"going in reverse, first revert the effect of add"
	moveCommand itemCount < updateCommand positionStart
		ifTrue: [ updateCommand positionStart: updateCommand positionStart - 1 ]
		ifFalse: [ moveCommand itemCount < (updateCommand positionStart + updateCommand itemCount)
			ifTrue: [ 
				updateCommand itemCount: updateCommand itemCount - 1.
				extraUp1 := self dataSourceManager
					createCommand: BlInfiniteDataSourceCommandTypeUpdate instance
					positionStart: moveCommand positionStart
					itemCount: 1
					payload: updateCommand payload ] ].
			
	"now affect of add is consumed. now apply effect of first remove"
	moveCommand positionStart <= updateCommand positionStart
		ifTrue: [ updateCommand positionStart: updateCommand positionStart + 1 ]
		ifFalse: [ moveCommand positionStart < (updateCommand positionStart + updateCommand itemCount)
			ifTrue: [ 
				| remaining |
				remaining := updateCommand positionStart + updateCommand itemCount - moveCommand positionStart.
				extraUp2 := self dataSourceManager
					createCommand: BlInfiniteDataSourceCommandTypeUpdate instance
						positionStart: moveCommand positionStart + 1
						itemCount: remaining
						payload: updateCommand payload.
				updateCommand itemCount: updateCommand itemCount - remaining ] ].
	
	aListOfCommands at: updatePos put: moveCommand.
	updateCommand itemCount > 0
		ifTrue: [ aListOfCommands at: movePos put: updateCommand ]
		ifFalse: [ 
			aListOfCommands removeAt: movePos.
			self dataSourceManager recycleCommand: updateCommand ].
	
	extraUp1 ifNotNil: [ 
		aListOfCommands add: extraUp1 beforeIndex: movePos ].
	extraUp2 ifNotNil: [ 
		aListOfCommands add: extraUp2 beforeIndex: movePos ]