"
I am a Layout decorator that makes other layouts to be computed only once.

Example:

[[[
	| aLayout |	
	
	aLayout := BlOnceLayout on: BlGridLayout new.
	aLayout isStopped. ""false""
	"".... after layout is done....""
	aLayout isStopped. ""true""
]]]
"
Class {
	#name : #BlOnceLayout,
	#superclass : #BlBasicLayout,
	#instVars : [
		'layout',
		'isStopped',
		'measuredExtent'
	],
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #'instance creation' }
BlOnceLayout class >> on: aBlLayout [
	<return: #BlOnceLayout>

	^ self new layout: aBlLayout
]

{ #category : #initialization }
BlOnceLayout >> initialize [
	super initialize.

	isStopped := false.
	layout := BlBasicLayout new
]

{ #category : #accessing }
BlOnceLayout >> isStopped [
	^ isStopped
]

{ #category : #accessing }
BlOnceLayout >> isStopped: aBoolean [
	isStopped := aBoolean
]

{ #category : #accessing }
BlOnceLayout >> layout [
	^ layout
]

{ #category : #accessing }
BlOnceLayout >> layout: aBlLayout [
	layout := aBlLayout
]

{ #category : #layout }
BlOnceLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext [
	self isStopped
		ifTrue: [ ^ super layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext ].
	self layout layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext
]

{ #category : #measure }
BlOnceLayout >> measure: anElement with: anExtentSpec [
	self isStopped
		ifTrue: [ ^ super measure: anElement with: (BlExtentMeasurementSpec exact: measuredExtent) ].
	self layout measure: anElement with: anExtentSpec
]

{ #category : #'hooks - layout' }
BlOnceLayout >> onLayoutDone: anElement [
	super onLayoutDone: anElement.
	
	isStopped := true.
	anElement childrenDo: [ :aChildElement | aChildElement measuredBounds position: aChildElement position ].
	measuredExtent := anElement extent
]
