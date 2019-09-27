Class {
	#name : #BlMultiPolygon,
	#superclass : #BlGeometry,
	#instVars : [
		'polygons'
	],
	#category : #'Bloc-Basic'
}

{ #category : #'instance creation' }
BlMultiPolygon class >> polygons: aCollectionOfCollectionOfPoints [
	^ self new polygons: aCollectionOfCollectionOfPoints
]

{ #category : #geometry }
BlMultiPolygon >> matchExtent: anExtent [
	extent := anExtent
]

{ #category : #accessing }
BlMultiPolygon >> polygons [
	^ polygons
]

{ #category : #accessing }
BlMultiPolygon >> polygons: aCollectionOfPolygons [
	polygons := aCollectionOfPolygons.
	
	extent := self polygons
		ifEmpty: [ 0@0 ]
		ifNotEmpty: [ :thePolygons | (thePolygons detectMax: [ :eachPolygon | eachPolygon max ]) max ]
]
