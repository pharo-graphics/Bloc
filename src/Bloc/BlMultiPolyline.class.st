Class {
	#name : #BlMultiPolyline,
	#superclass : #BlGeometry,
	#instVars : [
		'polylines'
	],
	#category : #'Bloc-Basic'
}

{ #category : #'instance creation' }
BlMultiPolyline class >> polygons: aCollectionOfCollectionOfPoints [
	^ self new polygons: aCollectionOfCollectionOfPoints
]

{ #category : #geometry }
BlMultiPolyline >> matchExtent: anExtent [
	extent := anExtent
]

{ #category : #accessing }
BlMultiPolyline >> polylines [
	^ polylines
]

{ #category : #accessing }
BlMultiPolyline >> polylines: aCollectionOfPolylines [
	polylines := aCollectionOfPolylines.
	
	extent := self polylines
		ifEmpty: [ 0@0 ]
		ifNotEmpty: [ :thePolyline | (thePolyline detectMax: [ :eachPolyline | eachPolyline max ]) max ]
]
