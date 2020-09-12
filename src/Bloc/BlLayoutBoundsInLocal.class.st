Class {
	#name : #BlLayoutBoundsInLocal,
	#superclass : #BlLayoutBounds,
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #'api - converting' }
BlLayoutBoundsInLocal >> inLocal [
	<return: #BlLayoutBoundsInLocal>

	^ self
]

{ #category : #'api - converting' }
BlLayoutBoundsInLocal >> inParent [
	<return: #BlLayoutBoundsInParent>
	| aParentBounds |
	
	aParentBounds := transformation
		ifNil: [ self ]
		ifNotNil: [ :aTransformation | aTransformation transformBounds: self asBounds ].

	^ BlLayoutBoundsInParent new
		left: aParentBounds left;
		top: aParentBounds top;
		width: aParentBounds width;
		height: aParentBounds height;
		transformation: transformation
]
