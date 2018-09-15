Class {
	#name : #BlExampleInfiniteForGeometryHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'node'
	],
	#category : #'Bloc-Examples-Infinite+Geometry'
}

{ #category : #initialization }
BlExampleInfiniteForGeometryHolder >> initialize [
	super initialize
]

{ #category : #accessing }
BlExampleInfiniteForGeometryHolder >> node: aNode [
	itemElement := aNode asElement.
	itemElement removeFromParent
]
