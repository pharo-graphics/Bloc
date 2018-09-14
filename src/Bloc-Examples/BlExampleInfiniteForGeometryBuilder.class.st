Class {
	#name : #BlExampleInfiniteForGeometryBuilder,
	#superclass : #Object,
	#instVars : [
		'currentNode'
	],
	#category : #'Bloc-Examples-Infinite+Geometry'
}

{ #category : #private }
BlExampleInfiniteForGeometryBuilder >> addNode: aNode [
	currentNode
		ifNil: [ currentNode := aNode ]
		ifNotNil: [ currentNode addNode: aNode ]
]

{ #category : #private }
BlExampleInfiniteForGeometryBuilder >> addNode: aNode thenDo: aBlock [
	self addNode: aNode.
	self withNode: aNode do: aBlock
]

{ #category : #accessing }
BlExampleInfiniteForGeometryBuilder >> custom: aNode [
	self
		addNode: aNode
		thenDo: []
]

{ #category : #accessing }
BlExampleInfiniteForGeometryBuilder >> custom: aNode with: aBlock [
	self
		addNode: aNode
		thenDo: aBlock
]

{ #category : #accessing }
BlExampleInfiniteForGeometryBuilder >> frame: aBlock [
	self
		addNode: BlExampleInfiniteForGeometryFrameNode new
		thenDo: aBlock
]

{ #category : #accessing }
BlExampleInfiniteForGeometryBuilder >> infinite: aBlock [
	self
		addNode: BlExampleInfiniteForGeometryInfiniteNode new
		thenDo: aBlock
]

{ #category : #accessing }
BlExampleInfiniteForGeometryBuilder >> linear: aBlock [
	self
		addNode: BlExampleInfiniteForGeometryLinearNode new
		thenDo: aBlock
]

{ #category : #accessing }
BlExampleInfiniteForGeometryBuilder >> node [
	^ currentNode
]

{ #category : #private }
BlExampleInfiniteForGeometryBuilder >> withNode: aNode do: aBlock [
	| aPreviousNode |
	
	aPreviousNode := currentNode.
	[
		currentNode := aNode.
		aBlock cull: aNode ] ensure: [ currentNode := aPreviousNode ]
]
