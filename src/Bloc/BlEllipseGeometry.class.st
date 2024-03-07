"
I am an ellipse geometry.

I can play a role of a circle if both width and height are equal. In this case can be created using a predefined factory method:

	BlEllipseGeometry radius: 20 ""creates a circle with radius 20""
	BlEllipseGeometry diameter: 40 ""creates a circle with diameter 40 or radius 20""
	
In order to explicitely create an ellipse use extent:

	BlEllipseGeometry extent: 50@30 ""create an ellipse with width 50 and height 30""
"
Class {
	#name : #BlEllipseGeometry,
	#superclass : #BlElementVectorGeometry,
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #comparing }
BlEllipseGeometry >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	^ self class = anObject class
]

{ #category : #'geometry testing' }
BlEllipseGeometry >> containsPoint: aPoint alreadyInGeometryBoundsOf: aBlElement [
	| w h x y center xRadius yRadius normalized |
	
	w := self extent x.
	h := self extent y.
	x := 0.
	y := 0.
	
	xRadius := w / 2.0.
	yRadius := h / 2.0.
	center := (x + xRadius) @ (y + yRadius).

	(xRadius <= 0 or: [ yRadius <= 0 ])
		ifTrue: [ ^ false ].

	normalized := (aPoint x - center x) @ (aPoint y - center y).
	^ ((normalized x squared / xRadius squared) + (normalized y squared / yRadius squared)) <= 1
]

{ #category : #testing }
BlEllipseGeometry >> hasCaps [

	^ false
]

{ #category : #testing }
BlEllipseGeometry >> hasJoins [

	^ false
]

{ #category : #geometry }
BlEllipseGeometry >> matchExtent: anExtent [
	self extent: anExtent
]
