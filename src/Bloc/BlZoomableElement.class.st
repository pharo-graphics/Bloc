"
I am an extended version of a scalable element with zoom support
"
Class {
	#name : #BlZoomableElement,
	#superclass : #BlElement,
	#instVars : [
		'zoomLevel',
		'zoomCenter',
		'contentElement'
	],
	#category : #'Bloc-Utilities - Zoomable'
}

{ #category : #converting }
BlZoomableElement >> asScalableElement [
	^ self
]

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

{ #category : #accessing }
BlZoomableElement >> contentElement [
	"Return a content element that is being scaled"
	<return: #BlElement>

	self
		assert: [ contentElement isNotNil ]
		description: [ 'Can not access a content element when it is not provided' ].

	^ contentElement
]

{ #category : #accessing }
BlZoomableElement >> contentElement: anElement [
	"Specify an element that should be scaled according to my size.
	If I already have a content element, it will be replaced with a new one.
	anElement must not be nil."
	self
		assert: [ anElement isNotNil ]
		description: [ 'Content element must not be nil' ].

	self addChild: anElement
]

{ #category : #testing }
BlZoomableElement >> hasContentElement [
	"Return true if I have a content element, false otherwise"
	<return: #Boolean>
	
	^ contentElement isNotNil
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
	zoomCenter := 0.5@0.5.
	
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #layout }
BlZoomableElement >> measureMatching: anExtentMeasurementSpec [
	| widthSpec heightSpec aTransformedBounds |
	
	aTransformedBounds := self contentElement transformation inverseTransformBounds: self measuredBounds bounds.

	widthSpec := self contentElement constraints horizontal resizer isMatchParent
		ifTrue: [ BlMeasurementSpec exact: aTransformedBounds width ]
		ifFalse: [ 
			self layout
				measurementSpecFor: anExtentMeasurementSpec widthSpec
				usedSize: 0.0
				resizer: self contentElement constraints horizontal resizer ].
			
	heightSpec := self contentElement constraints vertical resizer isMatchParent
		ifTrue: [ BlMeasurementSpec exact: aTransformedBounds height ]
		ifFalse: [
			self layout
				measurementSpecFor: anExtentMeasurementSpec heightSpec
				usedSize: 0.0
				resizer: self contentElement constraints vertical resizer ].
			
	self contentElement measure: widthSpec @ heightSpec
]

{ #category : #layout }
BlZoomableElement >> measureScale [
	"Compute and return a scale factor of the content element based on the current scale strategy"
	| aScaleFactor |
	<return: #Number>

	self hasContentElement
		ifFalse: [ 1.0 ].
		
	aScaleFactor := self hasZoomLevel
		ifTrue: [ zoomLevel ]
		ifFalse: [ | aMeasuredExtent |
			aMeasuredExtent := self contentElement measuredExtent.
			(aMeasuredExtent x * aMeasuredExtent y) isZero
				ifTrue: [ 1.0 ]
				ifFalse: [ (self measuredExtent / aMeasuredExtent) min asFloat ] ].
	
	"we must not scale by zero! Otherwise matrix becomes singular"
	aScaleFactor isZero
		ifTrue: [ aScaleFactor := 1.0 ].
		
	^ aScaleFactor
]

{ #category : #'hooks - children' }
BlZoomableElement >> onChildAdded: anElement [
	"I make sure that there is only one child"
	super onChildAdded: anElement.

	"If we already have a content element, we should remove an old one
	in order to replace it with one just provided"
	self hasContentElement
		ifTrue: [ self removeChild: self contentElement ].

	contentElement := anElement
]

{ #category : #layout }
BlZoomableElement >> onLayout: aBounds [
	| aContentBounds |

	self hasContentElement
		ifFalse: [ ^ self ].

	aContentBounds := BlBounds origin: 0.0@0.0 extent: self contentElement measuredExtent.
	aContentBounds translateBy: (self measuredExtent - aContentBounds extent) / 2.0.
	aContentBounds translateBy: (self measuredExtent) * ((0.5 asPoint - zoomCenter)) * self zoomLevel.
	aContentBounds translateBy: ((aContentBounds extent - self measuredExtent)) * (0.5 - zoomCenter) * self zoomLevel.
	
	self contentElement applyLayoutIn: aContentBounds
]

{ #category : #layout }
BlZoomableElement >> onMeasure: anExtentMeasurementSpec [
	| aScaleFactor aTransformedExtent |
	"First we perform a default measurement"
	super onMeasure: anExtentMeasurementSpec.
	
	self hasContentElement
		ifFalse: [ ^ self ].
	
	"and then we scale a content element according to scaling strategy"
	aScaleFactor := self measureScale.

	self contentElement
		transformDo: [ :t |
			"t origin: (BlAffineTransformationNormalizedPositionOrigin position: (1 - zoomCenter))."
			t scaleBy: aScaleFactor asPoint ].

	aTransformedExtent := self contentElement measuredBounds transformed extent.
	self measuredExtent: (anExtentMeasurementSpec sizeFor: aTransformedExtent).

	(self contentElement constraints horizontal resizer isMatchParent
		or: [ self contentElement constraints vertical resizer isMatchParent ] )
			ifTrue: [ self measureMatching: anExtentMeasurementSpec ]
]

{ #category : #accessing }
BlZoomableElement >> zoomCenter [
	<return: #Point>

	^ zoomCenter
]

{ #category : #accessing }
BlZoomableElement >> zoomCenter: aPoint [
	"Zoom center defines a point of the content element which should be in the middle of the zoomable
	element when zoomed in or zoomed out.
	By default the center of the content element matches the center of the zoomable element, hence the zoomCenter is 0.5@0.5"

	zoomCenter := aPoint asPoint.
	self requestLayout
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
	self requestLayout
]

{ #category : #zooming }
BlZoomableElement >> zoomOut [
	self zoomLevel: self zoomLevel - self zoomStep
]

{ #category : #zooming }
BlZoomableElement >> zoomReset [
	zoomLevel := nil.
	zoomCenter := 0.5 asPoint.
	self requestLayout.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #accessing }
BlZoomableElement >> zoomStep [
	^ 0.1
]
