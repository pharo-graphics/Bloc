"
I am a rectangular geometry with support of rounded corners.

I can play a role of a square if both width and height are equal. In this case can be created using a predefined factory method:

	BlRectangle length: 20 ""creates a square with side length of 20""
	
In order to explicitely create a rectangle use extent:

	BlRectangle extent: 50@30 ""create a rectangle with width 50 and height 30""
"
Class {
	#name : #BlRoundedRectangleGeometry,
	#superclass : #BlElementVectorGeometry,
	#instVars : [
		'cornerRadii'
	],
	#category : #'Bloc-Basic-Geometry'
}

{ #category : #factory }
BlRoundedRectangleGeometry class >> cornerRadii: aBlCornerRadii [
	"Create a rounded rectangle with given corner radii"

	^ self basicNew
		initializeWith: aBlCornerRadii;
		yourself
]

{ #category : #factory }
BlRoundedRectangleGeometry class >> cornerRadius: aNumber [
	"Change the radii of all corners to a given number.
	aNumber must not be nil.
	aNumber must be non-negative"
	<return: #BlRoundedRectangleGeometry>

	self
		assert: [ aNumber >= 0 ]
		description: [ 'Corner radius must be non-negative!' ].

	^ self basicNew
		initializeWith: (BlCornerRadii radius: aNumber);
		yourself
]

{ #category : #factory }
BlRoundedRectangleGeometry class >> new [

	^ self basicNew
		  initializeWith: BlCornerRadii empty;
		  yourself
]

{ #category : #'geometry testing' }
BlRoundedRectangleGeometry >> containsPoint: aPoint in: aBlElement [
	"Answer whether aPoint is in the rounded rectangle."

	| w h isBottomSide isRightSide center radius maxRadius |
	w := self extent x.
	h := self extent y.
	maxRadius := self cornerRadii max.
	"check if aPoint is in the rectangle minus the corner radius"
	(aPoint x > maxRadius and: [ aPoint x <= (w - maxRadius) ])
		ifTrue: [ ^ true ].
	(aPoint y > maxRadius and: [ aPoint y <= (h - maxRadius) ])
		ifTrue: [ ^ true ].
	"check if aPoint is in the corner triangles"
	isRightSide := aPoint x > (w / 2).
	isBottomSide := aPoint y > (h / 2).
	"top left circle"
	(isRightSide not and: isBottomSide not)
		ifTrue: [ center := self cornerRadii topLeft asPoint.
			radius := self cornerRadii topLeft ].
	"top right circle"
	(isRightSide and: isBottomSide not)
		ifTrue: [ center := w @ 0 + (self cornerRadii topRight negated @ self cornerRadii topRight).
			radius := self cornerRadii topRight ].
	"bottom right circle"
	(isRightSide and: isBottomSide)
		ifTrue: [ center := (w@h)- self cornerRadii bottomRight asPoint.
			radius := self cornerRadii bottomRight ].
	"bottom left circle"
	(isRightSide not and: isBottomSide)
		ifTrue: [ center := 0 @ h + (self cornerRadii bottomLeft @ self cornerRadii bottomLeft negated).
			radius := self cornerRadii bottomLeft ].
	"check if it is in the defined circle"
	^ (aPoint x - center x) squared + (aPoint y - center y) squared <= radius squared
]

{ #category : #accessing }
BlRoundedRectangleGeometry >> cornerRadii [
	<return: #BlCornerRadii>

	^ cornerRadii
]

{ #category : #testing }
BlRoundedRectangleGeometry >> hasCaps [

	^ false
]

{ #category : #testing }
BlRoundedRectangleGeometry >> hasJoins [

	^ false
]

{ #category : #initialization }
BlRoundedRectangleGeometry >> initializeWith: aCornerRadii [

	self initialize.
	
	cornerRadii := aCornerRadii
]

{ #category : #geometry }
BlRoundedRectangleGeometry >> matchExtent: aPoint [
	extent := aPoint
]
