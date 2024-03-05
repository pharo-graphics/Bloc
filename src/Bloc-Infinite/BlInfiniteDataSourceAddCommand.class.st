Class {
	#name : #BlInfiniteDataSourceAddCommand,
	#superclass : #BlInfiniteDataSourceStructuralChangeCommand,
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Infinite-DataSource'
}

{ #category : #commands }
BlInfiniteDataSourceAddCommand >> applyIn: anInfiniteElement [
	"In case of scrolling, only for item change (no add-remove-move). Check
	if any of the visible items is affected and if not, just ignore the change."

	anInfiniteElement dataSourceManager
		postponeAndUpdateElementHolders: self
		on: anInfiniteElement
]

{ #category : #commands }
BlInfiniteDataSourceAddCommand >> applyOnPosition: aPosition [
	"When the position of an ElementHolder is required.
	Determine how provided position will change. Return the position after command is processed"
	
	|newPosition|
	
	newPosition := self positionStart <= aPosition
		ifTrue: [ aPosition + self itemCount ]
		ifFalse: [ aPosition ].

	^ newPosition
]

{ #category : #commands }
BlInfiniteDataSourceAddCommand >> continuous: aPosition start: start [

	self shouldNotImplement 
]

{ #category : #commands }
BlInfiniteDataSourceAddCommand >> dispatchToLayout: aLayout [

	aLayout onItemsAddedAt: self positionStart count: self itemCount
]

{ #category : #testing }
BlInfiniteDataSourceAddCommand >> isAdd [

	^ true
]

{ #category : #commands }
BlInfiniteDataSourceAddCommand >> offsetPositionsIn: anInfiniteElement [

	anInfiniteElement dataSourceManager
		offsetPositions: self positionStart
		forAdd: self itemCount
		in: anInfiniteElement
]

{ #category : #commands }
BlInfiniteDataSourceAddCommand >> positionMultiplier [

	^ self shouldNotImplement 
]

{ #category : #commands }
BlInfiniteDataSourceAddCommand >> updateElementHoldersIn: anInfiniteElement [

	anInfiniteElement dataSourceManager
		offsetPositions: self positionStart
		forAdd: self itemCount
		in: anInfiniteElement
]

{ #category : #commands }
BlInfiniteDataSourceAddCommand >> updateElementHoldersIn: anInfiniteElement offset: offsetStart [

	self shouldNotImplement 
]

{ #category : #commands }
BlInfiniteDataSourceAddCommand >> updatePosition: aPosition with: aCommand [

	| pos |
	pos := aPosition.

	self positionStart <= pos
		ifTrue: [ pos := pos - self itemCount ]
		ifFalse: [ self positionStart: self positionStart + 1 ].

	^ pos
]
