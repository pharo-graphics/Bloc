Class {
	#name : #BlLayoutMatchParentResizer,
	#superclass : #BlLayoutResizer,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Bloc-Layouts-Support'
}

{ #category : #cleanup }
BlLayoutMatchParentResizer class >> cleanUp [
	super cleanUp.
	
	uniqueInstance := nil
]

{ #category : #accessing }
BlLayoutMatchParentResizer class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #controlling }
BlLayoutMatchParentResizer >> ifMatchParent: aBlock [
	^ aBlock cull: self
]

{ #category : #testing }
BlLayoutMatchParentResizer >> isMatchParent [
	^ true
]

{ #category : #'double dispatching' }
BlLayoutMatchParentResizer >> measurementAtMostWith: aNumber [
	^ BlMeasurementSpec new beAtMost: aNumber
]

{ #category : #'double dispatching' }
BlLayoutMatchParentResizer >> measurementExactlyWith: aNumber [
	^ BlMeasurementSpec new beExact: aNumber
]

{ #category : #'double dispatching' }
BlLayoutMatchParentResizer >> measurementUnspecifiedWith: aNumber [
	^ BlMeasurementSpec new beUnspecified
]

{ #category : #printing }
BlLayoutMatchParentResizer >> printOn: aStream [
	aStream nextPutAll: 'Match parent'
]
