"
I represent a concrete ""add"" command type

"
Class {
	#name : #BlInfiniteDataSourceCommandTypeAdd,
	#superclass : #BlInfiniteDataSourceCommandType,
	#category : 'Bloc-Infinite-DataSource'
}

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeAdd >> apply: aCommand in: anInfiniteElement [
	anInfiniteElement dataSourceManager postponeAndUpdateElementHolders: aCommand on: anInfiniteElement
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeAdd >> apply: aCommand onPosition: aPosition [
	|newPosition|
	
	newPosition := aCommand positionStart <= aPosition
		ifTrue: [ aPosition + aCommand itemCount ]
		ifFalse: [ aPosition ].

	^ newPosition
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeAdd >> continuous: aPosition start: start [
	self shouldNotImplement
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeAdd >> dispatch: aCommand toLayout: aLayout [
	aLayout onItemsAddedAt: aCommand positionStart count: aCommand itemCount
]

{ #category : #testing }
BlInfiniteDataSourceCommandTypeAdd >> isAdd [
	^ true
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeAdd >> offsetPositions: aCommand in: anInfiniteElement [

	anInfiniteElement dataSourceManager
		offsetPositions: aCommand positionStart
		forAdd: aCommand itemCount
		in: anInfiniteElement
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeAdd >> positionMultiplier [
	self shouldNotImplement
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeAdd >> updateElementHoldersIn: anInfiniteElement command: aCommand [

	anInfiniteElement dataSourceManager
		offsetPositions: aCommand positionStart
		forAdd: aCommand itemCount
		in: anInfiniteElement
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeAdd >> updateElementHoldersIn: anInfiniteElement offset: offsetStart command: aCommand [
	self shouldNotImplement
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeAdd >> updatePosition: aPosition with: aCommand from: myCommand [
	| pos |
	pos := aPosition.
	
	myCommand positionStart <= pos
		ifTrue: [ pos := pos - myCommand itemCount ]
		ifFalse: [ myCommand positionStart: myCommand positionStart + 1 ].

	^ pos
]
