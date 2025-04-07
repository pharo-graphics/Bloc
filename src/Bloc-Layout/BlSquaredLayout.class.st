Class {
	#name : #BlSquaredLayout,
	#superclass : #BlLayout,
	#instVars : [
		'layout',
		'isTight'
	],
	#category : #'Bloc-Layout-Squared'
}

{ #category : #'instance creation' }
BlSquaredLayout class >> on: aBlLayout [
	<return: #BlSquaredLayout>

	^ self new layout: aBlLayout
]

{ #category : #accessing }
BlSquaredLayout >> beLoose [
	"Will use the max(width, height) to compute the extent"

	isTight := false
]

{ #category : #accessing }
BlSquaredLayout >> beTight [
	"Will use the min(width, height) to compute the extent"

	isTight := true
]

{ #category : #initialization }
BlSquaredLayout >> initialize [
	super initialize.
	
	layout := BlBasicLayout uniqueInstance.
	isTight := false "be loose by default"
]

{ #category : #testing }
BlSquaredLayout >> isLoose [
	^ self isTight not
]

{ #category : #testing }
BlSquaredLayout >> isTight [
	^ isTight
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
BlSquaredLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext [
	self layout layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext
]

{ #category : #measure }
BlSquaredLayout >> measure: anElement with: anExtentSpec [

	| aMeasuredExtent anExtent |
	"first measure to determine how big the element want to be"
	self layout measure: anElement with: anExtentSpec.

	aMeasuredExtent := anElement measuredExtent.

	"then compute squared extent"
	anExtent := self isTight
		            ifTrue: [ aMeasuredExtent min asPoint ]
		            ifFalse: [ aMeasuredExtent max asPoint ].

	aMeasuredExtent = anExtent ifTrue: [ ^ self ].

	"and finally re-measure everything with squared extent"
	self layout
		measure: anElement
		with: (BlExtentMeasurementSpec exact: anExtent)
]
