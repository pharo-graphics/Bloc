Class {
	#name : #BlMultiPolygonGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'polygons'
	],
	#category : 'Bloc-Basic-Geometry'
}

{ #category : #'instance creation' }
BlMultiPolygonGeometry class >> polygons: aCollectionOfCollectionOfPoints [
	^ self new polygons: aCollectionOfCollectionOfPoints
]

{ #category : #geometry }
BlMultiPolygonGeometry >> matchExtent: anExtent [
	extent := anExtent
]

{ #category : #accessing }
BlMultiPolygonGeometry >> polygons [
	^ polygons
]

{ #category : #accessing }
BlMultiPolygonGeometry >> polygons: aCollectionOfPolygons [
	polygons := aCollectionOfPolygons.
	
	extent := self polygons
		ifEmpty: [ 0@0 ]
		ifNotEmpty: [ :thePolygons | (thePolygons detectMax: [ :eachPolygon | eachPolygon max ]) max ]
]
