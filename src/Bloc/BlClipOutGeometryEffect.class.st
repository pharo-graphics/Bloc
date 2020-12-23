"
TODO needs some work to use it in dropdown to reveal the same toggle
"
Class {
	#name : #BlClipOutGeometryEffect,
	#superclass : #BlClipOutEffect,
	#instVars : [
		'geometry',
		'offset'
	],
	#category : #'Bloc-Effect'
}

{ #category : #accessing }
BlClipOutGeometryEffect >> geometry [
	^ geometry
]

{ #category : #accessing }
BlClipOutGeometryEffect >> geometry: anObject [
	geometry := anObject
]

{ #category : #initialization }
BlClipOutGeometryEffect >> initialize [
	super initialize.
	
	geometry := (0@0 extent: 0@0)
]

{ #category : #accessing }
BlClipOutGeometryEffect >> offset: aPoint [
	offset := aPoint
]

{ #category : #accessing }
BlClipOutGeometryEffect >> offsetFor: anElement [
	^ offset
]
