Class {
	#name : #BlLayoutBoundsInLocal,
	#superclass : #BlLayoutBounds,
	#category : #'Bloc-Layouts-Model'
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
		position: aParentBounds position
			extent: aParentBounds extent;
		transformation: transformation
]
