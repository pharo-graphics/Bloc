Class {
	#name : #BlElementBoundsInParent,
	#superclass : #BlElementComputedBounds,
	#instVars : [
		'originalElement'
	],
	#category : 'Bloc-Basic-Bounds'
}

{ #category : 'geometry bounds' }
BlElementBoundsInParent >> inChild: anElement [
	<return: #BlElementBounds>
	| aParentElement |
	
	aParentElement := self referenceElement hasParent
		ifTrue: [ self referenceElement parent ]
		ifFalse: [ self referenceElement ].

	^ BlElementBoundsInChild new
		originalElement: self originalElement;
		referenceElement: anElement;
		bounds: (anElement globalBoundsToMine: self bounds copy fromParent: aParentElement);
		yourself
]

{ #category : 'geometry bounds' }
BlElementBoundsInParent >> inParent [
	<return: #BlElementBoundsInParent>

	self referenceElement hasParent
		ifFalse: [ ^ self ].

	^ BlElementBoundsInParent new
		originalElement: self originalElement;
		referenceElement: self referenceElement parent;
		bounds: (self referenceElement parent localBoundsToParent: self bounds copy);
		yourself
]

{ #category : 'accessing' }
BlElementBoundsInParent >> originalElement [
	<return: #BlElement>

	^ originalElement
]

{ #category : 'accessing' }
BlElementBoundsInParent >> originalElement: anElement [
	originalElement := anElement
]
