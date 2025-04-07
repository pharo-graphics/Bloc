Class {
	#name : #BlInfiniteDataSourceAddCommand,
	#superclass : #BlInfiniteDataSourceCommand,
	#category : #'Bloc-Infinite-DataSource'
}

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
BlInfiniteDataSourceAddCommand >> dispatchToLayout: aLayout [

	aLayout onItemsAddedAt: self positionStart count: self itemCount
]

{ #category : #testing }
BlInfiniteDataSourceAddCommand >> isAdd [

	^ true
]

{ #category : #commands }
BlInfiniteDataSourceAddCommand >> offsetPositionsIn: anInfiniteElement [

	anInfiniteElement
		offsetPositionRecordsForInsert: self positionStart
		itemCount: self itemCount
]
