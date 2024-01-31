"
I represent a measurement specification of element's width and height.

I am used by Layouts

"
Class {
	#name : 'BlExtentMeasurementSpec',
	#superclass : 'Object',
	#instVars : [
		'widthSpec',
		'heightSpec'
	],
	#category : 'Bloc-Layouts-Support',
	#package : 'Bloc',
	#tag : 'Layouts-Support'
}

{ #category : 'instance creation' }
BlExtentMeasurementSpec class >> atMost: anExtent [
	^ self new
		widthSpec: (BlMeasurementSpec atMost: anExtent x asFloat);
		heightSpec: (BlMeasurementSpec atMost: anExtent y asFloat)
]

{ #category : 'instance creation' }
BlExtentMeasurementSpec class >> exact: anExtent [
	^ self new
		widthSpec: (BlMeasurementSpec exact: anExtent x asFloat);
		heightSpec: (BlMeasurementSpec exact: anExtent y asFloat)
]

{ #category : 'instance creation' }
BlExtentMeasurementSpec class >> unspecified [
	^ self new
		widthSpec: BlMeasurementSpec unspecified;
		heightSpec: BlMeasurementSpec unspecified
]

{ #category : 'comparing' }
BlExtentMeasurementSpec >> = anotherObject [
	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject class = self class)
		ifFalse: [ ^ false ].
	
	^ anotherObject widthSpec = widthSpec
		and: [ anotherObject heightSpec = heightSpec ]
]

{ #category : 'comparing' }
BlExtentMeasurementSpec >> hash [
	^ heightSpec hash bitXor: widthSpec hash
]

{ #category : 'accessing' }
BlExtentMeasurementSpec >> heightSpec [
	^ heightSpec
]

{ #category : 'accessing' }
BlExtentMeasurementSpec >> heightSpec: anObject [
	heightSpec := anObject
]

{ #category : 'testing' }
BlExtentMeasurementSpec >> isExact [
	^ self widthSpec isExact and: [ self heightSpec isExact ]
]

{ #category : 'geometry' }
BlExtentMeasurementSpec >> min: aMinSize max: aMaxSize [
	^ (self widthSpec min: aMinSize x max: aMaxSize x) @ (self heightSpec min: aMinSize y max: aMaxSize y)
]

{ #category : 'printing' }
BlExtentMeasurementSpec >> printOn: aStream [
	aStream nextPutAll: 'width: ('.
	aStream nextPutAll: (self widthSpec asString).
	aStream nextPutAll: ') height: ('.
	aStream nextPutAll: (self heightSpec asString).
	aStream nextPutAll: ')'.
]

{ #category : 'geometry' }
BlExtentMeasurementSpec >> sizeFor: anExtent [
	| width height |
	width := self widthSpec sizeFor: anExtent x.
	height := self heightSpec sizeFor: anExtent y.
	^ width @ height
]

{ #category : 'accessing' }
BlExtentMeasurementSpec >> widthSpec [
	<return: #BlMeasurementSpec>
	^ widthSpec
]

{ #category : 'accessing' }
BlExtentMeasurementSpec >> widthSpec: anObject [
	widthSpec := anObject
]
