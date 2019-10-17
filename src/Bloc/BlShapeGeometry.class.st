Class {
	#name : #BlShapeGeometry,
	#superclass : #BlGeometry,
	#instVars : [
		'shapeBuilder',
		'vectorShape'
	],
	#category : #'Bloc-Basic'
}

{ #category : #private }
BlShapeGeometry >> createVectorShape [
	^ shapeBuilder value: (0@0 extent: extent)
]

{ #category : #geometry }
BlShapeGeometry >> extent: aPoint [
	extent := aPoint.
	vectorShape := self createVectorShape.
	self releaseCache
]

{ #category : #initialization }
BlShapeGeometry >> initialize [
	super initialize.

	shapeBuilder := [ :aRectangle | BlRectangleShape rectangle: aRectangle ].
	vectorShape := self createVectorShape
]

{ #category : #geometry }
BlShapeGeometry >> matchExtent: aPoint [
	self extent: aPoint
]

{ #category : #accessing }
BlShapeGeometry >> shape: aBlock [
	shapeBuilder := aBlock.
	vectorShape := self createVectorShape.
	self releaseCache
]
