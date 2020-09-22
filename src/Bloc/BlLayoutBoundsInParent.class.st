Class {
	#name : #BlLayoutBoundsInParent,
	#superclass : #BlLayoutBounds,
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'api - converting' }
BlLayoutBoundsInParent >> inLocal [
	<return: #BlLayoutBoundsInLocal>
	| aParentBounds |
	
	aParentBounds := transformation
		ifNil: [ self ]
		ifNotNil: [ :aTransformation | aTransformation inverseTransformBounds: self asBounds ].

	^ BlLayoutBoundsInLocal new
		position: aParentBounds position
			extent: aParentBounds extent;
		transformation: transformation
]

{ #category : #'api - converting' }
BlLayoutBoundsInParent >> inParent [
	<return: #BlLayoutBoundsInParent>

	^ self
]
