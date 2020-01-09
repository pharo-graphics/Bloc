Class {
	#name : #BlHostPosition,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'x',
		'y'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'instance creation' }
BlHostPosition class >> x: aX y: aY [
	^ self new initializeX: aX Y: aY
]

{ #category : #arithmetic }
BlHostPosition >> + aBlHostPosition [
	^ self class
		x: self x + aBlHostPosition x
		y: self y + aBlHostPosition y
]

{ #category : #arithmetic }
BlHostPosition >> - aBlHostPosition [
	^ self class
		x: self x - aBlHostPosition x
		y: self y - aBlHostPosition y
]

{ #category : #comparing }
BlHostPosition >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ x = anObject x and: [ y = anObject y ]
]

{ #category : #converting }
BlHostPosition >> asPoint [
	<return: #Point>

	^ self x @ self y
]

{ #category : #comparing }
BlHostPosition >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ y hash bitXor: x hash
]

{ #category : #initialization }
BlHostPosition >> initializeX: aX Y: aY [
	x := aX.
	y := aY
]

{ #category : #testing }
BlHostPosition >> isZero [
	<return: #Boolean>
	
	^ self x isZero or: [ self y isZero ]
]

{ #category : #accessing }
BlHostPosition >> x [
	<return: #Number>

	^ x
]

{ #category : #accessing }
BlHostPosition >> y [
	<return: #Number>

	^ y
]
