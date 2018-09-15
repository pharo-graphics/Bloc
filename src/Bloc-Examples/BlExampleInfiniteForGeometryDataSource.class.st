Class {
	#name : #BlExampleInfiniteForGeometryDataSource,
	#superclass : #BlInfiniteDataSource,
	#instVars : [
		'nodes'
	],
	#category : #'Bloc-Examples-Infinite+Geometry'
}

{ #category : #initialization }
BlExampleInfiniteForGeometryDataSource >> initialize [
	super initialize.
	
	nodes := OrderedCollection new
]

{ #category : #accessing }
BlExampleInfiniteForGeometryDataSource >> itemCount [
	^ self nodes size
]

{ #category : #accessing }
BlExampleInfiniteForGeometryDataSource >> nodes [
	^ nodes
]

{ #category : #accessing }
BlExampleInfiniteForGeometryDataSource >> nodes: theNodes [
	nodes := theNodes.
	self notifyChanged
]

{ #category : #'instance creation' }
BlExampleInfiniteForGeometryDataSource >> onBindHolder: anElementHolder at: aPosition [
	anElementHolder node: (self nodes at: aPosition)
]

{ #category : #'instance creation' }
BlExampleInfiniteForGeometryDataSource >> onCreateHolder: anInfiniteElement type: anItemType [
	^ BlExampleInfiniteForGeometryHolder new
]
