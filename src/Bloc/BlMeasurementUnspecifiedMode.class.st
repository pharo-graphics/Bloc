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
BlMeasurementUnspecifiedMode >> measurement: aResizing with: aFloat [
	<return: #BlMeasurementSpec>
	
	^ aResizing measurementUnspecifiedWith: aFloat
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
BlMeasurementUnspecifiedMode >> size: aNumber min: aMinSizeFloat max: aMaxSizeFloat [

	^ BlMeasurementSpec atMost: (aMinSizeFloat max: aMaxSizeFloat)
]

{ #category : #geometry }
BlMeasurementUnspecifiedMode >> size: aNumber with: aSpecSize [
	
	^ aNumber
]
