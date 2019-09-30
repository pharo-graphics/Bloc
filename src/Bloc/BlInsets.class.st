"
I am an immutable version of Margin.

I represent a margin (for now of rectangle-based operations). From that perspective I represent a surface. This means that my width and height are the sum of the right and left distances and bottom top distances.

I provide several creation methods but usually four points are necessary to fully specify my instances. 
"
Class {
	#name : #BlInsets,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'top',
		'left',
		'bottom',
		'right'
	],
	#classVars : [
		'Empty'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #'instance creation' }
BlInsets class >> all: aNumber [
	^ self
		top: aNumber
		right: aNumber
		bottom: aNumber
		left: aNumber
]

{ #category : #'instance creation' }
BlInsets class >> bottom: b [ 
	^ self 
		top: 0
		right: 0
		bottom: b
		left: 0
]

{ #category : #'instance creation' }
BlInsets class >> empty [
	^ Empty ifNil: [ Empty := self
		top: 0
		right: 0
		bottom: 0
		left: 0 ]
]

{ #category : #'instance creation' }
BlInsets class >> left: l [
	^ self 
		top: 0
		right: 0
		bottom: 0
		left: l
]

{ #category : #'instance creation' }
BlInsets class >> left: l right:r [
	^ self 
		top: 0
		right: r
		bottom: 0
		left: l
]

{ #category : #'instance creation' }
BlInsets class >> right: r [
	^ self 
		top: 0
		right: r
		bottom: 0
		left: 0
]

{ #category : #'instance creation' }
BlInsets class >> top: t [ 
	^ self 
		top: t
		right: 0
		bottom: 0
		left: 0
]

{ #category : #'instance creation' }
BlInsets class >> top: t bottom: b [
	^ self 
		top: t
		right: 0
		bottom: b
		left: 0
]

{ #category : #'instance creation' }
BlInsets class >> top: t left: l bottom: b right: r [ 
	^ self new
		top: t
		right: r
		bottom: b
		left: l
]

{ #category : #'instance creation' }
BlInsets class >> top: t right: r [
	^ self 
		top: t
		right: r
		bottom: 0
		left: 0
]

{ #category : #'instance creation' }
BlInsets class >> top: t right: r bottom: b left: l [
	^ self new
		top: t
		right: r
		bottom: b
		left: l
]

{ #category : #converting }
BlInsets >> + anInsets [
	^ BlInsets
		top: top + anInsets top
		right: right + anInsets right
		bottom: bottom + anInsets bottom
		left: left + anInsets left
]

{ #category : #converting }
BlInsets >> - anInsets [
	^ BlInsets
		top: (top - anInsets top max: 0)
		right: (right - anInsets right max: 0)
		bottom: (bottom - anInsets bottom max: 0)
		left: (left - anInsets left max: 0)
]

{ #category : #testing }
BlInsets >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	
	^ left = anObject left
		and: [ right = anObject right
			and: [ top = anObject top
				and: [ bottom = anObject bottom ] ] ]
]

{ #category : #converting }
BlInsets >> asMargin [
	<return: #Margin>

	^ Margin top: top left: left bottom: bottom right: right
]

{ #category : #accessing }
BlInsets >> bottom [
	<return: #Number>

	^ bottom
]

{ #category : #accessing }
BlInsets >> bottomLeft [
	<return: #Point>

	^ left @ bottom
]

{ #category : #accessing }
BlInsets >> bottomRight [
	<return: #Point>

	^ right @ bottom
]

{ #category : #converting }
BlInsets >> expand: aRectangle [
	"Answer a rectangle whose size has been expanded by the receiver which represents each rectangle corner."
	"Optimisation: fast return if I don't modify bounds. gives 10x speed boost"
	<return: #Rectangle>

	self isEmpty
		ifTrue: [ ^ aRectangle ].
	^ (aRectangle left - self left) @ (aRectangle top - self top)
		corner: (aRectangle right + self right) @ (aRectangle bottom + self bottom)
]

{ #category : #accessing }
BlInsets >> extent [
	^ self width @ self height
]

{ #category : #accessing }
BlInsets >> height [
	<return: #Number>

	^ top + bottom
]

{ #category : #converting }
BlInsets >> inset: aRectangle [
	"Answer a rectangle whose size has been reduced by the receiver."
	"Optimisation: fast return if I don't modify bounds. gives 10x speed boost"
	<return: #Rectangle>

	self isEmpty
		ifTrue: [ ^ aRectangle ].
	^ (aRectangle left + self left) @ (aRectangle top + self top)
		corner: (aRectangle right - self right) @ (aRectangle bottom - self bottom)
]

{ #category : #testing }
BlInsets >> isEmpty [
	"Return true if insets is empty and does not influence bounds, false otherwise.
	Note: comparing the sum of width and height may lead to unexpected results when insets are negative"
	<return: #Boolean>

	^ self top isZero
		and: [ self right isZero
			and: [ self bottom isZero
				and: [ self left isZero ] ] ]
]

{ #category : #accessing }
BlInsets >> left [
	<return: #Number>

	^ left
]

{ #category : #accessing }
BlInsets >> max [
	^ self top max: (self right max: (self bottom max: self left))
]

{ #category : #converting }
BlInsets >> negated [
	^ self class
		top: self top negated
		right: self right negated
		bottom: self bottom negated
		left: self left negated
]

{ #category : #printing }
BlInsets >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' top: ';
		print: top;
		nextPutAll: ' right: ';
		print: right;
		nextPutAll: ' bottom: ';
		print: bottom;
		nextPutAll: ' left: ';
		print: left
]

{ #category : #accessing }
BlInsets >> right [
	<return: #Number>

	^ right
]

{ #category : #accessing }
BlInsets >> top [
	<return: #Number>

	^ top
]

{ #category : #initialization }
BlInsets >> top: aTop right: aRight bottom: aBottom left: aLeft [
	self
		assert: [ top isNil ]
		description: [ 'Insets is immutable and can not be changed' ].
	self
		assert: [ right isNil ]
		description: [ 'Insets is immutable and can not be changed' ].
	self
		assert: [ bottom isNil ]
		description: [ 'Insets is immutable and can not be changed' ].
	self
		assert: [ left isNil ]
		description: [ 'Insets is immutable and can not be changed' ].

	top := aTop.
	right := aRight.
	bottom := aBottom.
	left := aLeft
]

{ #category : #accessing }
BlInsets >> topLeft [
	<return: #Point>

	^ left @ top
]

{ #category : #accessing }
BlInsets >> topRight [
	<return: #Point>

	^ right @ top
]

{ #category : #accessing }
BlInsets >> width [
	<return: #Number>

	^ left + right
]
