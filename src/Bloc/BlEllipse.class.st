"
I am an ellipse geometry.

I can play a role of a circle if both width and height are equal. In this case can be created using a predefined factory method:

	BlEllipse radius: 20 ""creates a circle with radius 20""
	BlEllipse diameter: 40 ""creates a circle with diameter 40 or radius 20""
	
In order to explicitely create an ellipse use extent:

	BlEllipse extent: 50@30 ""create an ellipse with width 50 and height 30""
"
Class {
	#name : #BlEllipse,
	#superclass : #BlGeometry,
	#category : #'Bloc-Basic'
}

{ #category : #'instance creation' }
BlEllipse class >> diameter: aNumber [
	<return: #BlEllipse>

	^ self new diameter: aNumber
]

{ #category : #'instance creation' }
BlEllipse class >> extent: anExtent [
	<return: #BlEllipse>

	^ self new extent: anExtent
]

{ #category : #'instance creation' }
BlEllipse class >> radius: aNumber [
	<return: #BlEllipse>

	^ self diameter: aNumber * 2
]

{ #category : #'geometry testing' }
BlEllipse >> containsPoint: aPoint in: aBlElement [
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

{ #category : #accessing }
BlEllipse >> diameter: aNumber [
	extent := aNumber asPoint
]

{ #category : #geometry }
BlEllipse >> matchExtent: anExtent [
	self extent: anExtent
]

{ #category : #'visual bounds' }
BlEllipse >> strokedBoundsCentered: aBlBounds of: aBlElement on: aCanvas [ 
	<return: #BlBounds>

	^ (self geometryBounds: aBlBounds) expandBy: aBlElement border width / 2.0
]

{ #category : #'visual bounds' }
BlEllipse >> strokedBoundsOutside: aBlBounds of: aBlElement on: aCanvas [ 
	<return: #BlBounds>

	^ (self geometryBounds: aBlBounds) expandBy: aBlElement border width
]
