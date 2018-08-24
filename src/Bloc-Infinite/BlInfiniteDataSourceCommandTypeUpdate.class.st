"
I represent a concrete ""update"" command type
"
Class {
	#name : #BlInfiniteDataSourceCommandTypeUpdate,
	#superclass : #BlInfiniteDataSourceCommandType,
	#category : 'Bloc-Infinite-DataSource-Support'
}

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeUpdate >> apply: aCommand on: aContext [
	| command tmpStart tmpCount tmpEnd type position |
	command := aCommand.
	tmpStart := command positionStart.
	tmpCount := 0.
	tmpEnd := command positionStart + command itemCount.
	type := -1.

	position := command positionStart.
	[ position < tmpEnd ]  whileTrue: [
		| holder |
		holder := aContext controller elementHolderAt: position.
		
		(holder isNotNil or: [ aContext canFindInPreLayout: position ])
			ifTrue: [ 
				type = command typeInvisible ifTrue: [ 
					self dispatchOn: aContext start: tmpStart count: tmpCount payload: command payload.
					tmpCount := 0.
					tmpStart := position ].
				type := command typeNewOrLaidOut ]
			ifFalse: [ 
				type = command typeNewOrLaidOut ifTrue: [ 
					self postponeOn: aContext start: tmpStart count: tmpCount payload: command payload.
					tmpCount := 0.
					tmpStart := position ].
				type := command typeInvisible ].

		tmpCount := tmpCount + 1.
		position := position + 1 ].
	
	(tmpCount ~= command itemCount) ifTrue: [ 
		|aPayload|
		aPayload := command payload.
		aContext recycleCommand: command.
		command := aContext createCommand: self
			positionStart: tmpStart
			itemCount: tmpCount
			payload: aPayload ].

	type = command typeInvisible
		ifTrue: [ aContext dispatchAndUpdateElementHolders: command ]
		ifFalse: [ aContext postponeAndUpdateElementHolders: command ]
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeUpdate >> apply: aCommand onPosition: aPosition [
	^ aPosition
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeUpdate >> continuous: aPosition start: start [
	^ aPosition = (start + 1)
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeUpdate >> dispatch: aCommand toLayout: aLayout [
	aLayout onItemsUpdatedAt: aCommand positionStart count: aCommand itemCount payload: aCommand payload
]

{ #category : #private }
BlInfiniteDataSourceCommandTypeUpdate >> dispatchOn: aContext start: aStartPosition count: anItemCount payload: anObject [
	|newCommand|
	newCommand := aContext createCommand: self
		positionStart: aStartPosition
		itemCount: anItemCount
		payload: anObject.
	aContext dispatchAndUpdateElementHolders: newCommand.
]

{ #category : #testing }
BlInfiniteDataSourceCommandTypeUpdate >> isUpdate [
	^ true
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeUpdate >> offsetPositions: aCommand on: aDataSourceController [

	aDataSourceController
		markElementHoldersUpdated: aCommand positionStart
		itemCount: aCommand itemCount
		payload: aCommand payload
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeUpdate >> positionMultiplier [
	^ 1
]

{ #category : #private }
BlInfiniteDataSourceCommandTypeUpdate >> postponeOn: aContext start: aStartPosition count: anItemCount payload: anObject [
	|newCommand|
	newCommand := aContext createCommand: self
		positionStart: aStartPosition
		itemCount: anItemCount
		payload: anObject.
	aContext postponeAndUpdateElementHolders: newCommand
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeUpdate >> swapMoveOn: aContext in: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex [
	aContext swapMoveUpdateIn: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeUpdate >> updateElementHoldersOn: aContext command: aCommand [
	aContext controller
		markElementHoldersUpdated: aCommand positionStart
		itemCount: aCommand itemCount
		payload: aCommand payload
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeUpdate >> updateElementHoldersOn: aContext offset: offsetStart command: aCommand [
	aContext controller
		markElementHoldersUpdated: offsetStart
		itemCount: aCommand itemCount
		payload: aCommand payload
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeUpdate >> updatePosition: aPosition with: aCommand from: myCommand [
	^ aPosition
]
