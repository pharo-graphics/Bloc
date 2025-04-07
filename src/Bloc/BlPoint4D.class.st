"
I am a 4D point, with x, y, z and w coordinates.
"
Class {
	#name : #BlPoint4D,
	#superclass : #BlPoint,
	#instVars : [
		'x',
		'y',
		'z',
		'w'
	],
	#category : #'Bloc-Basic-Math'
}

{ #category : #'instance creation' }
BlPoint4D class >> x: aX y: aY z: aZ w: aW [

	^ self new
		x: aX y: aY z: aZ w: aW;
		yourself
]

{ #category : #converting }
BlPoint4D >> asPoint2D [

	^ BlPoint2D x: (self x asFloat / self w) y: (self y asFloat / self w)
]

{ #category : #initialization }
BlPoint4D >> initialize [

	super initialize.

	x := 0.0.
	y := 0.0.
	z := 0.0.
	w := 0.0
]

{ #category : #'matrix - transforming points' }
BlPoint4D >> transformedOn: aBlMatrix [
	
	^ aBlMatrix transformPoint4D: self
]

{ #category : #accessing }
BlPoint4D >> w [

	^ w
]

{ #category : #accessing }
BlPoint4D >> x [

	^ x
]

{ #category : #initialization }
BlPoint4D >> x: aX y: aY z: aZ w: aW [

	x := aX.
	y := aY.
	z := aZ.
	w := aW
]

{ #category : #accessing }
BlPoint4D >> y [

	^ y
]

{ #category : #accessing }
BlPoint4D >> z [

	^ z
]
