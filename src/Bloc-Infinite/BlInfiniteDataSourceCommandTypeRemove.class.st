Class {
	#name : #BlInfiniteDataSourceCommandTypeRemove,
	#superclass : #BlInfiniteDataSourceCommandType,
	#category : 'Bloc-Infinite-DataSource'
}

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeRemove >> apply: aCommand in: anInfiniteElement [
	| command tmpStart tmpCount tmpEnd type position manager |
	command := aCommand.
	tmpStart := command positionStart.
	tmpCount := 0.
	tmpEnd := command positionStart + command itemCount.
	type := -1.
	manager := anInfiniteElement dataSourceManager.
	position := command positionStart.
	[ position < tmpEnd ]  whileTrue: [
		| typeChanged holder |
		typeChanged := false.
		holder := self elementHolderAt: position in: anInfiniteElement.
		
		(holder isNotNil or: [ anInfiniteElement dataSourceManager canFindInPreLayout: position ])
			ifTrue: [ 
				type = command typeInvisible ifTrue: [ 
					self dispatchOn: anInfiniteElement start: tmpStart count: tmpCount.
					typeChanged := true ].
				type := command typeNewOrLaidOut ]
			ifFalse: [ 
				type = command typeNewOrLaidOut ifTrue: [ 
					self postponeIn: anInfiniteElement start: tmpStart count: tmpCount.
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
		manager recycleCommand: command.
		command := manager createCommand: self
			positionStart: tmpStart
			itemCount: tmpCount].

	type = command typeInvisible
		ifTrue: [ manager dispatchAndUpdateElementHolders: command on: anInfiniteElement ]
		ifFalse: [ manager postponeAndUpdateElementHolders: command on: anInfiniteElement ]
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
BlInfiniteDataSourceCommandTypeRemove >> dispatchOn: anInfiniteElement start: aStartPosition count: anItemCount [
	| newCommand manager |
	manager := anInfiniteElement dataSourceManager.
	newCommand := manager createCommand: self
		positionStart: aStartPosition
		itemCount: anItemCount.
	manager dispatchAndUpdateElementHolders: newCommand on: anInfiniteElement.
]

{ #category : #testing }
BlInfiniteDataSourceCommandTypeRemove >> isRemove [
	^ true
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeRemove >> offsetPositions: aCommand in: anInfiniteElement [

	anInfiniteElement dataSourceManager 
		offsetPositions: aCommand positionStart
		forRemovingInvisible: aCommand itemCount
		in: anInfiniteElement
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeRemove >> positionMultiplier [
	^ 0
]

{ #category : #private }
BlInfiniteDataSourceCommandTypeRemove >> postponeIn: anInfiniteElement start: aStartPosition count: anItemCount [

	| newCommand manager |
	manager := anInfiniteElement dataSourceManager.
	newCommand := manager
		              createCommand: self
		              positionStart: aStartPosition
		              itemCount: anItemCount.
	manager
		postponeAndUpdateElementHolders: newCommand
		on: anInfiniteElement
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeRemove >> updateElementHoldersIn: anInfiniteElement command: aCommand [
	anInfiniteElement dataSourceManager
		offsetPositions: aCommand positionStart
		forRemovingLaidOutOrNewElement: aCommand itemCount
		in: anInfiniteElement
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeRemove >> updateElementHoldersIn: anInfiniteElement offset: offsetStart command: aCommand [

	anInfiniteElement dataSourceManager
		offsetPositions: offsetStart
		forRemovingLaidOutOrNewElement: aCommand itemCount
		in: anInfiniteElement
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
