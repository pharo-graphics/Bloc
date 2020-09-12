Class {
	#name : #BlLayoutBoundsInParent,
	#superclass : #BlLayoutBounds,
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #'api - converting' }
BlLayoutBoundsInParent >> inLocal [
	<return: #BlLayoutBoundsInLocal>
	| aParentBounds |
	
	aParentBounds := transformation
		ifNil: [ self ]
		ifNotNil: [ :aTransformation | aTransformation inverseTransformBounds: self asBounds ].

	^ BlLayoutBoundsInLocal new
		left: aParentBounds left;
		top: aParentBounds top;
		width: aParentBounds width;
		height: aParentBounds height;
		transformation: transformation
]

{ #category : #'api - converting' }
BlLayoutBoundsInParent >> inParent [
	<return: #BlLayoutBoundsInParent>

	^ self
]
