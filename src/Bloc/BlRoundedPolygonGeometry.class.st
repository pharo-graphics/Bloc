"
I represent a polygon with rounded corners. The arc is indicated by the radius (same radius for all corners).
"
Class {
	#name : #BlRoundedPolygonGeometry,
	#superclass : #BlPolygonGeometry,
	#instVars : [
		'radius'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #'instance creation' }
BlRoundedPolygonGeometry class >> vertices: aCollection radius: aNumber [

	^ self new
		vertices: aCollection;
		radius: aNumber;
		yourself
]

{ #category : #accessing }
BlRoundedPolygonGeometry >> radius [

	^ radius
]

{ #category : #accessing }
BlRoundedPolygonGeometry >> radius: anInteger [

	radius := anInteger
]
