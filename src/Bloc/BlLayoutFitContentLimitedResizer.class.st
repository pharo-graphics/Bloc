Class {
	#name : #BlLayoutFitContentLimitedResizer,
	#superclass : #BlLayoutResizer,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Layouts-Support'
}

{ #category : #cleanup }
BlLayoutFitContentLimitedResizer class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlLayoutFitContentLimitedResizer class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #controlling }
BlLayoutFitContentLimitedResizer >> ifFitContent: aBlock [
	^ aBlock cull: self
]

{ #category : #testing }
BlLayoutFitContentLimitedResizer >> isFitContent [
	^ true
]

{ #category : #'double dispatching' }
BlLayoutFitContentLimitedResizer >> measurementAtMostWith: aNumber [
	^ BlMeasurementSpec new beAtMost: aNumber
]

{ #category : #'double dispatching' }
BlLayoutFitContentLimitedResizer >> measurementExactlyWith: aNumber [
   ^ BlMeasurementSpec new beAtMost: aNumber
]

{ #category : #'double dispatching' }
BlLayoutFitContentLimitedResizer >> measurementUnspecifiedWith: aNumber [
	^ BlMeasurementSpec unspecified
]

{ #category : #printing }
BlLayoutFitContentLimitedResizer >> printOn: aStream [
	aStream nextPutAll: 'Fit content limited'
]
