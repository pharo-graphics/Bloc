Class {
	#name : #BlInfiniteDataSourceRemoveCommand,
	#superclass : #BlInfiniteDataSourceCommand,
	#category : #'Bloc-Infinite-DataSource'
}

{ #category : #commands }
BlInfiniteDataSourceRemoveCommand >> applyIn: anInfiniteElement [

	| command tmpStart tmpCount tmpEnd t position manager |
	tmpStart := self positionStart.
	tmpCount := 0.
	tmpEnd := self positionStart + self itemCount.
	t := -1.
	manager := anInfiniteElement dataSourceManager.
	
	position := self positionStart.
	[ position < tmpEnd ] whileTrue: [
		| typeChanged holder |
		typeChanged := false.
		holder := self elementHolderAt: position in: anInfiniteElement.

		(holder isNotNil or: [
			 anInfiniteElement dataSourceManager canFindInPreLayout: position ])
			ifTrue: [
				t = self typeInvisible ifTrue: [
					self
						dispatchOn: anInfiniteElement
						start: tmpStart
						count: tmpCount.
					typeChanged := true ].
				t := self typeNewOrLaidOut ]
			ifFalse: [
				t = self typeNewOrLaidOut ifTrue: [
					self
						postponeIn: anInfiniteElement
						start: tmpStart
						count: tmpCount.
					typeChanged := true ].
				t := self typeInvisible ].

		typeChanged
			ifTrue: [
				position := position - tmpCount.
				tmpEnd := tmpEnd - tmpCount.
				tmpCount := 1 ]
			ifFalse: [ tmpCount := tmpCount + 1 ].
		position := position + 1 ].

	command := self.
	tmpCount ~= self itemCount ifTrue: [
		manager recycleCommand: self.
		command := self class new
			           positionStart: tmpStart;
			           itemCount: tmpCount;
			           yourself ].

	t = command typeInvisible
		ifTrue: [
			manager
				dispatchAndUpdateElementHolders: command
				on: anInfiniteElement ]
		ifFalse: [
			manager
				postponeAndUpdateElementHolders: command
				on: anInfiniteElement ]
]

{ #category : #commands }
BlInfiniteDataSourceRemoveCommand >> applyOnPosition: aPosition [
	| newPosition |
	newPosition := aPosition.

	self positionStart <= aPosition
		ifTrue: [
			| end |
			end := self positionStart + self itemCount.
			end > aPosition
				ifTrue: [ ^ NoPosition ].	
			newPosition := aPosition - self itemCount ].
		
	^ newPosition
]

{ #category : #commands }
BlInfiniteDataSourceRemoveCommand >> continuous: aPosition start: start [

	^ aPosition = start
]

{ #category : #private }
BlInfiniteDataSourceRemoveCommand >> dispatchOn: anInfiniteElement start: aStartPosition count: anItemCount [

	| newCommand manager |
	manager := anInfiniteElement dataSourceManager.
	newCommand := self class new
		              positionStart: aStartPosition;
		              itemCount: anItemCount;
		              yourself.
	manager
		dispatchAndUpdateElementHolders: newCommand
		on: anInfiniteElement
]

{ #category : #commands }
BlInfiniteDataSourceRemoveCommand >> dispatchToLayout: aLayout [

	aLayout onItemsRemovedAt: self positionStart count: self itemCount
]

{ #category : #testing }
BlInfiniteDataSourceRemoveCommand >> isRemove [

	^ true
]

{ #category : #commands }
BlInfiniteDataSourceRemoveCommand >> offsetPositionsIn: anInfiniteElement [

	anInfiniteElement dataSourceManager 
		offsetPositions: self positionStart
		forRemovingInvisible: self itemCount
		in: anInfiniteElement
]

{ #category : #commands }
BlInfiniteDataSourceRemoveCommand >> positionMultiplier [

	^ 0
]

{ #category : #private }
BlInfiniteDataSourceRemoveCommand >> postponeIn: anInfiniteElement start: aStartPosition count: anItemCount [

	| newCommand manager |
	manager := anInfiniteElement dataSourceManager.
	newCommand := self class new
		              positionStart: aStartPosition;
		              itemCount: anItemCount;
		              yourself.
	manager
		postponeAndUpdateElementHolders: newCommand
		on: anInfiniteElement
]

{ #category : #commands }
BlInfiniteDataSourceRemoveCommand >> updateElementHoldersIn: anInfiniteElement [

	anInfiniteElement dataSourceManager
		offsetPositions: self positionStart
		forRemovingLaidOutOrNewElement: self itemCount
		in: anInfiniteElement
]

{ #category : #commands }
BlInfiniteDataSourceRemoveCommand >> updateElementHoldersIn: anInfiniteElement offset: offsetStart [

	anInfiniteElement dataSourceManager
		offsetPositions: offsetStart
		forRemovingLaidOutOrNewElement: self itemCount
		in: anInfiniteElement
]

{ #category : #commands }
BlInfiniteDataSourceRemoveCommand >> updatePosition: aPosition with: aCommand [

	| pos |
	pos := aPosition.

	self positionStart <= pos
		ifTrue: [ pos := pos + self itemCount ]
		ifFalse: [ self positionStart: self positionStart - 1 ].

	^ pos
]
