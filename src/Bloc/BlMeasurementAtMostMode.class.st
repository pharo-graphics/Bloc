"
I represent a concrete implementation of ""at most"" measurement mode.
For more information see class comment of BlMeasurementMode

"
Class {
	#name : #BlMeasurementAtMostMode,
	#superclass : #BlMeasurementMode,
	#category : #'Bloc-Layouts-Support'
}

{ #category : #testing }
BlMeasurementAtMostMode >> isAtMost [

	^ true
]

{ #category : #geometry }
BlMeasurementAtMostMode >> measurement: aResizing with: aFloat [	
	
	^ aResizing measurementAtMostWith: aFloat
]

{ #category : #printing }
BlMeasurementAtMostMode >> printOn: aStream [

	aStream nextPutAll: 'At most'
]

{ #category : #printing }
BlMeasurementAtMostMode >> printOn: aStream size: aNumber [

	self printOn: aStream.	
	aStream nextPutAll: ' '.
	aStream nextPutAll: aNumber asString
]

{ #category : #geometry }
BlMeasurementAtMostMode >> size: aNumber min: aMinSizeFloat max: aMaxSizeFloat [

	^ BlMeasurementSpec atMost: (aNumber min: aMaxSizeFloat)
]

{ #category : #geometry }
BlMeasurementAtMostMode >> size: aNumber with: aSpecSize [
	
	^ aNumber min: aSpecSize
]
