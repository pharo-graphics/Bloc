"
I am an immutable version of Margin.

I represent a margin (for now of rectangle-based operations). From that perspective I represent a surface. This means that my width and height are the sum of the right and left distances and bottom top distances.

I provide several creation methods but usually four points are necessary to fully specify my instances. 

"
Class {
	#name : #BlInsets,
	#superclass : #Object,
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

	^ Empty ifNil: [
		Empty := self
			top: 0
			right: 0
			bottom: 0
			left: 0 ]
]

{ #category : #'instance creation' }
BlInsets class >> horizontal: aNumber [

	^ self left: aNumber right: aNumber
]

{ #category : #'instance creation' }
BlInsets class >> horizontal: aNumberForH vertical: aNumberForV [

	^ self top: aNumberForV left: aNumberForH bottom: aNumberForV right: aNumberForH
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
BlInsets class >> left: l right: r [

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
BlInsets class >> top: t left: l [

	^ self 
		top: t
		right: 0
		bottom: 0
		left: l
]

{ #category : #'instance creation' }
BlInsets class >> top: t left: l bottom: b right: r [

	^ self basicNew
		initializeTop: t
			right: r
			bottom: b
			left: l;
		yourself
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

	^ self basicNew
		  initializeTop: t
		  right: r
		  bottom: b
		  left: l;
		  yourself
]

{ #category : #'instance creation' }
BlInsets class >> vertical: aNumber [

	^ self top: aNumber bottom: aNumber
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

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	
	^ left = anObject left
		and: [ right = anObject right
			and: [ top = anObject top
				and: [ bottom = anObject bottom ] ] ]
]

{ #category : #converting }
BlInsets >> asMargin [

	^ Margin top: top left: left bottom: bottom right: right
]

{ #category : #accessing }
BlInsets >> bottom [

	^ bottom
]

{ #category : #accessing }
BlInsets >> bottomLeft [

	^ left @ bottom
]

{ #category : #accessing }
BlInsets >> bottomRight [

	^ right @ bottom
]

{ #category : #converting }
BlInsets >> expand: aRectangle [
	"Answer a rectangle whose extent has been expanded by the receiver which represents each rectangle corner."
	"Optimisation: fast return if I don't modify bounds. gives 10x speed boost"

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

	^ top + bottom
]

{ #category : #initialization }
BlInsets >> initializeTop: aTop right: aRight bottom: aBottom left: aLeft [
	"Initialize all values. None of the values should be changed afterwards."

	self initialize.
	top := aTop asFloat.
	right := aRight asFloat.
	bottom := aBottom asFloat.
	left := aLeft asFloat
]

{ #category : #converting }
BlInsets >> inset: aRectangle [
	"Answer a rectangle whose size has been reduced by the receiver."
	"Optimisation: fast return if I don't modify bounds. gives 10x speed boost"

	self isEmpty
		ifTrue: [ ^ aRectangle ].

	^ (aRectangle left + self left) @ (aRectangle top + self top)
		corner: (aRectangle right - self right) @ (aRectangle bottom - self bottom)
]

{ #category : #testing }
BlInsets >> isEmpty [
	"Return true if insets is empty and does not influence bounds, false otherwise.
	Note: comparing the sum of width and height may lead to unexpected results when insets are negative"

	^ self top isZero
		and: [ self right isZero
			and: [ self bottom isZero
				and: [ self left isZero ] ] ]
]

{ #category : #testing }
BlInsets >> isUniform [
	"Return true if all insets (right, left, top, bottom) are same"

	^ (self top closeTo: self right)
		and: [ (self right closeTo: self bottom)
			and: [ (self bottom closeTo: self left)
				and: [ self left closeTo: self top ] ] ]
]

{ #category : #accessing }
BlInsets >> left [

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

	aStream
		nextPutAll: self class name;
		space.
	
	self isEmpty
		ifTrue: [
			aStream nextPutAll: 'empty'.
			^ self ].
		
	self isUniform
		ifTrue: [
			aStream nextPutAll: 'all: '.
			aStream print: self top.
			^ self ].

	aStream
		nextPutAll: 'top: ';
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

	^ right
]

{ #category : #accessing }
BlInsets >> top [

	^ top
]

{ #category : #accessing }
BlInsets >> topLeft [

	^ left @ top
]

{ #category : #accessing }
BlInsets >> topRight [

	^ right @ top
]

{ #category : #accessing }
BlInsets >> width [

	^ left + right
]

{ #category : #accessing }
BlInsets >> withBottom: aBottom [

	^ self class
		top: self top
		right: self right
		bottom: aBottom
		left: self left
]

{ #category : #accessing }
BlInsets >> withExtraBottom: aBottom [

	^ self class
		top: self top
		right: self right
		bottom: self bottom + aBottom
		left: self left
]

{ #category : #accessing }
BlInsets >> withLeft: aLeft [

	^ self class
		top: self top
		right: self right
		bottom: self bottom
		left: aLeft
]

{ #category : #accessing }
BlInsets >> withRight: aRight [

	^ self class
		top: self top
		right: aRight
		bottom: self bottom
		left: self left
]

{ #category : #accessing }
BlInsets >> withTop: aTop [

	^ self class
		top: aTop
		right: self right
		bottom: self bottom
		left: self left
]
