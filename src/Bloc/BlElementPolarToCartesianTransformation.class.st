"
(Proof of concept)
I allow elements to define their position in polar coordinates

[[[
| container |
container := BlElement new.
container size: 200@200.
container relocate: 300@170.
container clipChildren: false.

(0 to: 200 by: 200 / 72.0) with: (0 to: 720 by: 10)
	do: [ :aRadius :anAngleInDegrees |
		container addChild: (BlElement new
			""define position of an element in Polar coordinates (R, phi)""
			relocate: aRadius @ anAngleInDegrees;
			""set transform from polar to cartesian coordinates""
			transformation: BlElementPolarToCartesianTransformation new;
			size: 3@3;
			background: Color gray;
			yourself) ].

container
]]]
"
Class {
	#name : #BlElementPolarToCartesianTransformation,
	#superclass : #BlElementDynamicTransformation,
	#category : 'Bloc-Basic-Transformations'
}

{ #category : #computation }
BlElementPolarToCartesianTransformation >> computeMatrix [
	| polarR polarPhi cartesianX cartesianY |

	polarR := self owner position x.
	polarPhi := self owner position y.
	
	cartesianX := polarR * polarPhi degreesToRadians cos.
	cartesianY := polarR * polarPhi degreesToRadians sin negated.

	matrix translateBy: (BlVector x: cartesianX - polarR y: cartesianY - polarPhi )

	"matrix := BlMatrix2D new
		sx: self owner position y cos;
		shx: self owner position x negated * self owner position y sin;
		sy: self owner position x * self owner position y cos;
		shy: self owner position y sin"
]

{ #category : #invalidation }
BlElementPolarToCartesianTransformation >> invalidateMatrix [
	"Matrix is computed out of affine transformation composition
	which may contain transformations that depend on element's properties
	such as extent. It means that when element changes we need to invalidate and
	recompute the matrix => set it to nil to trigger computation on next matrix access"

	matrix := nil
]

{ #category : #testing }
BlElementPolarToCartesianTransformation >> is2D [
	"Return true if my current transformation is in 2D space, false otherwise"
	<return: #Boolean>

	^ true
]

{ #category : #testing }
BlElementPolarToCartesianTransformation >> is3D [
	"Return true if my current transformation is in 3D space, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #testing }
BlElementPolarToCartesianTransformation >> isIdentity [
	"Return true if I represent an identity transformation, false otherwise"
	<return: #Boolean>
	
	^ false
]

{ #category : #accessing }
BlElementPolarToCartesianTransformation >> owner: anElement [
	super owner: anElement.
	
	anElement when: BlElementPositionChange do: [ self invalidateMatrix ]
]
