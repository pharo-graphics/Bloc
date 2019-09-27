"
I represent a 2D Euclidean vector

https://en.wikipedia.org/wiki/Euclidean_vector

Instance creation:

	vector := (2, 3)
"
Class {
	#name : #BlVector2D,
	#superclass : #BlVector,
	#instVars : [
		'x',
		'y'
	],
	#category : #'Bloc-Basic-Math'
}

{ #category : #arithmetic }
BlVector2D >> * aScalar [
	"Multiplicate me by a given scalar (it can be a number, point, or vector)"
	<return: #BlVector>
	
	^ aScalar scalarMultiplicate2D: self
]

{ #category : #arithmetic }
BlVector2D >> + anotherVector [
	"Perform an addition of a given vector and me"
	<return: #BlVector>

	^ anotherVector add2D: self
]

{ #category : #converting }
BlVector2D >> , aNumber [
	<return: #BlVector>

	^ BlVector3D x: self x y: self y z: aNumber
]

{ #category : #arithmetic }
BlVector2D >> - anotherVector [
	"Perform a subtraction of a given vector from me and return a resulting vector"
	<return: #BlVector>

	^ anotherVector subtract2D: self
]

{ #category : #arithmetic }
BlVector2D >> / aVector [
	| vector |
	vector := aVector asBlocVector.

	^ self class
		x: self x / vector x
		y: self y / vector y
]

{ #category : #comparing }
BlVector2D >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].

	^ self x = anObject x
		and: [ self y = anObject y ]
]

{ #category : #converting }
BlVector2D >> adaptToNumber: aNumber andSend: aSelector [
	"If I am involved in arithmetic with an Integer, convert it to a Vector of the same dimension"
	<return: #BlVector>

	^ (BlVector x: aNumber y: aNumber) perform: aSelector with: self
]

{ #category : #converting }
BlVector2D >> adaptToPoint: aPoint andSend: aSelector [
	"If I am involved in arithmetic with an Point, convert me to a point and perform that operation"
	<return: #Point>

	^ aPoint perform: aSelector with: self asPoint
]

{ #category : #arithmetic }
BlVector2D >> add2D: aVector2D [
	"Add me to a given 2D vector"
	<return: #BlVector>

	^ self class
		x: aVector2D x + self x
		y: aVector2D y + self y
]

{ #category : #arithmetic }
BlVector2D >> add3D: aVector3D [
	"Add me to a given 3D vector"
	<return: #BlVector>

	^ self class
		x: aVector3D x + self x
		y: aVector3D y + self y
		z: aVector3D z
]

{ #category : #converting }
BlVector2D >> asPoint [
	<return: #Point>
	^ x @ y
]

{ #category : #converting }
BlVector2D >> asScale3D [
	"Return a 3D vector representing a scale factor"
	<return: #BlVector3D>
	
	^ (self , 1)
]

{ #category : #converting }
BlVector2D >> asTranslate3D [
	"Return a 3D vector representing a translation vector"
	<return: #BlVector3D>

	^ (self , 0)
]

{ #category : #comparing }
BlVector2D >> closeTo: anotherVector [
	^ (self x closeTo: anotherVector x)
		and: [ self y closeTo: anotherVector y ]
]

{ #category : #arithmetic }
BlVector2D >> dotProduct2D: anotherVector [
	<return: #Number>

	^ (self x * anotherVector x) + (self y * anotherVector y)
]

{ #category : #arithmetic }
BlVector2D >> dotProduct: anotherVector [
	<return: #Number>

	^ anotherVector dotProduct2D: self
]

{ #category : #comparing }
BlVector2D >> hash [
	^ self x hash bitXor: self y hash
]

{ #category : #'vector functions' }
BlVector2D >> length [
	<return: #Number>
	
	^ ((self x * self x) + (self y * self y)) sqrt
]

{ #category : #'vector functions' }
BlVector2D >> negated [
	<return: #BlVector>

	^ BlVector
		x: self x negated
		y: self y negated
]

{ #category : #'vector functions' }
BlVector2D >> normal [
	<return: #BlVector>

	^ self asPoint normal asBlocVector
]

{ #category : #'vector functions' }
BlVector2D >> normalized [
	<return: #BlVector>
	| aLength |
	
	aLength := self length.
	self
		assert: [ aLength isZero not ]
		description: [ 'It is not possible to normalize a zero vector' ].

	^ self class
		x: self x / aLength
		y: self y / aLength
]

{ #category : #printing }
BlVector2D >> printOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: self x asString;
		nextPutAll: ', ';
		nextPutAll: self y asString;
		nextPut: $)
]

{ #category : #'vector functions' }
BlVector2D >> rotateBy: anAngleInRadians about: aCenterPoint [ 
	"Even though Point.theta is measured CW, this rotates with the more conventional CCW interpretateion of angle."
	| p r theta |
	p := self asPoint - aCenterPoint.
	r := p r.
	theta := anAngleInRadians asFloat - p theta.
	self x: (aCenterPoint x asFloat + (r * theta cos)) y: (aCenterPoint y asFloat - (r * theta sin))
]

{ #category : #arithmetic }
BlVector2D >> scalarMultiplicate2D: aVector2D [
	"Perform a scalar multiplication of a given 2D vector by me"
	<return: #BlVector>

	^ BlVector
		x: aVector2D x * self x
		y: aVector2D y * self y
]

{ #category : #arithmetic }
BlVector2D >> sign [
	^ self class x: self x sign y: self y sign
]

{ #category : #arithmetic }
BlVector2D >> subtract2D: aVector2D [
	"Substruct me from a given 2D vector"
	<return: #BlVector>

	^ self class
		x: aVector2D x - self x
		y: aVector2D y - self y
]

{ #category : #arithmetic }
BlVector2D >> subtract3D: aVector3D [
	"Substruct me from a given 3D vector"
	<return: #BlVector>

	^ self class
		x: aVector3D x - self x
		y: aVector3D y - self y
		z: aVector3D z
]

{ #category : #accessing }
BlVector2D >> x [
	<return: #Number>

	^ x
]

{ #category : #initialization }
BlVector2D >> x: aX y: aY [
	x := aX.
	y := aY
]

{ #category : #accessing }
BlVector2D >> y [
	<return: #Number>

	^ y
]
