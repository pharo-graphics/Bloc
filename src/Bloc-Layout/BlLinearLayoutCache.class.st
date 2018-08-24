"
I represent a linear layout cache.

I store values used by LinearLayout during measurement and layout passes.

I am used by LinearLayout.

Public API and Key Messages

	Setters and getters for different temporary variables used during measurement and layout passes.

 
Internal Representation and Key Implementation Points.

    Instance Variables
	alternativeMaxBreadth:		<Number>
	heightMeasureSpec:		<BlMeasurementSpec>
	heightMode:		<BlMeasurementMode>
	length:		<Number>
	matchBreadth:		<Boolean>
	matchingMaxBreadth:		<Number>
	maxBreadth:		<Number>
	totalLength:		<Number>
	totalWeight:		<Number>
	widthMeasureSpec:		<BlMeasurementSpec>
	widthMode:		<BlMeasurementMode>
"
Class {
	#name : #BlLinearLayoutCache,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'widthMode',
		'heightMode',
		'widthMeasureSpec',
		'heightMeasureSpec',
		'length',
		'matchBreadth',
		'totalLength',
		'totalWeight',
		'alternativeMaxBreadth',
		'matchingMaxBreadth',
		'maxBreadth'
	],
	#category : 'Bloc-Layout-Linear-Utilities'
}

{ #category : #accessing }
BlLinearLayoutCache >> alternativeMaxBreadth [
	^ alternativeMaxBreadth
]

{ #category : #accessing }
BlLinearLayoutCache >> alternativeMaxBreadth: anObject [
	alternativeMaxBreadth := anObject
]

{ #category : #accessing }
BlLinearLayoutCache >> heightMeasureSpec [
	^ heightMeasureSpec
]

{ #category : #accessing }
BlLinearLayoutCache >> heightMeasureSpec: anObject [
	heightMeasureSpec := anObject
]

{ #category : #accessing }
BlLinearLayoutCache >> heightMode [
	^ heightMode
]

{ #category : #accessing }
BlLinearLayoutCache >> heightMode: aBlMeasurementMode [
	self
		assert: [ aBlMeasurementMode isNotNil ]
		description: [ 'Height mode must not be nil' ].

	heightMode := aBlMeasurementMode
]

{ #category : #initialization }
BlLinearLayoutCache >> initialize [
	super initialize.
	
	self releaseCaches
]

{ #category : #initialization }
BlLinearLayoutCache >> initializeCaches: anElement with: anExtentMeasurementSpec [
	widthMeasureSpec := anExtentMeasurementSpec widthSpec.
	heightMeasureSpec := anExtentMeasurementSpec heightSpec.
	widthMode := widthMeasureSpec mode.
	heightMode := heightMeasureSpec mode.
	maxBreadth := 0.
	totalLength := 0.
	totalWeight := 0.
	matchingMaxBreadth := 0.
	alternativeMaxBreadth := 0.
	matchBreadth := false
]

{ #category : #accessing }
BlLinearLayoutCache >> length [
	^ length
]

{ #category : #accessing }
BlLinearLayoutCache >> length: aNumber [
	length := aNumber
]

{ #category : #accessing }
BlLinearLayoutCache >> matchBreadth [
	^ matchBreadth
]

{ #category : #accessing }
BlLinearLayoutCache >> matchBreadth: anObject [
	matchBreadth := anObject
]

{ #category : #accessing }
BlLinearLayoutCache >> matchingMaxBreadth [
	^ matchingMaxBreadth
]

{ #category : #accessing }
BlLinearLayoutCache >> matchingMaxBreadth: anObject [
	matchingMaxBreadth := anObject
]

{ #category : #accessing }
BlLinearLayoutCache >> maxBreadth [
	^ maxBreadth
]

{ #category : #accessing }
BlLinearLayoutCache >> maxBreadth: anObject [
	maxBreadth := anObject
]

{ #category : #initialization }
BlLinearLayoutCache >> releaseCaches [
	widthMeasureSpec := nil.
	heightMeasureSpec := nil.
	widthMode := nil.
	heightMode := nil.
	maxBreadth := 0.
	totalLength := 0.
	totalWeight := 0.
	matchingMaxBreadth := 0.
	alternativeMaxBreadth := 0.
	matchBreadth := false
]

{ #category : #accessing }
BlLinearLayoutCache >> totalLength [
	^ totalLength
]

{ #category : #accessing }
BlLinearLayoutCache >> totalLength: aNumber [
	totalLength := aNumber
]

{ #category : #accessing }
BlLinearLayoutCache >> totalWeight [
	^ totalWeight
]

{ #category : #accessing }
BlLinearLayoutCache >> totalWeight: anObject [
	totalWeight := anObject
]

{ #category : #accessing }
BlLinearLayoutCache >> widthMeasureSpec [
	^ widthMeasureSpec
]

{ #category : #accessing }
BlLinearLayoutCache >> widthMeasureSpec: anObject [
	widthMeasureSpec := anObject
]

{ #category : #accessing }
BlLinearLayoutCache >> widthMode [
	^ widthMode
]

{ #category : #accessing }
BlLinearLayoutCache >> widthMode: aBlMeasurementMode [
	self
		assert: [ aBlMeasurementMode isNotNil ]
		description: [ 'Height mode must not be nil' ].

	widthMode := aBlMeasurementMode
]
