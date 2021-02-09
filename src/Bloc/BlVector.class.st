"
I represent an abstract dimension-less vector.
My subclasses implement API for concrete spaces (2D, 3D, etc). Users should not directly refer to my subclasses. Such classes are implementation classes.

I define basic vector function such as:
	- length
	- negated
	- normalized
	
Instance creation examples:

Create a 2D vector:

```
	BlVector x: 10 y: 20
	or
	(10, 20)
```	
Create a 3D vector:

```
	BlVector x: 10 y: 20 z: 30
	or
	(10, 20, 30)
```
"
Class {
	#name : #BlVector,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#classInstVars : [
		'zAxis',
		'xAxis',
		'yAxis',
		'zero',
		'one'
	],
	#category : #'Bloc-Basic-Math'
}

{ #category : #cleanup }
BlVector class >> cleanUp [
	super cleanUp.
	
	xAxis := nil.
	yAxis := nil.
	zAxis := nil.
	zero := nil.
	one := nil
]

{ #category : #'instance creation' }
BlVector class >> one [
	"Return a vector with all components being ones."
	<return: #BlVector>
	
	^ one ifNil: [ one := self x: 1 y: 1 z: 1 ]
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
	
	^ xAxis ifNil: [ xAxis := self x: 1 y: 0 z: 0 ]
]

{ #category : #'instance creation' }
BlVector class >> yAxis [
	"Return a vector that corresponds to y-axis"
	<return: #BlVector>
	
	^ yAxis ifNil: [ yAxis := self x: 0 y: 1 z: 0 ]
]

{ #category : #'instance creation' }
BlVector class >> zAxis [
	"Return a vector that corresponds to z-axis"
	<return: #BlVector>
	
	^ zAxis ifNil: [ zAxis := self x: 0 y: 0 z: 1 ]
]

{ #category : #'instance creation' }
BlVector class >> zero [
	"Return a vector of zero length."
	<return: #BlVector>
	
	^ zero ifNil: [ zero := self x: 0 y: 0 z: 0 ]
]

{ #category : #arithmetic }
BlVector >> * aScalar [
	"Return a new vector as a multiplicate of the receiver by a given scalar (it can be a number, point, or vector)."
	<return: #BlVector>
	
	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> + anotherVector [
	"Perform an addition of a given vector and me"
	<return: #BlVector>

	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> - anotherVector [
	"Perform a subtraction of a given vector from me and return a resulting vector"
	<return: #BlVector>

	^ self subclassResponsibility
]

{ #category : #comparing }
BlVector >> = anObject [
	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> add2D: aVector2D [
	"Add the receiver to a given 2D vector."
	<return: #BlVector>

	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> add3D: aVector3D [
	"Add the receiver to a given 3D vector."
	<return: #BlVector>

	^ self subclassResponsibility
]

{ #category : #converting }
BlVector >> asBlocVector [
	<return: #BlVector>

	^ self
]

{ #category : #converting }
BlVector >> asScale3D [
	"Return a 3D vector representing a scale factor"
	<return: #BlVector3D>
	
	^ self subclassResponsibility
]

{ #category : #converting }
BlVector >> asTranslate3D [
	"Return a 3D vector representing a translation vector"
	<return: #BlVector3D>

	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> dotProduct2D: anotherVector [
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> dotProduct: anotherVector [
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #comparing }
BlVector >> hash [
	^ self subclassResponsibility
]

{ #category : #testing }
BlVector >> isOne [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlVector >> isParallel: aBlVector [
	<return: #Boolean>

	^ (self dotProduct: aBlVector) abs closeTo: 1
]

{ #category : #testing }
BlVector >> isZero [
	<return: #Boolean>
	
	^ self length isZero
]

{ #category : #'vector functions' }
BlVector >> length [
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #'vector functions' }
BlVector >> negated [
	<return: #BlVector>

	^ self subclassResponsibility
]

{ #category : #'vector functions' }
BlVector >> normal [
	"Return a unit vector rotated clockwise. For the zero length vector return (-1, 0)."
	<return: #BlVector>
	
	^ self subclassResponsibility
]

{ #category : #'vector functions' }
BlVector >> normalized [
	<return: #BlVector>

	^ self subclassResponsibility
]

{ #category : #'vector functions' }
BlVector >> rotateBy: anAngleInRadians [
	self rotateBy: anAngleInRadians about: 0@0
]

{ #category : #'vector functions' }
BlVector >> rotateBy: anAngleInRadians about: aCenterPoint [ 
	self subclassResponsibility
]

{ #category : #arithmetic }
BlVector >> scalarMultiplicate2D: aVector2D [
	"Perform a scalar multiplication of a given 2D vector by me"
	<return: #BlVector>

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
