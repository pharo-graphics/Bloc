"
I represent a 3D Euclidean vector

https://en.wikipedia.org/wiki/Euclidean_vector

Instance creation:

	vector := (2, 3, 5)

"
Class {
	#name : #BlVector3D,
	#superclass : #BlVector,
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : 'Bloc-Basic-Math'
}

{ #category : 'arithmetic' }
BlVector3D >> * aScalar [
	"Return a new vector as a multiplicate of the receiver by a given scalar (it can be a number, point, or vector)."
	<return: #BlVector>
	
	^ aScalar scalarMultiplicate3D: self
]

{ #category : 'arithmetic' }
BlVector3D >> + anotherVector [
	"Return the addition of a given vector and the receiver."
	<return: #BlVector>

	^ anotherVector add3D: self
]

{ #category : 'arithmetic' }
BlVector3D >> - anotherVector [
	"Perform a subtraction of a given vector from me and return a resulting vector"
	<return: #BlVector>

	^ anotherVector subtract3D: self
]

{ #category : 'comparing' }
BlVector3D >> = anObject [
	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].

	^ self x = anObject x
		and: [ self y = anObject y
			and: [ self z = anObject z ] ]
]

{ #category : 'converting' }
BlVector3D >> adaptToNumber: aNumber andSend: aSelector [
	"If I am involved in arithmetic with an Integer, convert it to a Vector of the same dimension"
	<return: #BlVector>

	^ (BlVector x: aNumber y: aNumber z: aNumber) perform: aSelector with: self
]

{ #category : 'arithmetic' }
BlVector3D >> add2D: aVector2D [
	"Add me from a given 2D vector"
	<return: #BlVector>

	^ self class
		x: aVector2D x + self x
		y: aVector2D y + self y
		z: self z
]

{ #category : 'arithmetic' }
BlVector3D >> add3D: aVector3D [
	"Add me to a given 3D vector"
	<return: #BlVector>

	^ self class
		x: aVector3D x + self x
		y: aVector3D y + self y
		z: aVector3D z + self z
]

{ #category : 'converting' }
BlVector3D >> asScale3D [
	"Return a 3D vector representing a scale factor"
	
	^ self
]

{ #category : 'converting' }
BlVector3D >> asTranslate3D [
	"Return a 3D vector representing a translation vector"

	^ self
]

{ #category : 'comparing' }
BlVector3D >> hash [
	^ (self x hash bitXor: self y hash) bitXor: self z hash
]

{ #category : 'testing' }
BlVector3D >> isOne [
	
	^ (self x closeTo: 1) and: [ (self y closeTo: 1) and: [ self z closeTo: 1 ] ]
]

{ #category : 'vector functions' }
BlVector3D >> length [
	<return: #Number>
	
	^ ((self x * self x) + (self y * self y) + (self z * self z)) sqrt
]

{ #category : 'vector functions' }
BlVector3D >> negated [
	<return: #BlVector>

	^ BlVector
		x: self x negated
		y: self y negated
		z: self z negated
]

{ #category : 'vector functions' }
BlVector3D >> normalized [

	| aLength |
	
	aLength := self length.
	aLength isZero ifTrue: [
		self error: 'It is not possible to normalize a zero-length vector' ].

	^ self class
		x: x / aLength
		y: y / aLength
		z: z / aLength
]

{ #category : 'printing' }
BlVector3D >> printOn: aStream [
	aStream
		nextPut: $(;
		nextPutAll: self x asString;
		nextPutAll: ', ';
		nextPutAll: self y asString;
		nextPutAll: ', ';
		nextPutAll: self z asString;
		nextPut: $)
]

{ #category : 'arithmetic' }
BlVector3D >> subtract2D: aVector2D [
	"Substruct me from a given 2D vector"
	<return: #BlVector>

	^ self class
		x: aVector2D x - self x
		y: aVector2D y - self y
		z: self z negated
]

{ #category : 'arithmetic' }
BlVector3D >> subtract3D: aVector3D [
	"Substruct me from a given 3D vector"
	<return: #BlVector>

	^ self class
		x: aVector3D x - self x
		y: aVector3D y - self y
		z: aVector3D z - self z
]

{ #category : 'accessing' }
BlVector3D >> x [
	<return: #Number>

	^ x
]

{ #category : 'initialization' }
BlVector3D >> x: aX y: aY z: aZ [
	x := aX.
	y := aY.
	z := aZ
]

{ #category : 'accessing' }
BlVector3D >> y [
	<return: #Number>

	^ y
]

{ #category : 'accessing' }
BlVector3D >> z [
	<return: #Number>

	^ z
]
