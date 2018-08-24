"
I represent a concrete ""add"" command type
"
Class {
	#name : #BlInfiniteDataSourceCommandTypeAdd,
	#superclass : #BlInfiniteDataSourceCommandType,
	#category : 'Bloc-Infinite-DataSource-Support'
}

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeAdd >> apply: aCommand on: aContext [
	aContext postponeAndUpdateElementHolders: aCommand
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeAdd >> apply: aCommand onPosition: aPosition [
	|newPosition|
	
	aCommand positionStart <= aPosition
		ifTrue: [ newPosition := aPosition + aCommand itemCount ]
		ifFalse: [ newPosition := aPosition ].

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
BlInfiniteDataSourceCommandTypeAdd >> offsetPositions: aCommand on: aDataSourceController [
	aDataSourceController
		offsetPositions: aCommand positionStart
		forAdd: aCommand itemCount
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeAdd >> positionMultiplier [
	self shouldNotImplement
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeAdd >> swapMoveOn: aContext in: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex [
	aContext swapMoveAddIn: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeAdd >> updateElementHoldersOn: aContext command: aCommand [
	aContext controller
		offsetPositions: aCommand positionStart
		forAdd: aCommand itemCount
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeAdd >> updateElementHoldersOn: aContext offset: offsetStart command: aCommand [
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
