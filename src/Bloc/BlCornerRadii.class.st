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
BlCornerRadii >> asNonOverlappingCornerRadiiToFitWidth: aWidth height: aHeight [
	"Answer either self or an adapted copy of self where corner curves do not overlap for the specified extent.
	This follows the specification of 'Corner Overlap' subsection of 'CSS Backgrounds and Borders Module Level 3'.
	See: https://w3c.github.io/csswg-drafts/css-backgrounds-3/#corner-overlap"

	| aFactor |
	(aWidth isZero or: [ aHeight isZero ]) ifTrue: [ ^ self class empty ].

	aFactor := self maxOverlappingFactorForWidth: aWidth height: aHeight.

	^ aFactor > 1.0
		ifTrue: [ self dividedByScalar: aFactor ]
		ifFalse: [ self ]
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
BlCornerRadii >> bottomRadii [

	^ bottomLeft + bottomRight
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

{ #category : #converting }
BlCornerRadii >> copyExpandedBy: aNumber [ 
	"Answer a copy of myself with radii expanded by aNumber (or reduced, if negative).
	Do not touch the radius if it's zero."

	^ self species new
		topLeft: (self radius: topLeft expandedBy: aNumber);
		topRight: (self radius: topRight expandedBy: aNumber);
		bottomRight: (self radius: bottomRight expandedBy: aNumber);
		bottomLeft: (self radius: bottomLeft expandedBy: aNumber);
		yourself
]

{ #category : #converting }
BlCornerRadii >> dividedByScalar: aNumber [

	^ self species new
		topLeft: topLeft / aNumber;
		topRight: topRight / aNumber;
		bottomRight: bottomRight / aNumber;
		bottomLeft: bottomLeft / aNumber;
		yourself
]

{ #category : #comparing }
BlCornerRadii >> hash [

	^ bottomLeft hash bitXor:
		  (bottomRight hash bitXor: (topLeft hash bitXor: topLeft))
]

{ #category : #accessing }
BlCornerRadii >> leftRadii [

	^ topLeft + bottomLeft
]

{ #category : #arithmetic }
BlCornerRadii >> max [
	"Return the biggest corner radius among top left, top right, bottom left and bottom right"

	^ topLeft max: (topRight max: (bottomLeft max: bottomRight))
]

{ #category : #accessing }
BlCornerRadii >> maxOverlappingFactorForWidth: aWidth height: aHeight [
	"Answer the 1/f as defined in 'Corner Overlap' subsection of 'CSS Backgrounds and Borders Module Level 3'.
	See: https://w3c.github.io/csswg-drafts/css-backgrounds-3/#corner-overlap"

	^ (((self topRadii    / aWidth ) max:
		 (self rightRadii  / aHeight)) max: 
		 (self bottomRadii / aWidth )) max:
		 (self leftRadii   / aHeight)
]

{ #category : #arithmetic }
BlCornerRadii >> min [
	"Return the smallest corner radius among top left, top right, bottom left and bottom right"
	
	^ topLeft min: (topRight min: (bottomLeft min: bottomRight))
]

{ #category : #private }
BlCornerRadii >> radius: aNumber [
	topLeft := topRight := bottomLeft := bottomRight := aNumber
]

{ #category : #private }
BlCornerRadii >> radius: aRadius expandedBy: aNumber [ 
	"Answer aRadius expanded by aNumber (or reduced if negative). Do not touch if aRadius is zero."

	^ aRadius > 0.0
		ifFalse: [ 0.0 ]
		ifTrue: [ (aRadius + aNumber) max: 0.0 ]
]

{ #category : #accessing }
BlCornerRadii >> rightRadii [

	^ topRight + bottomRight
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
BlCornerRadii >> topRadii [

	^ topLeft + topRight
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
