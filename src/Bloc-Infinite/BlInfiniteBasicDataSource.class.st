Class {
	#name : 'BlInfiniteBasicDataSource',
	#superclass : 'BlInfiniteDataSource',
	#instVars : [
		'layoutPositionsRange'
	],
	#category : 'Bloc-Infinite-DataSource',
	#package : 'Bloc-Infinite',
	#tag : 'DataSource'
}

{ #category : 'accessing' }
BlInfiniteBasicDataSource >> itemCount [
	"There are no items in empty datasource"
	<return: #Number>

	^ 0
]

{ #category : 'accessing' }
BlInfiniteBasicDataSource >> layoutPositionsRange: anInterval [
	layoutPositionsRange := anInterval
]
