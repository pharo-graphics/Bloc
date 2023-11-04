"
I am a 3D geometric point that usually represents the x, y, z coordinates.
I can also represent a relative magnitude vector's x, y, z magnitudes.

Example:

point3D := 5 @ 10 @ 20. "" x = 5; y = 10; z = 20""

"
Class {
	#name : 'BlPoint3D',
	#superclass : 'BlPoint',
	#instVars : [
		'x',
		'y',
		'z'
	],
	#category : 'Bloc-Basic-Math'
}

{ #category : 'instance creation' }
BlPoint3D class >> x: aX y: aY z: aZ [

	^ self new
		x: aX y: aY z: aZ;
		yourself
]

{ #category : 'composition' }
BlPoint3D >> @ aNumber [
	"Return a new 4D point with x, y and z represented by components and given number as w."
	<return: #BlPoint4D>
	
	^ BlPoint4D x: x y: y z: z w: aNumber
]

{ #category : 'initialization' }
BlPoint3D >> initialize [
	super initialize.
	
	x := 0.0.
	y := 0.0.
	z := 0.0
]

{ #category : 'testing' }
BlPoint3D >> isPoint [
	"Return true if I represent a point, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : 'testing' }
BlPoint3D >> isPoint2D [
	"Return true if I represent a 2D point, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : 'testing' }
BlPoint3D >> isPoint3D [
	"Return true if I represent a 3D point, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : 'testing' }
BlPoint3D >> isZero [
	"Return true if all my components are zeros, false otherwise"
	<return: #Boolean>
	
	^ x isZero and: [ y isZero and: [ z isZero ] ]
]

{ #category : 'printing' }
BlPoint3D >> printOn: aStream [
	aStream nextPut: $(.
	x printOn: aStream.
	aStream nextPut: $@.
	(y notNil and: [y negative])
		ifTrue: [
			"Avoid ambiguous @- construct"
			aStream space].
	y printOn: aStream.
	aStream nextPut: $@.
	(z notNil and: [z negative])
		ifTrue: [
			"Avoid ambiguous @- construct"
			aStream space].
	z printOn: aStream.
	aStream nextPut: $).
]

{ #category : 'printing' }
BlPoint3D >> storeOn: aStream [ 
	"x@y@z printed form is good for storing too"
	aStream nextPut: $(.
	self printOn: aStream.
	aStream nextPut: $).
]

{ #category : 'matrix - transforming points' }
BlPoint3D >> transformedOn: aBlMatrix [
	<return: #BlPoint>
	
	^ aBlMatrix transformPoint3D: self
]

{ #category : 'accessing' }
BlPoint3D >> x [
	"Return my x component"
	<return: #Number>
	
	^ x
]

{ #category : 'initialization' }
BlPoint3D >> x: aX y: aY z: aZ [

	x := aX.
	y := aY.
	z := aZ
]

{ #category : 'accessing' }
BlPoint3D >> y [
	"Return my y component"
	<return: #Number>
	
	^ y
]

{ #category : 'accessing' }
BlPoint3D >> z [
	"Return my z component"
	<return: #Number>
	
	^ z
]
