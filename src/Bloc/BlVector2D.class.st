"
I represent a 2D Euclidean vector

https://en.wikipedia.org/wiki/Euclidean_vector

Instance creation:

	vector := (2, 3).
	
## Examples
### 45 Degrees
{{gtExample:BlVector2DExamples>>#vector_45degrees|codeExpanded=false|previewExpanded=true}}
### 346 Degrees
{{gtExample:BlVector2DExamples>>#vector_346degrees|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : 'BlVector2D',
	#superclass : 'BlVector',
	#instVars : [
		'x',
		'y'
	],
	#category : 'Bloc-Basic-Math'
}

{ #category : 'arithmetic' }
BlVector2D >> * aScalar [
	"Return a new vector as a multiplicate of the receiver by a given scalar (it can be a number, point, or vector)."
	
	^ aScalar scalarMultiplicate2D: self
]

{ #category : 'arithmetic' }
BlVector2D >> + anotherVector [
	"Answer a new vector that represents the addition of a given vector and me."

	^ anotherVector add2D: self
]

{ #category : 'arithmetic' }
BlVector2D >> - anotherVector [
	"Answer a new vector that represents the subtraction of a given vector from me."

	^ anotherVector subtract2D: self
]

{ #category : 'arithmetic' }
BlVector2D >> / aVectorizable [
	"Answer a new `BlVector2D` that represents the division of self by the argument, which can be either a `BlVector`, a `Point` or an `Integer`."

	| vector |
	vector := aVectorizable asBlocVector.

	^ self class
		x: x / vector x
		y: y / vector y
]

{ #category : 'comparing' }
BlVector2D >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].

	^ x = anObject x and: [ y = anObject y ]
]

{ #category : 'converting' }
BlVector2D >> adaptToNumber: aNumber andSend: aSelector [
	"If I am involved in arithmetic with an Integer, convert it to a Vector of the same dimension"

	^ (self class x: aNumber y: aNumber) perform: aSelector with: self
]

{ #category : 'converting' }
BlVector2D >> adaptToPoint: aPoint andSend: aSelector [
	"If I am involved in arithmetic with an Point, convert me to a point and perform that operation"

	^ aPoint perform: aSelector with: self asPoint
]

{ #category : 'arithmetic' }
BlVector2D >> add2D: aVector2D [
	"Answer a new vector that represents the addition of a given vector and me."

	^ self class
		x: aVector2D x + x
		y: aVector2D y + y
]

{ #category : 'arithmetic' }
BlVector2D >> add3D: aVector3D [
	"Answer a new 3D vector that represents the addition of a given vector and me."

	^ self class
		x: aVector3D x + x
		y: aVector3D y + y
		z: aVector3D z
]

{ #category : 'converting' }
BlVector2D >> asPoint [

	^ x @ y
]

{ #category : 'converting' }
BlVector2D >> asScale3D [
	"Return a 3D vector representing a scale factor."

	^ BlVector3D x: x y: y z: 1
]

{ #category : 'converting' }
BlVector2D >> asTranslate3D [
	"Return a 3D vector representing a translation vector."

	^ BlVector3D x: x y: y z: 0
]

{ #category : 'comparing' }
BlVector2D >> closeTo: anotherVector [

	^ (x closeTo: anotherVector x) and: [ y closeTo: anotherVector y ]
]

{ #category : 'accessing' }
BlVector2D >> degrees [
	"Return the receiver degrees"
	
	^ self radians * 180.0 / Float pi
]

{ #category : 'arithmetic' }
BlVector2D >> dotProduct2D: anotherVector [

	^ x * anotherVector x + (y * anotherVector y)
]

{ #category : 'arithmetic' }
BlVector2D >> dotProduct: anotherVector [

	^ anotherVector dotProduct2D: self
]

{ #category : 'comparing' }
BlVector2D >> hash [

	^ x hash bitXor: y hash
]

{ #category : 'testing' }
BlVector2D >> isOne [

	^ (x closeTo: 1.0) and: [ y closeTo: 1.0 ]
]

{ #category : 'testing' }
BlVector2D >> isZero [

	^ x isZero and: [ y isZero ]
]

{ #category : 'vector functions' }
BlVector2D >> length [

	^ ((x * x) + (y * y)) sqrt
]

{ #category : 'vector functions' }
BlVector2D >> negated [

	^ self class
		x: x negated
		y: y negated
]

{ #category : 'vector functions' }
BlVector2D >> normal [
	"Return a unit vector rotated clockwise. For the zero length vector, return (-1, 0)."

	^ self asPoint normal asBlocVector
]

{ #category : 'vector functions' }
BlVector2D >> normalized [

	| aLength |
	
	aLength := self length.
	aLength isZero ifTrue: [
		self error: 'It is not possible to normalize a zero-length vector' ].

	^ self class
		x: x / aLength
		y: y / aLength
]

{ #category : 'printing' }
BlVector2D >> printOn: aStream [

	aStream
		nextPut: $(;
		nextPutAll: x asString;
		nextPutAll: ', ';
		nextPutAll: y asString;
		nextPut: $)
]

{ #category : 'accessing' }
BlVector2D >> radians [
	"Return vector radians"

	| aResult |
	(x isZero and: [ y isZero ]) ifTrue: [ 
		self error: 'Cannot compute radians for ', self printString ].

	(x isZero and: [ y < 0 ]) ifTrue: [ ^ Float pi + Float halfPi ].
	(x isZero and: [ y > 0 ]) ifTrue: [ ^ Float halfPi ].

	aResult := (y abs / x abs) arcTan.
	(x >= 0 and: [ y < 0 ]) ifTrue: [ ^ Float twoPi - aResult ].
	(x < 0 and: [ y < 0 ]) ifTrue: [ ^ Float pi + aResult ].
	(x < 0 and: [ y >= 0 ]) ifTrue: [ ^ Float pi - aResult ].

	^ aResult
]

{ #category : 'vector functions' }
BlVector2D >> rotateBy: anAngleInRadians about: aCenterPoint [
	"Rotate me by an angle in CCW radians.
	Warning 1: Even though Point.theta is measured CW, this rotates with the more conventional CCW interpretateion of angle.
	Warning 2: Self instance is mutated, unlike most members of my API. 
	"

	| p r theta |
	p := self asPoint - aCenterPoint.
	r := p r.
	theta := anAngleInRadians asFloat - p theta.
	self
		x: aCenterPoint x asFloat + (r * theta cos)
		y: aCenterPoint y asFloat - (r * theta sin)
]

{ #category : 'arithmetic' }
BlVector2D >> scalarMultiplicate2D: aVector2D [
	"Answer a new `BlVector2D` with the multiplication of me with the received argument."

	^ self class
		x: aVector2D x * x
		y: aVector2D y * y
]

{ #category : 'arithmetic' }
BlVector2D >> sign [
	"Returns a vector as the receiver sign."

	^ self class x: x sign y: y sign
]

{ #category : 'arithmetic' }
BlVector2D >> subtract2D: aVector2D [
	"Answer a new `BlVector2D` with the substraction of self to the received argument."

	^ self class
		x: aVector2D x - self x
		y: aVector2D y - self y
]

{ #category : 'arithmetic' }
BlVector2D >> subtract3D: aVector3D [
	"Answer a new `BlVector3D` with the substraction of self to the received argument."

	^ self class
		x: aVector3D x - self x
		y: aVector3D y - self y
		z: aVector3D z
]

{ #category : 'accessing' }
BlVector2D >> x [

	^ x
]

{ #category : 'initialization' }
BlVector2D >> x: aX y: aY [

	x := aX.
	y := aY
]

{ #category : 'accessing' }
BlVector2D >> y [

	^ y
]
