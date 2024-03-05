Class {
	#name : #BlInfiniteDataSourceUpdateCommand,
	#superclass : #BlInfiniteDataSourceCommand,
	#category : #'Bloc-Infinite-DataSource'
}

{ #category : #commands }
BlInfiniteDataSourceUpdateCommand >> applyIn: anInfiniteElement [

	| command tmpStart tmpCount tmpEnd t position manager |
	tmpStart := self positionStart.
	tmpCount := 0.
	tmpEnd := self positionStart + self itemCount.
	t := -1.
	manager := anInfiniteElement dataSourceManager.

	position := self positionStart.
	[ position < tmpEnd ] whileTrue: [
		| holder |
		holder := holder := self
			                    elementHolderAt: position
			                    in: anInfiniteElement.

		(holder isNotNil or: [
			 anInfiniteElement dataSourceManager canFindInPreLayout: position ])
			ifTrue: [
				t = self typeInvisible ifTrue: [
					self
						dispatchOn: anInfiniteElement
						start: tmpStart
						count: tmpCount.
					tmpCount := 0.
					tmpStart := position ].
				t := self typeNewOrLaidOut ]
			ifFalse: [
				t = self typeNewOrLaidOut ifTrue: [
					self
						postponeOn: anInfiniteElement
						start: tmpStart
						count: tmpCount.
					tmpCount := 0.
					tmpStart := position ].
				t := self typeInvisible ].

		tmpCount := tmpCount + 1.
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
BlInfiniteDataSourceUpdateCommand >> applyOnPosition: aPosition [

	^ aPosition
]

{ #category : #commands }
BlInfiniteDataSourceUpdateCommand >> continuous: aPosition start: start [

	^ aPosition = (start + 1)
]

{ #category : #private }
BlInfiniteDataSourceUpdateCommand >> dispatchOn: anInfiniteElement start: aStartPosition count: anItemCount [

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
BlInfiniteDataSourceUpdateCommand >> dispatchToLayout: aLayout [

	aLayout onItemsUpdatedAt: self positionStart count: self itemCount
]

{ #category : #testing }
BlInfiniteDataSourceUpdateCommand >> isUpdate [

	^ true
]

{ #category : #commands }
BlInfiniteDataSourceUpdateCommand >> offsetPositionsIn: anInfiniteElement [

	anInfiniteElement dataSourceManager
		markElementHoldersUpdated: self positionStart
		itemCount: self itemCount
		in: anInfiniteElement

]

{ #category : #commands }
BlInfiniteDataSourceUpdateCommand >> positionMultiplier [

	^ 1
]

{ #category : #private }
BlInfiniteDataSourceUpdateCommand >> postponeOn: aContext start: aStartPosition count: anItemCount [

	| newCommand |
	newCommand := self class new
		              positionStart: aStartPosition;
		              itemCount: anItemCount;
		              yourself.
	aContext dataSourceManager
		postponeAndUpdateElementHolders: newCommand
		on: aContext
]

{ #category : #commands }
BlInfiniteDataSourceUpdateCommand >> updateElementHoldersIn: anInfiniteElement [

	anInfiniteElement dataSourceManager
		markElementHoldersUpdated: self positionStart
		itemCount: self itemCount
		in: anInfiniteElement
]

{ #category : #commands }
BlInfiniteDataSourceUpdateCommand >> updateElementHoldersIn: anInfiniteElement offset: offsetStart [

	anInfiniteElement dataSourceManager
		markElementHoldersUpdated: offsetStart
		itemCount: self itemCount
		in: anInfiniteElement
]

{ #category : #commands }
BlInfiniteDataSourceUpdateCommand >> updatePosition: aPosition with: aCommand [

	^ aPosition
]
