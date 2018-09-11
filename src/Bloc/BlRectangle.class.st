"
I am a rectangular geometry with support of rounded corners.

I can play a role of a square if both width and height are equal. In this case can be created using a predefined factory method:

	BlRectangle length: 20 ""creates a square with side length of 20""
	
In order to explicitely create a rectangle use extent:

	BlRectangle extent: 50@30 ""create a rectangle with width 50 and height 30""
"
Class {
	#name : #BlRectangle,
	#superclass : #BlGeometry,
	#instVars : [
		'cornerRadii'
	],
	#category : 'Bloc-Basic'
}

{ #category : #factory }
BlRectangle class >> cornerRadius: aNumber [
	"Change the radii of all corners to a given number.
	aNumber must not be nil.
	aNumber must be non-negative"
	<return: #BlRectangle>

	self
		assert: [ aNumber >= 0 ]
		description: [ 'Corner radius must be non-negative!' ].

	^ self basicNew
		initialize;
		initializeWith: (BlCornerRadii radius: aNumber)
]

{ #category : #factory }
BlRectangle class >> new [
	^ self basicNew
		initialize;
		initializeWith: BlCornerRadii empty
]

{ #category : #'geometry testing' }
BlRectangle >> containsPoint: aPoint in: aBlElement [
	"check if aPoint is in the basic rectangle"
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

{ #category : #'geometry testing' }
BlRectangle >> containsPoint: aPoint within: aBounds [
	"check if aPoint is in the basic rectangle"
	| w h isBottomSide isRightSide center radius maxRadius |
	
	w := aBounds extent x.
	h := aBounds extent y.
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
BlRectangle >> cornerRadii [
	<return: #BlCornerRadii>

	^ cornerRadii
]

{ #category : #initialization }
BlRectangle >> initializeWith: theCornerRadii [

	self
		assert: [ cornerRadii isNil ]
		description: [ 'I am immutable, please create a new rectangle instead' ].
		
	self
		assert: [ theCornerRadii isNotNil ]
		description: [ 'Corner radius must not be nil' ].

	cornerRadii := theCornerRadii
]

{ #category : #geometry }
BlRectangle >> matchExtent: aPoint [
	extent := aPoint
]

{ #category : #'visual bounds' }
BlRectangle >> strokedBoundsCentered: aBlBounds of: aBlElement on: aCanvas [ 
	<return: #BlBounds>

	^ (self geometryBounds: aBlBounds) expandBy: aBlElement border width / 2.0
]

{ #category : #'visual bounds' }
BlRectangle >> strokedBoundsOutside: aBlBounds of: aBlElement on: aCanvas [ 
	<return: #BlBounds>

	^ (self geometryBounds: aBlBounds) expandBy: aBlElement border width
]
