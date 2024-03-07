Class {
	#name : #BlInfiniteDataSourceRemoveCommand,
	#superclass : #BlInfiniteDataSourceCommand,
	#category : #'Bloc-Infinite-DataSource'
}

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
