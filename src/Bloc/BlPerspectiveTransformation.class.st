Class {
	#name : #BlPerspectiveTransformation,
	#superclass : #BlAffineTransformation,
	#instVars : [
		'depth'
	],
	#category : #'Bloc-Basic-Transformations'
}

{ #category : #'instance creation' }
BlPerspectiveTransformation class >> depth: aNumber [

	^ self new
		  depth: aNumber;
		  yourself
]

{ #category : #examples }
BlPerspectiveTransformation class >> exampleTransformation [
	"A perspective alone has no visible effect on a flat element: it only changes how depth is projected, so it shows once combined with a 3D transformation."

	<sampleInstance>
	^ self depth: 300
]

{ #category : #comparing }
BlPerspectiveTransformation >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self depth = anObject depth
]

{ #category : #accessing }
BlPerspectiveTransformation >> depth [

	^ depth
]

{ #category : #accessing }
BlPerspectiveTransformation >> depth: aPositiveNumber [

	depth := aPositiveNumber
]

{ #category : #testing }
BlPerspectiveTransformation >> is2D [
	
	^ false
]

{ #category : #'mathematical functions' }
BlPerspectiveTransformation >> multiplyOn: aBlMatrix [

	aBlMatrix perspective: depth
]
