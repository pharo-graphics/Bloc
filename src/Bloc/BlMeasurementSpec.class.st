Class {
	#name : #BlMeasurementSpec,
	#superclass : #Object,
	#instVars : [
		'size',
		'mode'
	],
	#category : 'Bloc-Layouts-Support'
}

{ #category : #'instance creation' }
BlMeasurementSpec class >> atMost: aNumber [
	^ self new beAtMost: aNumber
]

{ #category : #'instance creation' }
BlMeasurementSpec class >> exact: aNumber [
	^ self new beExact: aNumber
]

{ #category : #'instance creation' }
BlMeasurementSpec class >> size: aSize mode: aMode [
	^ self new
		size: aSize;
		mode: aMode;
		yourself
]

{ #category : #'instance creation' }
BlMeasurementSpec class >> unspecified [
	^ self new beUnspecified
]

{ #category : #comparing }
BlMeasurementSpec >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].
	
	^ anotherObject size = size
		and: [ anotherObject mode = mode ]
]

{ #category : #composition }
BlMeasurementSpec >> @ heightMeasurementSpec [
	^ BlExtentMeasurementSpec new
		widthSpec: self;
		heightSpec: heightMeasurementSpec
]

{ #category : #converting }
BlMeasurementSpec >> beAtMost: aNumber [
	self
		size: aNumber;
		mode: BlMeasurementMode atMost
]

{ #category : #converting }
BlMeasurementSpec >> beExact: aNumber [
	self
		size: aNumber;
		mode: BlMeasurementMode exact
]

{ #category : #converting }
BlMeasurementSpec >> beUnspecified [
	self
		size: nil; "Explicitely telling that size is undefined - for understanding purposes"
		mode: BlMeasurementMode unspecified
]

{ #category : #comparing }
BlMeasurementSpec >> hash [
	^ size hash bitXor: mode hash
]

{ #category : #testing }
BlMeasurementSpec >> isAtMost [
	^ self mode isAtMost
]

{ #category : #testing }
BlMeasurementSpec >> isExact [
	^ self mode isExact
]

{ #category : #testing }
BlMeasurementSpec >> isUnspecified [
	^ self mode isUnspecified
]

{ #category : #accessing }
BlMeasurementSpec >> mode [
	^ mode
]

{ #category : #accessing }
BlMeasurementSpec >> mode: aMeasurementSpec [
	mode := aMeasurementSpec
]

{ #category : #printing }
BlMeasurementSpec >> printOn: aStream [
	self mode printOn: aStream size: self size
]

{ #category : #accessing }
BlMeasurementSpec >> size [
	^ size
]

{ #category : #accessing }
BlMeasurementSpec >> size: aNumber [
	size := aNumber
]

{ #category : #geometry }
BlMeasurementSpec >> sizeFor: aNumber [
	^ self mode size: aNumber with: size
]
