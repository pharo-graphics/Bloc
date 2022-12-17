"
I represent bounds in space

"
Class {
	#name : #BlElementBoundsInSpace,
	#superclass : #BlElementComputedBounds,
	#category : #'Bloc-Basic-Bounds'
}

{ #category : #'geometry bounds' }
BlElementBoundsInSpace >> inChild: anElement [
	<return: #BlElementBounds>

	^ BlElementBoundsInChild new
		originalElement: self referenceElement topMostParent;
		referenceElement: anElement;
		bounds: (anElement globalBoundsToMine: self bounds copy fromParent: self referenceElement topMostParent);
		yourself
]

{ #category : #'geometry bounds' }
BlElementBoundsInSpace >> inParent [
	^ self
]

{ #category : #'geometry bounds' }
BlElementBoundsInSpace >> inSpace [
	^ self
]
