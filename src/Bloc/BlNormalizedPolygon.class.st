Class {
	#name : #BlNormalizedPolygon,
	#superclass : #BlGeometry,
	#instVars : [
		'vertices'
	],
	#category : #'Bloc-Basic'
}

{ #category : #accessing }
BlNormalizedPolygon class >> vertices: aCollectionOfNormalizedPoints [
	^ self new vertices: aCollectionOfNormalizedPoints
]

{ #category : #converting }
BlNormalizedPolygon >> buildPathOnSpartaCanvas: aCanvas [
	| theScaledVertices aPathBuilder |
	
	aPathBuilder := aCanvas path. 
	
	theScaledVertices := self vertices collect: [ :eachVertex | (self extent * eachVertex) asFloatPoint ].
	theScaledVertices size <= 1
		ifTrue: [ ^ aPathBuilder build ].
	
	aPathBuilder moveTo: theScaledVertices first.
	theScaledVertices allButFirstDo: [ :eachVertex | aPathBuilder lineTo: eachVertex ].
	aPathBuilder close.

	^ aPathBuilder build
]

{ #category : #initialization }
BlNormalizedPolygon >> initialize [
	super initialize.
	
	vertices := #()
]

{ #category : #geometry }
BlNormalizedPolygon >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	extent := aPoint
]

{ #category : #accessing }
BlNormalizedPolygon >> vertices [
	<return: #Collection of: #Point>

	^ vertices
]

{ #category : #accessing }
BlNormalizedPolygon >> vertices: anObject [
	vertices := anObject
]
