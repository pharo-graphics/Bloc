Class {
	#name : #BlElementBoundsInChild,
	#superclass : #BlElementComputedBounds,
	#instVars : [
		'originalElement'
	],
	#category : 'Bloc-Basic-Bounds'
}

{ #category : 'geometry bounds' }
BlElementBoundsInChild >> inParent [
	<return: #BlElementBoundsInParent>

	self referenceElement hasParent
		ifFalse: [ ^ self ].

	^ BlElementBoundsInParent new
		originalElement: self originalElement;
		referenceElement: self referenceElement;
		bounds: (self referenceElement localBoundsToParent: self bounds copy);
		yourself
]

{ #category : 'geometry bounds' }
BlElementBoundsInChild >> inSpace [
	<return: #BlElementBounds>

	^ BlElementBoundsInSpace new
		referenceElement: self referenceElement;
		bounds: (self localBoundsToSpace: self bounds copy);
		yourself
]

{ #category : 'accessing' }
BlElementBoundsInChild >> originalElement [
	<return: #BlElement>

	^ originalElement
]

{ #category : 'accessing' }
BlElementBoundsInChild >> originalElement: anElement [
	originalElement := anElement
]
