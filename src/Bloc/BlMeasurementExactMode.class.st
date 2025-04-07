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
BlMeasurementExactMode >> measurement: aResizing with: aFloat [
	<return: #BlMeasurementSpec>
	
	^ aResizing measurementExactlyWith: aFloat
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
BlMeasurementExactMode >> size: aNumber min: aMinSizeFloat max: aMaxSizeFloat [

	^ BlMeasurementSpec exact:
		  (aNumber min: aMaxSizeFloat max: aMinSizeFloat)
]

{ #category : #geometry }
BlMeasurementExactMode >> size: aNumber with: aSpecSize [
	
	^ aSpecSize
]
