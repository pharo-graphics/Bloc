"
I do a hard work sorting pending data source update commands based on their ""priority"" and type.

I am used by BlInfiniteDataSourceManager

Public API and Key Messages

- reorderCommands: in-place reorders provided list of commands. The only available public API!
 
Internal Representation and Key Implementation Points.

    Instance Variables
	dataSourceManager:		<BlInfiniteDataSourceManager>


    Implementation Points
"
Class {
	#name : #BlInfiniteDataSourceCommandsReorderer,
	#superclass : #Object,
	#instVars : [
		'dataSourceManager'
	],
	#category : 'Bloc-Infinite-DataSource-Support'
}

{ #category : #accessing }
BlInfiniteDataSourceCommandsReorderer >> dataSourceManager [
	^ dataSourceManager
]

{ #category : #accessing }
BlInfiniteDataSourceCommandsReorderer >> dataSourceManager: anObject [
	dataSourceManager := anObject
]

{ #category : #private }
BlInfiniteDataSourceCommandsReorderer >> getLastMoveOutOfOrderIn: aListOfCommands [
	"Return an index of last move command which is not on right
	place - if there are any non-move command after move command
	in the list, or return 0 if there is no such move command"
	<return: #Number>
	
	| foundNonMove |
	foundNonMove := false.
	
	aListOfCommands reverseWithIndexDo: [ :command :index |
		command isMove
			ifTrue: [ foundNonMove ifTrue: [ index ] ]
			ifFalse: [ foundNonMove := true ] ].
	^ 0
]

{ #category : #reordering }
BlInfiniteDataSourceCommandsReorderer >> reorderCommands: aListOfCommands [
	"In-place reorder provided list of commands.
	I am used by data source manager during commands processing step.
	Return a reordered list of commands (the same instance)"
	<return: #Collection>
	
	| badMove |
	
	"Since move commands break continuity, their effects on add/remove are hard to handle.
	We push them to the end of the list so that they can be handled easily."
	[ (badMove := self getLastMoveOutOfOrderIn: aListOfCommands) ~= 0 ]
		whileTrue: [ self swapMoveCommandIn: aListOfCommands badMoveIndex: badMove nextIndex: badMove + 1 ].
	^ aListOfCommands
]

{ #category : #private }
BlInfiniteDataSourceCommandsReorderer >> swapMoveAddIn: aListOfCommands badMoveIndex: movePos nextIndex: addPos [
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
]

{ #category : #private }
BlInfiniteDataSourceCommandsReorderer >> swapMoveCommandIn: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex [
	| badMoveCommand nextCommand |
	badMoveCommand := aListOfCommands at: badMoveIndex.
	nextCommand := aListOfCommands at: nextIndex.
	
	nextCommand swapMoveOn: self in: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex
]

{ #category : #private }
BlInfiniteDataSourceCommandsReorderer >> swapMoveRemoveIn: aListOfCommands badMoveIndex: movePos nextIndex: removePos [
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
]

{ #category : #private }
BlInfiniteDataSourceCommandsReorderer >> swapMoveUpdateIn: aListOfCommands badMoveIndex: movePos nextIndex: updatePos [
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
]
