Class {
	#name : 'BlPoint2D',
	#superclass : 'BlPoint',
	#instVars : [
		'x',
		'y'
	],
	#category : 'Bloc-Basic-Math'
}

{ #category : 'instance creation' }
BlPoint2D class >> x: aX y: aY [

	^ self new x: aX y: aY
]

{ #category : 'comparing' }
BlPoint2D >> < aPoint [
	"Answer whether the receiver is above and to the left of aPoint."
	<return: #Boolean>

	^ x < aPoint x and: [ y < aPoint y ]
]

{ #category : 'converting' }
BlPoint2D >> asPoint2D [
	<return: #BlPoint2D>

	^ self
]

{ #category : 'initialization' }
BlPoint2D >> initialize [
	super initialize.
	
	x := 0.0.
	y := 0.0
]

{ #category : 'comparing' }
BlPoint2D >> max: aBlPoint [
	<return: #BlPoint>

	^ (x max: aBlPoint x) @ (y max: aBlPoint y)
]

{ #category : 'comparing' }
BlPoint2D >> min: aBlPoint [
	<return: #BlPoint>

	^ (x min: aBlPoint x) @ (y min: aBlPoint y)
]

{ #category : 'matrix - transforming points' }
BlPoint2D >> transformedOn: aBlMatrix [
	<return: #BlPoint>
	
	^ aBlMatrix transformPoint2D: self
]

{ #category : 'transformations' }
BlPoint2D >> translateBy: aDelta [ 
	"Answer a 2D Point translated by delta (an instance of Point)."
	<return: #BlPoint2D>

	^ self class x: (aDelta x + x) y: (aDelta y + y)
]

{ #category : 'accessing' }
BlPoint2D >> x [
	^ x
]

{ #category : 'accessing' }
BlPoint2D >> x: anObject [
	x := anObject
]

{ #category : 'initialization' }
BlPoint2D >> x: aX y: aY [
	x := aX.
	y := aY
]

{ #category : 'accessing' }
BlPoint2D >> y [
	^ y
]

{ #category : 'accessing' }
BlPoint2D >> y: anObject [
	y := anObject
]
