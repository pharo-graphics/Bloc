Class {
	#name : #BlHostSize,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'width',
		'height'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'instance creation' }
BlHostSize class >> width: aWidth height: aHeight [
	^ self new initializeWidth: aWidth height: aHeight
]

{ #category : #comparing }
BlHostSize >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ height = anObject height and: [ width = anObject width ]
]

{ #category : #converting }
BlHostSize >> asPoint [
	<return: #Point>

	^ self width @ self height
]

{ #category : #comparing }
BlHostSize >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ height hash bitXor: width hash
]

{ #category : #accessing }
BlHostSize >> height [
	<return: #Number>

	^ height
]

{ #category : #initialization }
BlHostSize >> initializeWidth: aWidth height: aHeight [
	width := aWidth.
	height := aHeight
]

{ #category : #testing }
BlHostSize >> isZero [
	<return: #Boolean>
	
	^ self width isZero or: [ self height isZero ]
]

{ #category : #accessing }
BlHostSize >> width [
	<return: #Number>

	^ width
]
