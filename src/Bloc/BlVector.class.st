"
I represent an abstract dimension-less vector.
My subclasses implement API for concrete spaces (2D, 3D, etc).

I define basic vector function such as:
	- length
	- negated
	- normalized
	
Instance creation examples:

Create a 2D vector:

	BlVector x: 10 y: 20
	or
	(10, 20)
	
Create a 3D vector:

	BlVector x: 10 y: 20 z: 30
	or
	(10, 20, 30)

"
Class {
	#name : #BlVector,
	#superclass : #Object,
	#classVars : [
		'One',
		'XAxis',
		'YAxis',
		'ZAxis',
		'Zero'
	],
	#category : #'Bloc-Basic-Math'
}

{ #category : #cleanup }
BlVector class >> cleanUp [
	super cleanUp.
	
	XAxis := nil.
	YAxis := nil.
	ZAxis := nil.
	Zero := nil.
	One := nil
]

{ #category : #'instance creation' }
BlVector class >> one [
	"Return a vector with all components being ones."
	<return: #BlVector>
	
	^ One ifNil: [ One := self x: 1 y: 1 z: 1 ]
]

{ #category : #'instance creation' }
BlVector class >> x: aX y: aY [
	^ BlVector2D new x: aX y: aY
]

{ #category : #'instance creation' }
BlVector class >> x: aX y: aY z: aZ [
	"Return a 3 dimensional vector."
	
	^ BlVector3D new x: aX y: aY z: aZ
]

{ #category : #'instance creation' }
BlVector class >> xAxis [
	"Return a vector that corresponds to x-axis"
	<return: #BlVector>
	
	^ XAxis ifNil: [ XAxis := self x: 1 y: 0 z: 0 ]
]

{ #category : #'instance creation' }
BlVector class >> yAxis [
	"Return a vector that corresponds to y-axis"
	<return: #BlVector>
	
	^ YAxis ifNil: [ YAxis := self x: 0 y: 1 z: 0 ]
]

{ #category : #'instance creation' }
BlVector class >> zAxis [
	"Return a vector that corresponds to z-axis"
	<return: #BlVector>
	
	^ ZAxis ifNil: [ ZAxis := self x: 0 y: 0 z: 1 ]
]

{ #category : #'instance creation' }
BlVector class >> zero [
	"Return a vector of zero length."
	
	^ Zero ifNil: [ Zero := self x: 0 y: 0 z: 0 ]
]

{ #category : #arithmetic }
BlVector >> * aScalar [
	"Return a new vector as a multiplicate of the receiver by a given scalar (it can be a number, point, or vector)."
	
	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> + anotherVector [
	"Perform an addition of a given vector and me"

	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> - anotherVector [
	"Perform a subtraction of a given vector from me and return a resulting vector"

	^ self subclassResponsibility
]

{ #category : #comparing }
BlVector >> = anObject [

	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> add2D: aVector2D [
	"Add the receiver to a given 2D vector."

	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> add3D: aVector3D [
	"Add the receiver to a given 3D vector."

	^ self subclassResponsibility
]

{ #category : #converting }
BlVector >> asBlocVector [

	^ self
]

{ #category : #converting }
BlVector >> asScale3D [
	"Return a `BlVector3D` representing a scale factor."
	
	^ self subclassResponsibility
]

{ #category : #converting }
BlVector >> asTranslate3D [
	"Return a `BlVector3D` representing a translation vector."

	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> dotProduct2D: anotherVector [
	
	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> dotProduct: anotherVector [
	
	^ self subclassResponsibility
]

{ #category : #comparing }
BlVector >> hash [

	^ self subclassResponsibility
]

{ #category : #testing }
BlVector >> isOne [

	^ self subclassResponsibility
]

{ #category : #testing }
BlVector >> isParallel: aBlVector [

	^ (self dotProduct: aBlVector) abs closeTo: 1.0
]

{ #category : #testing }
BlVector >> isZero [

	^ self length isZero
]

{ #category : #'vector functions' }
BlVector >> length [
	
	^ self subclassResponsibility
]

{ #category : #'vector functions' }
BlVector >> negated [

	^ self subclassResponsibility
]

{ #category : #'vector functions' }
BlVector >> normal [
	"Return a unit vector rotated clockwise. For the zero length vector return (-1, 0)."
	
	^ self subclassResponsibility
]

{ #category : #'vector functions' }
BlVector >> normalized [

	^ self subclassResponsibility
]

{ #category : #'vector functions' }
BlVector >> rotateBy: anAngleInRadians [

	self rotateBy: anAngleInRadians about: 0 @ 0
]

{ #category : #'vector functions' }
BlVector >> rotateBy: anAngleInRadians about: aCenterPoint [

	self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> scalarMultiplicate2D: aVector2D [
	"Answer a new `BlVector2D` with the multiplication of me with the received argument."

	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> scalarMultiplicate3D: aVector3D [
	"Return a new vector by performing a scalar multiplication of a given 3D vector by me."
	<return: #BlVector>

	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> sign [
	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> subtract2D: aVector2D [
	"Substruct me from a given 2D vector"
	<return: #BlVector>

	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> subtract3D: aVector3D [
	"Substruct me from a given 3D vector"
	<return: #BlVector>
	
	^ self subclassResponsibility
]
