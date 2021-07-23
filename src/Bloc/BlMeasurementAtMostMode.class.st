"
I represent a concrete implementation of ""at most"" measurement mode.
For more information see class comment of BlMeasurementMode

"
Class {
	#name : 'BlMeasurementAtMostMode',
	#superclass : 'BlMeasurementMode',
	#category : 'Bloc-Layouts-Support'
}

{ #category : 'testing' }
BlMeasurementAtMostMode >> isAtMost [
	^ true
]

{ #category : 'geometry' }
BlMeasurementAtMostMode >> measurement: aResizing with: aNumber [
	<argument: #aNumber satisfies: #isFloat>
	<return: #BlMeasurementSpec>
	
	^ aResizing measurementAtMostWith: aNumber
]

{ #category : 'printing' }
BlMeasurementAtMostMode >> printOn: aStream [
	aStream nextPutAll: 'At most'
]

{ #category : 'printing' }
BlMeasurementAtMostMode >> printOn: aStream size: aNumber [

	self printOn: aStream.	
	aStream nextPutAll: ' '.
	aStream nextPutAll: aNumber asString
]

{ #category : 'geometry' }
BlMeasurementAtMostMode >> size: aNumber min: aMinSize max: aMaxSize [
	<argument: #aNumber satisfies: #isBlocFiniteFloat>
	<argument: #aMinSize satisfies: #isBlocFiniteFloat>
	<argument: #aMaxSize satisfies: #isFloat>
	<return: #Number>
	
	^ BlMeasurementSpec atMost: (aNumber min: aMaxSize)
]

{ #category : 'geometry' }
BlMeasurementAtMostMode >> size: aNumber with: aSpecSize [
	<argument: #aNumber satisfies: #isBlocFiniteFloat>
	<return: #Number>
	
	^ aNumber min: aSpecSize
]
