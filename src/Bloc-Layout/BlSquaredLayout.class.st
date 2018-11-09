Class {
	#name : #BlSquaredLayout,
	#superclass : #BlLayout,
	#instVars : [
		'layout'
	],
	#category : #'Bloc-Layout-Square'
}

{ #category : #initialization }
BlSquaredLayout >> initialize [
	super initialize.
	
	layout := BlBasicLayout new
]

{ #category : #accessing }
BlSquaredLayout >> layout [
	^ layout
]

{ #category : #accessing }
BlSquaredLayout >> layout: aLayout [
	layout := aLayout
]

{ #category : #measure }
BlSquaredLayout >> measure: anElement with: anExtentSpec [
	| anExtent |
	
	"first measure to determine how big the element want to be"
	self layout measure: anElement with: anExtentSpec.
	
	"then compute squared extent"
	anExtent := anElement measuredExtent max asPoint.
	
	"and finally re-measure everything with squared extent"
	self layout measure: anElement with: (BlExtentMeasurementSpec exact: anExtent)
]
