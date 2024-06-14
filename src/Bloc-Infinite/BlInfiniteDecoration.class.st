Class {
	#name : #BlInfiniteDecoration,
	#superclass : #Object,
	#instVars : [
		'computedBounds',
		'decorationInsets',
		'priority'
	],
	#category : #'Bloc-Infinite-Core'
}

{ #category : #geometry }
BlInfiniteDecoration >> computedBounds [ 
	^ computedBounds ifNil: [ Rectangle origin: 0 asPoint corner: 0 asPoint]
]

{ #category : #geometry }
BlInfiniteDecoration >> decorationInsets [
	"Return the insets (instance of BlInsets) for the given item element. 
	Be aware that only one side is used"

	
	^ decorationInsets 
]

{ #category : #geometry }
BlInfiniteDecoration >> getDecorationsInsetsOfChildElement: anElement [
	"get the insets for the given item element. Be aware that only one side is used"
	<return: #BlInsets>
	
	^ decorationInsets := self requiredInsetsOfChildElement: anElement
]

{ #category : #geometry }
BlInfiniteDecoration >> getDecorationsInsetsOfChildElement: anElement in: anInfiniteElement [
	"get the insets for the given item element. Be aware that only one side is used"
	<return: #BlInsets>
	
	^ decorationInsets := self requiredInsetsOfChildElement: anElement in: anInfiniteElement 
]

{ #category : #initialization }
BlInfiniteDecoration >> initialize [ 
	super initialize.
	decorationInsets := BlInsets empty
]

{ #category : #updating }
BlInfiniteDecoration >> onLayoutDoneIn: anInfiniteElement remaining: remainingRectangle [

	| insets rbnds |
	self flag:
		'To be completed/tested. this current implementation is known to work for the left side but what about the other sides ?'.

	insets := self decorationInsets.
	rbnds := remainingRectangle.
	insets left isZero ifFalse: [
		| insetsLeft |
		insetsLeft := insets left.
		self
			updateComputedBoundsIn: anInfiniteElement
			with: (rbnds origin corner: rbnds left + insetsLeft @ rbnds bottom).
		^ rbnds left + insetsLeft @ rbnds top extent: rbnds extent ].
	insets top isZero ifFalse: [
		^ rbnds left @ rbnds top + insets top corner: rbnds corner ].
	insets right isZero ifFalse: [
		| insetsRight |
		insetsRight := insets right + anInfiniteElement border width.
		self
			updateComputedBoundsIn: anInfiniteElement
			with: (rbnds right - insetsRight @ rbnds top corner: rbnds corner).
		^ rbnds origin corner: rbnds right - insetsRight @ rbnds bottom ].
	insets bottom isZero ifFalse: [
		^ rbnds origin corner:
			  rbnds corner right @ rbnds bottom - insets bottom ].
	^ remainingRectangle
]

{ #category : #accessing }
BlInfiniteDecoration >> priority [
	^ priority ifNil: [ priority := 0 ]
	
]

{ #category : #accessing }
BlInfiniteDecoration >> priority: anInteger [
	priority := anInteger
	
]

{ #category : #geometry }
BlInfiniteDecoration >> requiredInsetsOfChildElement: anElement [ 
	"get the insets for the given item element. Be aware that only one side is used"
	<return: #BlInsets>
	
	^ BlInsets empty
]

{ #category : #geometry }
BlInfiniteDecoration >> requiredInsetsOfChildElement: anElement in: anInfiniteElement [
	"get the insets for the given item element. Be aware that only one side is used"
	<return: #BlInsets>
	
	^ BlInsets empty
]

{ #category : #updating }
BlInfiniteDecoration >> updateComputedBoundsIn: anInfiniteElement with: aBounds [

	computedBounds = aBounds ifTrue: [ ^ self ].
	computedBounds := aBounds.
	anInfiniteElement dispatchEvent:
		(BlInfiniteDecorationBoundsChangedEvent new
			 decoration: self;
			 yourself)
]
