"
I represent a concrete ""move"" command type
"
Class {
	#name : #BlInfiniteDataSourceCommandTypeMove,
	#superclass : #BlInfiniteDataSourceCommandType,
	#category : 'Bloc-Infinite-DataSource-Support'
}

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeMove >> apply: aCommand on: aContext [
	aContext postponeAndUpdateElementHolders: aCommand
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeMove >> apply: aCommand onPosition: aPosition [
	| newPosition |
	
	aCommand positionStart = aPosition
		ifTrue: [ newPosition := aCommand itemCount ]
		ifFalse: [ 
			newPosition := aPosition.
			(aCommand positionStart < aPosition)
				ifTrue: [ newPosition := aPosition - 1 ].
			(aCommand itemCount <= aPosition)
				ifTrue: [ newPosition := aPosition + 1 ] ].
	
	^ newPosition
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeMove >> continuous: aPosition start: start [
	self shouldNotImplement
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeMove >> dispatch: aCommand toLayout: aLayout [
	aLayout onItemsMovedFrom: aCommand positionStart to: aCommand itemCount itemCount: 1
]

{ #category : #testing }
BlInfiniteDataSourceCommandTypeMove >> isMove [
	^ true
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeMove >> offsetPositions: aCommand on: aDataSourceController [
	aDataSourceController
		offsetPositionsForMove: aCommand positionStart
		to: aCommand itemCount
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeMove >> positionMultiplier [
	self shouldNotImplement
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeMove >> swapMoveOn: aContext in: aListOfCommands badMoveIndex: badMoveIndex nextIndex: nextIndex [
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeMove >> updateElementHoldersOn: aContext command: aCommand [
	aContext controller
		offsetPositionsForMove: aCommand startPosition
		to: aCommand itemCount
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeMove >> updateElementHoldersOn: aContext offset: offsetStart command: aCommand [
	self shouldNotImplement
]

{ #category : #dispatch }
BlInfiniteDataSourceCommandTypeMove >> updatePosition: aPosition with: aCommand from: myCommand [
	|start end pos|
	pos := aPosition.
	
	myCommand positionStart < myCommand itemCount
		ifTrue: [
			start := myCommand positionStart.
			end := myCommand itemCount ]
		ifFalse: [
			start := myCommand itemCount.
			end := myCommand positionStart ].
		
	(pos >= start and: [ pos <= end ])
		ifTrue: [
			start = myCommand positionStart
				ifTrue: [
					aCommand isAdd
						ifTrue: [ myCommand itemCount: myCommand itemCount + 1 ]
						ifFalse: [ aCommand isRemove
							ifTrue: [ myCommand itemCount: myCommand itemCount - 1 ] ].
					pos := pos + 1 ]
				ifFalse: [ 
					aCommand isAdd
						ifTrue: [ myCommand positionStart: myCommand positionStart + 1 ]
						ifFalse: [ aCommand isRemove
							ifTrue: [ myCommand positionStart: myCommand positionStart - 1 ] ].
					pos := pos - 1 ] ]
		ifFalse: [ 
			(pos < myCommand positionStart) ifTrue: [ 
				aCommand isAdd
					ifTrue: [
						myCommand positionStart: myCommand positionStart + 1.
						myCommand itemCount: myCommand itemCount + 1 ]
					ifFalse: [ aCommand isRemove
						ifTrue: [
							myCommand positionStart: myCommand positionStart - 1.
							myCommand itemCount: myCommand itemCount - 1 ] ] ] ].
	^ pos
]
