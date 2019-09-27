"
I am an extended version of a scalable element with zoom support
"
Class {
	#name : #BlZoomableElement,
	#superclass : #BlScalableElement,
	#traits : 'TBlDrawingCache',
	#classTraits : 'TBlDrawingCache classTrait',
	#instVars : [
		'zoomLevel'
	],
	#category : #'Bloc-Utilities - Scalable'
}

{ #category : #initialization }
BlZoomableElement >> computeZoomLevel [
	"Compute zoom level based on the extent of a content element and its scale transformation"
	<return: #Number>

	self hasContentElement
		ifFalse: [ ^ 1 ].

	(self contentElement width isZero or: [ self contentElement height isZero ])
		ifTrue: [ ^ 1 ].

	^ (self contentElement bounds transformed extent / self contentElement extent) min
]

{ #category : #testing }
BlZoomableElement >> hasZoomLevel [
	"Return true if zoom level is user-defined, otherwise false"
	<return: #Boolean>

	^ zoomLevel isNotNil
]

{ #category : #initialization }
BlZoomableElement >> initialize [
	super initialize.
	
	zoomLevel := nil.
	self fitAll
]

{ #category : #zooming }
BlZoomableElement >> zoomIn [
	self zoomLevel: self zoomLevel + self zoomStep
]

{ #category : #accessing }
BlZoomableElement >> zoomLevel [
	<return: #Number>

	^ self hasZoomLevel
		ifTrue: [ zoomLevel ]
		ifFalse: [ self computeZoomLevel ]
]

{ #category : #accessing }
BlZoomableElement >> zoomLevel: aNumber [
	zoomLevel := aNumber.
	self fixed: zoomLevel.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]
]

{ #category : #zooming }
BlZoomableElement >> zoomOut [
	self zoomLevel: self zoomLevel - self zoomStep
]

{ #category : #zooming }
BlZoomableElement >> zoomReset [
	zoomLevel := nil.
	self fitAll.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #accessing }
BlZoomableElement >> zoomStep [
	^ 0.1
]
