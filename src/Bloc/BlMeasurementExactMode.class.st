"
I represent a concrete implementation of ""exact"" measurement mode.
For more information see class comment of BlMeasurementMode
"
Class {
	#name : #BlMeasurementExactMode,
	#superclass : #BlMeasurementMode,
	#category : #'Bloc-Layouts-Support'
}

{ #category : #testing }
BlMeasurementExactMode >> isExact [
	^ true
]

{ #category : #geometry }
BlMeasurementExactMode >> measurement: aResizing with: aNumber [
	<argument: #aNumber satisfies: #isFloat>
	<return: #BlMeasurementSpec>
	
	^ aResizing measurementExactlyWith: aNumber
]

{ #category : #printing }
BlMeasurementExactMode >> printOn: aStream [
	aStream nextPutAll: 'Exact'
]

{ #category : #printing }
BlMeasurementExactMode >> printOn: aStream size: aNumber [

	self printOn: aStream.	
	aStream nextPutAll: ' '.
	aStream nextPutAll: aNumber asString
]

{ #category : #geometry }
BlMeasurementExactMode >> size: aNumber min: aMinSize max: aMaxSize [
	<argument: #aNumber satisfies: #isBlocFiniteFloat>
	<argument: #aMinSize satisfies: #isBlocFiniteFloat>
	<argument: #aMaxSize satisfies: #isFloat>
	<return: #Number>
	
	^ BlMeasurementSpec exact: (aNumber min: aMaxSize max: aMinSize)
]

{ #category : #geometry }
BlMeasurementExactMode >> size: aNumber with: aSpecSize [
	<argument: #aNumber satisfies: #isBlocFiniteFloat>
	<return: #Number>
	
	^ aSpecSize
]
