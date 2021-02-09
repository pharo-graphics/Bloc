"
! Bounds matcher

I allow users to quickly check if child bounds given by ==childStart== and ==childEnd== match parent bounds given by ==parentStart== and ==parentEnd== according to configured constraints.
"
Class {
	#name : #BlBoundsMatcher,
	#superclass : #Object,
	#instVars : [
		'constraints',
		'parentStart',
		'parentEnd',
		'childStart',
		'childEnd'
	],
	#category : #'Bloc-Basic-Bounds'
}

{ #category : #accessing }
BlBoundsMatcher >> childEnd [
	^ childEnd
]

{ #category : #accessing }
BlBoundsMatcher >> childEnd: anObject [
	childEnd := anObject
]

{ #category : #accessing }
BlBoundsMatcher >> childStart [
	^ childStart
]

{ #category : #accessing }
BlBoundsMatcher >> childStart: anObject [
	childStart := anObject
]

{ #category : #private }
BlBoundsMatcher >> compare: aNumber and: anotherNumber [
	<return: #Number>
	aNumber > anotherNumber
		ifTrue: [ ^ BlBoundsMatcherConstraints GreaterThan ].
		
	aNumber < anotherNumber
		ifTrue: [ ^ BlBoundsMatcherConstraints LessThan ].
		
	^ BlBoundsMatcherConstraints Equal
]

{ #category : #accessing }
BlBoundsMatcher >> constraints [
	<return: #BlBoundsMatcherConstraints>

	^ constraints
]

{ #category : #accessing }
BlBoundsMatcher >> constraints: anObject [
	constraints := anObject
]

{ #category : #initialization }
BlBoundsMatcher >> initialize [
	super initialize.
	
	constraints := BlBoundsMatcherConstraints new.
	childStart := 0.
	childEnd := 0.
	parentStart := 0.
	parentEnd := 0
]

{ #category : #'api - matcher' }
BlBoundsMatcher >> matches [
	"Returns whether the contraints of the matcher are correct"
	<return: #Boolean>
	
	(constraints has: (BlBoundsMatcherConstraints Mask << BlBoundsMatcherConstraints ChildStartAndParentStart))
		ifTrue: [
			(constraints has: ((self compare: childStart and: parentStart) <<	BlBoundsMatcherConstraints ChildStartAndParentStart))
				ifFalse: [ ^ false ] ].

	(constraints has: (BlBoundsMatcherConstraints Mask << BlBoundsMatcherConstraints ChildStartAndParentEnd))
		ifTrue: [
			(constraints has: ((self compare: childStart and: parentEnd) <<	BlBoundsMatcherConstraints ChildStartAndParentEnd))
				ifFalse: [ ^ false ] ].

	(constraints has: (BlBoundsMatcherConstraints Mask << BlBoundsMatcherConstraints ChildEndAndParentStart))
		ifTrue: [
			(constraints has: ((self compare: childEnd and: parentStart) <<	BlBoundsMatcherConstraints ChildEndAndParentStart))
				ifFalse: [ ^ false ] ].

	(constraints has: (BlBoundsMatcherConstraints Mask << BlBoundsMatcherConstraints ChildEndAndParentEnd))
		ifTrue: [
			(constraints has: ((self compare: childEnd and: parentEnd) <<	BlBoundsMatcherConstraints ChildEndAndParentEnd))
				ifFalse: [ ^ false ] ].

	^ true
]

{ #category : #accessing }
BlBoundsMatcher >> parentEnd [
	^ parentEnd
]

{ #category : #accessing }
BlBoundsMatcher >> parentEnd: anObject [
	parentEnd := anObject
]

{ #category : #accessing }
BlBoundsMatcher >> parentStart [
	^ parentStart
]

{ #category : #accessing }
BlBoundsMatcher >> parentStart: anObject [
	parentStart := anObject
]
