Class {
	#name : #BlPannableElement,
	#superclass : #BlElement,
	#instVars : [
		'zoomableElement'
	],
	#category : #'Bloc-Utilities - Pannable'
}

{ #category : #conversion }
BlPannableElement >> asPannableElement [
	^ self
]

{ #category : #conversion }
BlPannableElement >> asScalableElement [
	^ self
]

{ #category : #conversion }
BlPannableElement >> asScrollableElement [
	^ self
]

{ #category : #converting }
BlPannableElement >> asSpartaForm [
	<return: #Form>

	^ self contentElement asSpartaForm
]

{ #category : #accessing }
BlPannableElement >> contentElement [
	<return: #BlElement>

	^ self zoomableElement contentElement
]

{ #category : #accessing }
BlPannableElement >> contentElement: anElement [
	self zoomableElement contentElement: anElement.
	self zoomToFit
]

{ #category : #'api - testing' }
BlPannableElement >> hasContentElement [
	"Return true if I have a content element, false otherwise"
	<return: #Boolean>

	^ zoomableElement hasContentElement
]

{ #category : #initialization }
BlPannableElement >> initialize [
	super initialize.
	
	zoomableElement := BlZoomableElement new.
	self addEventHandler: BlSlideHandler new.
	
	self addChild: zoomableElement.
	
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #'api - zooming' }
BlPannableElement >> zoomIn [
	self zoomableElement zoomIn
]

{ #category : #'api - zooming' }
BlPannableElement >> zoomLevel [
	<return: #Number>

	^ self zoomableElement zoomLevel
]

{ #category : #'api - zooming' }
BlPannableElement >> zoomOut [
	self zoomableElement zoomOut
]

{ #category : #'api - zooming' }
BlPannableElement >> zoomStep: aNumber [
	self zoomableElement zoomStep: aNumber
]

{ #category : #'api - zooming' }
BlPannableElement >> zoomTo: aZoomFactor [
	self zoomableElement zoomLevel: aZoomFactor
]

{ #category : #'api - zooming' }
BlPannableElement >> zoomToActualSize [
	self zoomTo: 1
]

{ #category : #'api - zooming' }
BlPannableElement >> zoomToFit [
	self zoomableElement zoomReset
]

{ #category : #accessing }
BlPannableElement >> zoomableElement [
	<return: #BlZoomableElement>
	
	^ zoomableElement
]
