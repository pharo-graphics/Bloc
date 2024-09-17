Class {
	#name : #BlLayoutExactResizer,
	#superclass : #BlLayoutResizer,
	#instVars : [
		'size'
	],
	#classInstVars : [
		'zero',
		'fifty',
		'hundred'
	],
	#category : #'Bloc-Layouts-Support'
}

{ #category : #cleanup }
BlLayoutExactResizer class >> cleanUp [
	super cleanUp.
	
	zero := nil.
	fifty := nil.
	hundred := nil
]

{ #category : #accessing }
BlLayoutExactResizer class >> fifty [
	^ fifty ifNil: [ fifty := self new size: 50.0 ]
]

{ #category : #accessing }
BlLayoutExactResizer class >> hundred [
	^ hundred ifNil: [ hundred := self new size: 100.0 ]
]

{ #category : #accessing }
BlLayoutExactResizer class >> size: aNumber [
	aNumber isZero
		ifTrue: [ ^ self zero ].
		
	aNumber = 50
		ifTrue: [ ^ self fifty ].
		
	aNumber = 100
		ifTrue: [ ^ self hundred ].

	^ self new
		size: aNumber;
		yourself 
]

{ #category : #accessing }
BlLayoutExactResizer class >> zero [
	^ zero ifNil: [ zero := self new size: 0.0 ]
]

{ #category : #comparing }
BlLayoutExactResizer >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ self size = anObject size
]

{ #category : #comparing }
BlLayoutExactResizer >> hash [
	^ super hash bitXor: self size hash
]

{ #category : #controlling }
BlLayoutExactResizer >> ifExact: aBlock [
	^ aBlock cull: self
]

{ #category : #testing }
BlLayoutExactResizer >> isExact [
	^ true
]

{ #category : #'double dispatching' }
BlLayoutExactResizer >> measurementAtMostWith: aNumber [
	"Parent has imposed a maximum size on us. Child wants a specific size... so be it"

	^ BlMeasurementSpec exact: self size
]

{ #category : #'double dispatching' }
BlLayoutExactResizer >> measurementExactlyWith: aNumber [
	"Parent has imposed an exact size on us"
	<return: #BlMeasurementSpec>
	
	^ BlMeasurementSpec exact: self size
]

{ #category : #'double dispatching' }
BlLayoutExactResizer >> measurementUnspecifiedWith: aNumber [
	"Child wants a specific size... let it have it"
	<return: #BlMeasurementSpec>

	^ BlMeasurementSpec exact: self size
]

{ #category : #printing }
BlLayoutExactResizer >> printOn: aStream [
	aStream
		nextPutAll: 'Exact ';
		nextPutAll: self size asString
]

{ #category : #accessing }
BlLayoutExactResizer >> requestedHeightIn: anElement [

	^ self size
]

{ #category : #accessing }
BlLayoutExactResizer >> requestedWidthIn: anElement [

	^ self size
]

{ #category : #accessing }
BlLayoutExactResizer >> size [
	^ size
]

{ #category : #accessing }
BlLayoutExactResizer >> size: aNumber [
	"aNumber should satisfy #isBlocFiniteFloat and #isBlocPositiveFloat"

	size := aNumber
]
