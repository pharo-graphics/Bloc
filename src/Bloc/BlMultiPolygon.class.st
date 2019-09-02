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
BlMultiPolygon >> polygons: anObject [
	polygons := anObject.
	extent := (self polygons detectMax: [ :eachPolygon | eachPolygon max ]) max
]
