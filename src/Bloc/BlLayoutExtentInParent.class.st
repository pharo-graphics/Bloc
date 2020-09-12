Class {
	#name : #BlLayoutExtentInParent,
	#superclass : #BlLayoutExtent,
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #'api - converting' }
BlLayoutExtentInParent >> inLocal [
	<return: #BlLayoutExtentInLocal>
	| aLocalBounds |
	
	aLocalBounds := transformation
		ifNil: [ self ]
		ifNotNil: [ :aTransformation | aTransformation inverseTransformBounds: (BlBounds origin: 0@0 extent: self width @ self height) ].

	^ BlLayoutExtentInLocal new
		width: aLocalBounds width;
		height: aLocalBounds height;
		transformation: transformation
]

{ #category : #'api - converting' }
BlLayoutExtentInParent >> inParent [
	<return: #BlLayoutExtentInParent>

	^ self
]
