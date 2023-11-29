Class {
	#name : 'BlInfiniteDataSourceCommandTypeUpdate',
	#superclass : 'BlInfiniteDataSourceCommandType',
	#category : 'Bloc-Infinite-DataSource',
	#package : 'Bloc-Infinite',
	#tag : 'DataSource'
}

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeUpdate >> apply: aCommand in: anInfiniteElement [
	| command tmpStart tmpCount tmpEnd type position manager |
	command := aCommand.
	tmpStart := command positionStart.
	tmpCount := 0.
	tmpEnd := command positionStart + command itemCount.
	type := -1.
	manager := anInfiniteElement dataSourceManager.

	position := command positionStart.
	[ position < tmpEnd ]  whileTrue: [
		| holder |
		holder := holder := self elementHolderAt: position in: anInfiniteElement.
		
		(holder isNotNil or: [ anInfiniteElement dataSourceManager canFindInPreLayout: position  ])
			ifTrue: [ 
				type = command typeInvisible ifTrue: [ 
					self dispatchOn: anInfiniteElement start: tmpStart count: tmpCount.
					tmpCount := 0.
					tmpStart := position ].
				type := command typeNewOrLaidOut ]
			ifFalse: [ 
				type = command typeNewOrLaidOut ifTrue: [ 
					self postponeOn: anInfiniteElement start: tmpStart count: tmpCount.
					tmpCount := 0.
					tmpStart := position ].
				type := command typeInvisible ].

		tmpCount := tmpCount + 1.
		position := position + 1 ].
	
	(tmpCount ~= command itemCount) ifTrue: [ 
		manager recycleCommand: command.
		command := manager createCommand: self
			positionStart: tmpStart
			itemCount: tmpCount ].

	type = command typeInvisible
		ifTrue: [ manager dispatchAndUpdateElementHolders: command on: anInfiniteElement ]
		ifFalse: [ manager postponeAndUpdateElementHolders: command on: anInfiniteElement ]
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeUpdate >> apply: aCommand onPosition: aPosition [
	^ aPosition
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeUpdate >> continuous: aPosition start: start [
	^ aPosition = (start + 1)
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeUpdate >> dispatch: aCommand toLayout: aLayout [
	aLayout onItemsUpdatedAt: aCommand positionStart count: aCommand itemCount
]

{ #category : 'private' }
BlInfiniteDataSourceCommandTypeUpdate >> dispatchOn: anInfiniteElement start: aStartPosition count: anItemCount [
	| newCommand manager |
	manager := anInfiniteElement dataSourceManager.
	newCommand := manager createCommand: self
		positionStart: aStartPosition
		itemCount: anItemCount.
	manager dispatchAndUpdateElementHolders: newCommand on: anInfiniteElement.
]

{ #category : 'testing' }
BlInfiniteDataSourceCommandTypeUpdate >> isUpdate [
	^ true
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeUpdate >> offsetPositions: aCommand in: anInfiniteElement [

	anInfiniteElement dataSourceManager
		markElementHoldersUpdated: aCommand positionStart
		itemCount: aCommand itemCount
		in: anInfiniteElement

]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeUpdate >> positionMultiplier [
	^ 1
]

{ #category : 'private' }
BlInfiniteDataSourceCommandTypeUpdate >> postponeOn: aContext start: aStartPosition count: anItemCount [ 
	|newCommand|
	newCommand := aContext dataSourceManager createCommand: self
		positionStart: aStartPosition
		itemCount: anItemCount.
	aContext dataSourceManager postponeAndUpdateElementHolders: newCommand on: aContext
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeUpdate >> updateElementHoldersIn: anInfiniteElement command: aCommand [

	anInfiniteElement dataSourceManager
		markElementHoldersUpdated: aCommand positionStart
		itemCount: aCommand itemCount
		in: anInfiniteElement
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeUpdate >> updateElementHoldersIn: anInfiniteElement offset: offsetStart command: aCommand [

	anInfiniteElement dataSourceManager
		markElementHoldersUpdated: offsetStart
		itemCount: aCommand itemCount
		in: anInfiniteElement
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeUpdate >> updatePosition: aPosition with: aCommand from: myCommand [
	^ aPosition
]
