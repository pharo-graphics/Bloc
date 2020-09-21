Class {
	#name : #BlLayoutExtentInParentWithTransformation,
	#superclass : #BlLayoutExtentInParent,
	#instVars : [
		'transformation'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'api - converting' }
BlLayoutExtentInParentWithTransformation >> inLocal [
	<return: #BlLayoutExtentInLocal>
	| aLocalBounds |
	
	aLocalBounds := transformation inverseTransformBounds: (BlBounds origin: 0@0 extent: self width @ self height).

	^ BlLayoutExtentInLocalWithTransformation new
		width: aLocalBounds width;
		height: aLocalBounds height;
		transformation: transformation
]

{ #category : #accessing }
BlLayoutExtentInParentWithTransformation >> transformation [
	<return: #BlElementCachedTransformation>

	^ transformation
]

{ #category : #accessing }
BlLayoutExtentInParentWithTransformation >> transformation: aBlElementCachedTransformation [
	self
		assert: [ aBlElementCachedTransformation notNil ]
		description: [ 'Transformation must not be nil' ].

	transformation := aBlElementCachedTransformation
]
