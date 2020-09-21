Class {
	#name : #BlLayoutExtentInLocalWithTransformation,
	#superclass : #BlLayoutExtentInLocal,
	#instVars : [
		'transformation'
	],
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'api - converting' }
BlLayoutExtentInLocalWithTransformation >> inParent [
	<return: #BlLayoutExtentInParent>
	| aParentBounds |
	
	aParentBounds := transformation transformBounds: (BlBounds origin: 0@0 extent: self width @ self height).

	^ BlLayoutExtentInParentWithTransformation new
		width: aParentBounds width;
		height: aParentBounds height;
		transformation: transformation
]

{ #category : #accessing }
BlLayoutExtentInLocalWithTransformation >> transformation [
	<return: #BlElementCachedTransformation>

	^ transformation
]

{ #category : #accessing }
BlLayoutExtentInLocalWithTransformation >> transformation: aBlElementCachedTransformation [
	self
		assert: [ aBlElementCachedTransformation notNil ]
		description: [ 'Transformation must not be nil' ].

	transformation := aBlElementCachedTransformation
]
