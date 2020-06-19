"
I represent a concrete implementation of ""unspecified"" measurement mode.
For more information see class comment of BlMeasurementMode
"
Class {
	#name : #BlMeasurementUnspecifiedMode,
	#superclass : #BlMeasurementMode,
	#category : #'Bloc-Layouts-Support'
}

{ #category : #testing }
BlMeasurementUnspecifiedMode >> isUnspecified [
	^ true
]

{ #category : #geometry }
BlMeasurementUnspecifiedMode >> measurement: aResizing with: aNumber [
	<argument: #aNumber satisfies: #isFloat>
	<return: #BlMeasurementSpec>
	
	^ aResizing measurementUnspecifiedWith: aNumber
]

{ #category : #printing }
BlMeasurementUnspecifiedMode >> printOn: aStream [
	aStream nextPutAll: 'Unspecified'
]

{ #category : #printing }
BlMeasurementUnspecifiedMode >> printOn: aStream size: aNumber [

	self printOn: aStream
]

{ #category : #geometry }
BlMeasurementUnspecifiedMode >> size: aNumber min: aMinSize max: aMaxSize [
	<argument: #aNumber satisfies: #isBlocFiniteFloat>
	<argument: #aMinSize satisfies: #isBlocFiniteFloat>
	<argument: #aMaxSize satisfies: #isFloat>
	<return: #Number>

	^ BlMeasurementSpec atMost: (aMinSize max: aMaxSize)
]

{ #category : #geometry }
BlMeasurementUnspecifiedMode >> size: aNumber with: aSpecSize [
	<argument: #aNumber satisfies: #isBlocFiniteFloat>
	<return: #Number>
	
	^ aNumber
]
