"
I represent a measurement specification of element's width and height.

I am used by Layouts

"
Class {
	#name : #BlExtentMeasurementSpec,
	#superclass : #Object,
	#instVars : [
		'widthSpec',
		'heightSpec'
	],
	#category : #'Bloc-Layouts-Support'
}

{ #category : #'instance creation' }
BlExtentMeasurementSpec class >> atMost: anExtent [

	^ self
		  widthSpec: (BlMeasurementSpec atMost: anExtent x asFloat)
		  heightSpec: (BlMeasurementSpec atMost: anExtent y asFloat)
]

{ #category : #'instance creation' }
BlExtentMeasurementSpec class >> exact: anExtent [

	^ self
		  widthSpec: (BlMeasurementSpec exact: anExtent x asFloat)
		  heightSpec: (BlMeasurementSpec exact: anExtent y asFloat)
]

{ #category : #'instance creation' }
BlExtentMeasurementSpec class >> unspecified [

	^ self
		  widthSpec: BlMeasurementSpec unspecified
		  heightSpec: BlMeasurementSpec unspecified
]

{ #category : #'instance creation' }
BlExtentMeasurementSpec class >> widthSpec: horizontalMeasurementSpec heightSpec: verticalMeasurementSpec [

	^ self new
		  widthSpec: horizontalMeasurementSpec;
		  heightSpec: verticalMeasurementSpec;
		  yourself
]

{ #category : #comparing }
BlExtentMeasurementSpec >> = anotherObject [

	self == anotherObject ifTrue: [ ^ true ].
	anotherObject class = self class ifFalse: [ ^ false ].

	^ anotherObject widthSpec = widthSpec and: [
		  anotherObject heightSpec = heightSpec ]
]

{ #category : #geometry }
BlExtentMeasurementSpec >> extentFor: anExtent [

	^ self extentForWidth: anExtent x height: anExtent y
]

{ #category : #geometry }
BlExtentMeasurementSpec >> extentForWidth: aWidth height: aHeight [

	| width height |
	width := widthSpec sizeFor: aWidth.
	height := heightSpec sizeFor: aHeight.

	^ width @ height
]

{ #category : #comparing }
BlExtentMeasurementSpec >> hash [

	^ heightSpec hash bitXor: widthSpec hash
]

{ #category : #accessing }
BlExtentMeasurementSpec >> heightSpec [

	^ heightSpec
]

{ #category : #accessing }
BlExtentMeasurementSpec >> heightSpec: aBlMeasurementSpec [

	heightSpec := aBlMeasurementSpec
]

{ #category : #testing }
BlExtentMeasurementSpec >> isExact [

	^ widthSpec isExact and: [ heightSpec isExact ]
]

{ #category : #geometry }
BlExtentMeasurementSpec >> min: aMinSize max: aMaxSize [

	^ (widthSpec min: aMinSize x max: aMaxSize x)
	  @ (heightSpec min: aMinSize y max: aMaxSize y)
]

{ #category : #printing }
BlExtentMeasurementSpec >> printOn: aStream [

	aStream nextPutAll: 'width: ('.
	aStream nextPutAll: widthSpec asString.
	aStream nextPutAll: ') height: ('.
	aStream nextPutAll: heightSpec asString.
	aStream nextPutAll: ')'
]

{ #category : #geometry }
BlExtentMeasurementSpec >> sizeFor: anExtent [

	self
		deprecated: 'Use #extentFor: instead. See: https://github.com/pharo-graphics/Bloc/issues/802'
		transformWith:
			'`@receiver sizeFor: `@arg' ->
			'`@receiver extentFor: `@arg'.

	^ self extentFor: anExtent
]

{ #category : #accessing }
BlExtentMeasurementSpec >> widthSpec [

	^ widthSpec
]

{ #category : #accessing }
BlExtentMeasurementSpec >> widthSpec: aBlMeasurementSpec [

	widthSpec := aBlMeasurementSpec
]
