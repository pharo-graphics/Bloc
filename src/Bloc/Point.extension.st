Extension { #name : #Point }

{ #category : #'*Bloc' }
Point >> @ aNumber [
	"Create a new 3D point with x and y represented by me and given number as z"
	<return: #BlPoint3D>

	^ BlPoint3D x: x y: y z: aNumber
]

{ #category : #'*Bloc' }
Point >> asBlocVector [
	^ BlVector x: x y: y
]

{ #category : #'*Bloc' }
Point >> asScale3D [
	"Return a 3D vector representing a scale factor"
	<return: #BlVector3D>

	^ BlVector x: self x y: self y z: 1
]

{ #category : #'*Bloc' }
Point >> asTranslate3D [
	"Return a 3D vector representing a translation vector"
	<return: #BlVector3D>

	^ BlVector x: self x y: self y z: 0
]

{ #category : #'*Bloc' }
Point >> isPoint2D [
	"Return true if I represent a 2D point, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #'*Bloc' }
Point >> isPoint3D [
	"Return true if I represent a 3D point, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'*Bloc' }
Point >> scalarMultiplicate2D: aVector2D [
	"Perform a scalar multiplication of a given 2D vector by me"
	<return: #BlVector>

	^ BlVector
		x: aVector2D x * self x
		y: aVector2D y * self y
]

{ #category : #'*Bloc' }
Point >> transformedOn: aBlMatrix [
	<return: #BlPoint>
	
	^ aBlMatrix transformPoint2D: self
]
