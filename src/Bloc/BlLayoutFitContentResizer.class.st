Class {
	#name : #BlLayoutFitContentResizer,
	#superclass : #BlLayoutResizer,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Layouts-Support'
}

{ #category : #cleanup }
BlLayoutFitContentResizer class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlLayoutFitContentResizer class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #controlling }
BlLayoutFitContentResizer >> ifFitContent: aBlock [
	^ aBlock cull: self
]

{ #category : #testing }
BlLayoutFitContentResizer >> isFitContent [
	^ true
]

{ #category : #'double dispatching' }
BlLayoutFitContentResizer >> measurementAtMostWith: aNumber [
	^ BlMeasurementSpec new beAtMost: aNumber
]

{ #category : #'double dispatching' }
BlLayoutFitContentResizer >> measurementExactlyWith: aNumber [
	^ BlMeasurementSpec unspecified
   "^ BlMeasurementSpec new beAtMost: aNumber"
]

{ #category : #'double dispatching' }
BlLayoutFitContentResizer >> measurementUnspecifiedWith: aNumber [
	^ BlMeasurementSpec unspecified
]

{ #category : #printing }
BlLayoutFitContentResizer >> printOn: aStream [
	aStream nextPutAll: 'Fit content'
]
