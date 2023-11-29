Class {
	#name : 'BlInfiniteDataSourceCommandTypeMove',
	#superclass : 'BlInfiniteDataSourceCommandType',
	#category : 'Bloc-Infinite-DataSource',
	#package : 'Bloc-Infinite',
	#tag : 'DataSource'
}

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeMove >> apply: aCommand in: anInfiniteElement [
	anInfiniteElement dataSourceManager postponeAndUpdateElementHolders: aCommand on: anInfiniteElement
]

{ #category : 'dispatch' }
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

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeMove >> continuous: aPosition start: start [
	self shouldNotImplement
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeMove >> dispatch: aCommand toLayout: aLayout [
	aLayout onItemsMovedFrom: aCommand positionStart to: aCommand itemCount itemCount: 1
]

{ #category : 'testing' }
BlInfiniteDataSourceCommandTypeMove >> isMove [
	^ true
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeMove >> offsetPositions: aCommand in: anInfiniteElement [

	anInfiniteElement dataSourceManager
		offsetPositionsForMove: aCommand positionStart
		to: aCommand itemCount
		in: anInfiniteElement

]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeMove >> positionMultiplier [
	self shouldNotImplement
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeMove >> updateElementHoldersIn: anInfiniteElement command: aCommand [

	anInfiniteElement dataSourceManager
		offsetPositionsForMove: aCommand startPosition
		to: aCommand itemCount
		in: anInfiniteElement 
]

{ #category : 'dispatch' }
BlInfiniteDataSourceCommandTypeMove >> updateElementHoldersIn: anInfiniteElement offset: offsetStart command: aCommand [
	self shouldNotImplement
]

{ #category : 'dispatch' }
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
