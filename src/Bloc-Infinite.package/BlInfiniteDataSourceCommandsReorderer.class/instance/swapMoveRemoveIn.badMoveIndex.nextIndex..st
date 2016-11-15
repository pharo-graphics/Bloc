private
swapMoveRemoveIn: aListOfCommands badMoveIndex: movePos nextIndex: removePos
	| moveCommand removeCommand extraRm revertedMove moveIsBackwards |
	extraRm := nil.
	revertedMove := false.
	moveIsBackwards := false.
	moveCommand := aListOfCommands at: movePos.
	removeCommand := aListOfCommands at: removePos.
	
	"check if move is nulled out by remove"
	moveCommand positionStart < moveCommand itemCount
		ifTrue: [
			moveIsBackwards := false.
			(removeCommand positionStart = moveCommand positionStart
				and: [ removeCommand itemCount = (moveCommand itemCount - moveCommand positionStart) ])
				ifTrue: [ revertedMove := true ] ]
		ifFalse: [ 
			moveIsBackwards := true.
			(removeCommand positionStart = (moveCommand itemCount + 1)
				and: [ removeCommand itemCount = (moveCommand positionStart - moveCommand itemCount) ])
				ifTrue: [ revertedMove := true ] ].
	
	"going in reverse, first revert the effect of add"
	moveCommand itemCount < removeCommand positionStart
		ifTrue: [ removeCommand positionStart: removeCommand positionStart - 1 ]
		ifFalse: [ moveCommand < (removeCommand positionStart + removeCommand itemCount)
			ifTrue: [
				"move is removed"
				removeCommand itemCount: removeCommand itemCount - 1.
				moveCommand beRemove.
				moveCommand itemCount: 1.
				removeCommand itemCount = 0 ifTrue: [ 
					aListOfCommands removeAt: removePos.
					self dataSourceManager recycleCommand: removeCommand ].
				^ self ] ].
		
	"now affect of add is consumed. now apply effect of first remove"
	moveCommand positionStart <= removeCommand positionStart
		ifTrue: [ removeCommand positionStart: removeCommand positionStart + 1 ]
		ifFalse: [ moveCommand positionStart < (removeCommand positionStart + removeCommand itemCount)
			ifTrue: [ 
				| remaining |
				remaining := removeCommand positionStart + removeCommand itemCount - moveCommand positionStart.
				extraRm := self dataSourceManager
					createCommand: BlInfiniteDataSourceCommandTypeRemove instance
					positionStart: moveCommand positionStart + 1
					itemCount: remaining
					payload: nil.
				removeCommand itemCount: moveCommand positionStart - removeCommand positionStart ] ].
	
	"if effects of move is reverted by remove, we are done"
	revertedMove ifTrue: [ 
		aListOfCommands at: movePos put: removeCommand.
		aListOfCommands removeAt: removePos.
		self dataSourceManager recycleCommand: moveCommand.
		^ self ].

	"now find out the new locations for move actions"
	moveIsBackwards
		ifTrue: [ 
			extraRm ifNotNil: [ 
				moveCommand positionStart > extraRm positionStart
					ifTrue: [ moveCommand positionStart: moveCommand positionStart - extraRm itemCount ].
				moveCommand > extraRm positionStart
					ifTrue: [ moveCommand itemCount: moveCommand itemCount - extraRm itemCount ] ].
			moveCommand positionStart > removeCommand positionStart
				ifTrue: [ moveCommand positionStart: moveCommand positionStart - removeCommand itemCount ].
			moveCommand itemCount > removeCommand positionStart
				ifTrue: [ moveCommand itemCount: moveCommand itemCount - removeCommand itemCount ] ]
		ifFalse: [ 
			extraRm ifNotNil: [ 
				moveCommand positionStart >= extraRm positionStart
					ifTrue: [ moveCommand positionStart: moveCommand positionStart - extraRm itemCount ].
				moveCommand >= extraRm positionStart
					ifTrue: [ moveCommand itemCount: moveCommand itemCount - extraRm itemCount ] ].
			moveCommand positionStart >= removeCommand positionStart
				ifTrue: [ moveCommand positionStart: moveCommand positionStart - removeCommand itemCount ].
			moveCommand itemCount >= removeCommand positionStart
				ifTrue: [ moveCommand itemCount: moveCommand itemCount - removeCommand itemCount ] ].
			
	aListOfCommands at: movePos put: removeCommand.
	moveCommand positionStart ~= moveCommand itemCount
		ifTrue: [ aListOfCommands at: removePos put: moveCommand ]
		ifFalse: [ aListOfCommands removeAt: removePos ].
	
	extraRm ifNotNil: [ 
		aListOfCommands add: extraRm beforeIndex: movePos ]