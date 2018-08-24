"
I represent a concrete ""remove"" command type
"
Class {
	#name : #BlInfiniteDataSourceCommandTypeRemove,
	#superclass : #BlInfiniteDataSourceCommandType,
	#category : 'Bloc-Infinite-DataSource-Support'
}

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeRemove >> apply: aCommand on: aContext [
	| command tmpStart tmpCount tmpEnd type position |
	command := aCommand.
	tmpStart := command positionStart.
	tmpCount := 0.
	tmpEnd := command positionStart + command itemCount.
	type := -1.

	position := command positionStart.
	[ position < tmpEnd ]  whileTrue: [
		| typeChanged holder |
		typeChanged := false.
		holder := aContext controller elementHolderAt: position.
		
		(holder isNotNil or: [ aContext canFindInPreLayout: position ])
			ifTrue: [ 
				type = command typeInvisible ifTrue: [ 
					self dispatchOn: aContext start: tmpStart count: tmpCount.
					typeChanged := true ].
				type := command typeNewOrLaidOut ]
			ifFalse: [ 
				type = command typeNewOrLaidOut ifTrue: [ 
					self postponeOn: aContext start: tmpStart count: tmpCount.
					typeChanged := true ].
				type := command typeInvisible ].

		typeChanged
			ifTrue: [ 
				position := position - tmpCount.
				tmpEnd := tmpEnd - tmpCount.
				tmpCount := 1 ]
			ifFalse: [ tmpCount := tmpCount + 1 ].
		position := position + 1 ].

	(tmpCount ~= command itemCount) ifTrue: [ 
		aContext recycleCommand: command.
		command := aContext createCommand: self
			positionStart: tmpStart
			itemCount: tmpCount
			payload: nil ].

	type = command typeInvisible
		ifTrue: [ aContext dispatchAndUpdateElementHolders: command ]
		ifFalse: [ aContext postponeAndUpdateElementHolders: command ]
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeRemove >> apply: aCommand onPosition: aPosition [
	| newPosition |
	newPosition := aPosition.

	aCommand positionStart <= aPosition
		ifTrue: [
			| end |
			end := aCommand positionStart + aCommand itemCount.
			end > aPosition
				ifTrue: [ ^ NoPosition ].	
			newPosition := aPosition - aCommand itemCount ].
		
	^ newPosition
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeRemove >> continuous: aPosition start: start [
	^ aPosition = start
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeRemove >> dispatch: aCommand toLayout: aLayout [
	aLayout onItemsRemovedAt: aCommand positionStart count: aCommand itemCount
]

{ #category : #private }
BlInfiniteDataSourceCommandTypeRemove >> dispatchOn: aContext start: aStartPosition count: anItemCount [
	|newCommand|
	newCommand := aContext createCommand: self
		positionStart: aStartPosition
		itemCount: anItemCount
		payload: nil.
	aContext dispatchAndUpdateElementHolders: newCommand.
]

{ #category : #testing }
BlInfiniteDataSourceCommandTypeRemove >> isRemove [
	^ true
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeRemove >> offsetPositions: aCommand on: aDataSourceController [
	aDataSourceController
		offsetPositions: aCommand positionStart
		forRemovingInvisible: aCommand itemCount
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeRemove >> positionMultiplier [
	^ 0
]

{ #category : #private }
BlInfiniteDataSourceCommandTypeRemove >> postponeOn: aContext start: aStartPosition count: anItemCount [
	|newCommand|
	newCommand := aContext createCommand: self
		positionStart: aStartPosition
		itemCount: anItemCount
		payload: nil.
	aContext postponeAndUpdateElementHolders: newCommand.
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeRemove >> swapMoveOn: aContext in: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex [
	aContext swapMoveRemoveIn: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeRemove >> updateElementHoldersOn: aContext command: aCommand [
	aContext controller
		offsetPositions: aCommand positionStart
		forRemovingLaidOutOrNewElement: aCommand itemCount
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeRemove >> updateElementHoldersOn: aContext offset: offsetStart command: aCommand [
	aContext controller
		offsetPositions: offsetStart
		forRemovingLaidOutOrNewElement: aCommand itemCount
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeRemove >> updatePosition: aPosition with: aCommand from: myCommand [
	| pos |
	pos := aPosition.
	
	myCommand positionStart <= pos
		ifTrue: [ pos := pos + myCommand itemCount ]
		ifFalse: [ myCommand positionStart: myCommand positionStart - 1 ].
		
	^ pos
]
