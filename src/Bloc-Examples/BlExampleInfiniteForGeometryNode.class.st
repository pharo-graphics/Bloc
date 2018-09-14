Class {
	#name : #BlExampleInfiniteForGeometryNode,
	#superclass : #BrStencil,
	#instVars : [
		'nodes'
	],
	#category : #'Bloc-Examples-Infinite+Geometry'
}

{ #category : #adding }
BlExampleInfiniteForGeometryNode >> addNode: aNode [
	self nodes add: aNode
]

{ #category : #initialization }
BlExampleInfiniteForGeometryNode >> initialize [
	super initialize.
	
	nodes := OrderedCollection new
]

{ #category : #accessing }
BlExampleInfiniteForGeometryNode >> nodes [
	^ nodes
]
