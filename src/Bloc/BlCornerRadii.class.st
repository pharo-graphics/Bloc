"
I define the shape of the corner of a rectangle geometry (BlRectangle).
If corner radius is zero, the corner is square, not rounded. The radius also causes the element's background to be rounded .

Negative values are not allowed.


"
Class {
	#name : #BlCornerRadii,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'topLeft',
		'topRight',
		'bottomLeft',
		'bottomRight'
	],
	#classInstVars : [
		'empty'
	],
	#category : #'Bloc-Basic-Support'
}

{ #category : #cleanup }
BlCornerRadii class >> cleanUp [
	<script: 'self cleanUp'>
	super cleanUp.
	
	empty := nil
]

{ #category : #'predefined instances' }
BlCornerRadii class >> empty [
	^ empty ifNil: [ empty := self radius: 0 ]
]

{ #category : #'instance creation' }
BlCornerRadii class >> radius: aNumber [
	^ self new
		radius: aNumber;
		yourself
]

{ #category : #comparing }
BlCornerRadii >> = aBlCornerRadii [
	self species == aBlCornerRadii species
		ifFalse: [ ^ false ].

	^ self bottomLeft = aBlCornerRadii bottomLeft
		and: [ self bottomRight = aBlCornerRadii bottomRight
			and: [ self topLeft = aBlCornerRadii topLeft
				and: [ self topRight = aBlCornerRadii topRight ] ] ]
]

{ #category : #converting }
BlCornerRadii >> asArray [

	^ { 
		topLeft.
		topRight.
		bottomRight.
		bottomLeft
	}
]

{ #category : #converting }
BlCornerRadii >> asArrayExpandedBy: aNumber [ 
	"Answer myself converted to Array, expand by aNumber (or reduced if negative)."

	^ self asArray collect: [ :each | 
		each > 0.0
			ifFalse: [ 0.0 ]
			ifTrue: [ (each + aNumber) max: 0.0 ] ]

]

{ #category : #accessing }
BlCornerRadii >> bottomLeft [
	^ bottomLeft
]

{ #category : #accessing }
BlCornerRadii >> bottomLeft: aNumber [
	"Initialize bottom left corner radius with a given number.
	It can be done only once"
	
	self
		assert: [ bottomLeft isNil ]
		description: [ 'Can not change bottom left radius, I am immutable!' ].

	bottomLeft := aNumber
]

{ #category : #accessing }
BlCornerRadii >> bottomRight [
	^ bottomRight
]

{ #category : #accessing }
BlCornerRadii >> bottomRight: aNumber [
	"Initialize bottom right corner radius with a given number.
	It can be done only once"

	self
		assert: [ bottomRight isNil ]
		description: [ 'Can not change bottom right radius, I am immutable!' ].

	bottomRight := aNumber
]

{ #category : #comparing }
BlCornerRadii >> hash [
	^ bottomLeft hash bitXor: (bottomRight hash bitXor: (topLeft hash bitXor: topLeft))
]

{ #category : #arithmetic }
BlCornerRadii >> max [
	"Return the biggest corner radius among top left, top right, bottom left and bottom right"
	<return: #Number>

	^ topLeft max: (topRight max: (bottomLeft max: bottomRight))
]

{ #category : #arithmetic }
BlCornerRadii >> min [
	"Return the smallest corner radius among top left, top right, bottom left and bottom right"
	<return: #Number>
	
	^ topLeft min: (topRight min: (bottomLeft min: bottomRight))
]

{ #category : #private }
BlCornerRadii >> radius: aNumber [
	topLeft := topRight := bottomLeft := bottomRight := aNumber
]

{ #category : #accessing }
BlCornerRadii >> topLeft [
	^ topLeft
]

{ #category : #accessing }
BlCornerRadii >> topLeft: aNumber [
	"Initialize top left corner radius with a given number.
	It can be done only once"

	self
		assert: [ topLeft isNil ]
		description: [ 'Can not change top left radius, I am immutable!' ].

	topLeft := aNumber
]

{ #category : #accessing }
BlCornerRadii >> topRight [
	^ topRight
]

{ #category : #accessing }
BlCornerRadii >> topRight: aNumber [
	"Initialize top right corner radius with a given number.
	It can be done only once"

	self
		assert: [ topRight isNil ]
		description: [ 'Can not change top right radius, I am immutable!' ].

	topRight := aNumber
]
