Class {
	#name : #BlInfiniteDataSourceUpdateCommand,
	#superclass : #BlInfiniteDataSourceCommand,
	#category : #'Bloc-Infinite-DataSource'
}

{ #category : #commands }
BlInfiniteDataSourceUpdateCommand >> applyOnPosition: aPosition [

	^ aPosition
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
