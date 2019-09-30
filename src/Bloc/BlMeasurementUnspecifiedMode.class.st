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
	<return: #Number>

	^ BlMeasurementSpec atMost: (aMinSize max: aMaxSize)
]

{ #category : #geometry }
BlMeasurementUnspecifiedMode >> size: aNumber with: aSpecSize [
	<return: #Number>
	
	^ aNumber
]
