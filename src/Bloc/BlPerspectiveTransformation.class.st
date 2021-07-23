Class {
	#name : 'BlPerspectiveTransformation',
	#superclass : 'BlAffineTransformation',
	#instVars : [
		'depth'
	],
	#category : 'Bloc-Basic-Transformations'
}

{ #category : 'instance creation' }
BlPerspectiveTransformation class >> depth: aNumber [
	<return: #BlPerspectiveTransformation>

	^ self new depth: aNumber
]

{ #category : 'accessing' }
BlPerspectiveTransformation >> depth [
	<return: #Number>

	^ depth
]

{ #category : 'accessing' }
BlPerspectiveTransformation >> depth: aNumber [
	self
		assert: [ aNumber > 0 ]
		description: [ 'Perspective must be positive' ].

	depth := aNumber
]

{ #category : 'testing' }
BlPerspectiveTransformation >> is2D [
	"Return true if transformation happens in x-y plane, hence 2D"
	<return: #Boolean>
	
	^ false
]

{ #category : 'mathematical functions' }
BlPerspectiveTransformation >> multiplyOn: aBlMatrix [
	aBlMatrix perspective: self depth
]
