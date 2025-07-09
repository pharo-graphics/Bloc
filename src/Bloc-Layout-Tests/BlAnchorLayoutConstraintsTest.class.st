"
A BlAnchorLayoutTest is a test class for testing the behavior of BlAnchorLayout
"
Class {
	#name : #BlAnchorLayoutConstraintsTest,
	#superclass : #BlParameterizedHostTest,
	#instVars : [
		'parent',
		'space',
		'child'
	],
	#category : #'Bloc-Layout-Tests'
}

{ #category : #running }
BlAnchorLayoutConstraintsTest >> setUp [ 

	super setUp.
	space := self newTestingSpace. 
	parent := BlElement new. 
	parent constraintsDo: [:c | c horizontal matchParent. c vertical matchParent ].
	parent layout: BlAnchorLayout new.
	space root addChild: parent.
	child := BlElement new.
	parent addChild: child
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testActionAnchor [
	" return the height of a rectangle or create a rectangle with a particular height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child extent: 100 @ 120.

	anchor := child actionAnchor: [ :v :e | e position ].
	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 10 @ 20.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 10 @ 20.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 110 @ 140)
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testBottomAnchor [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 0 @ 0.
	child extent: 100 @ 120.

	anchor := BlElementBottomAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 120.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (0 @ -110 corner: 100 @ 10)
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testBottomLeftAnchor [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 110 @ 20.
	child extent: 100 @ 120.

	anchor := BlElementBottomLeftAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0 @ 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 110 @ 140.
	" the result is the element bounds with an height of 10"
	self
		assert: (anchor
				 appliedOnRectangle: child bounds asRectangle
				 withValue: 10 @ 20)
		equals: (-100 @ -120 corner: 0 @ 0)
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testBottomRightAnchor [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 110 @ 20.
	child extent: 100 @ 120.

	anchor := BlElementBottomRightAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0 @ 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 210 @ 140.
	" the result is the element bounds with an height of 10"
	self
		assert: (anchor
				 appliedOnRectangle: child bounds asRectangle
				 withValue: 10 @ 20)
		equals: (-200 @ -120 corner: -100 @ 0)
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testExtentAnchor [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 110 @ 20.
	child extent: 100 @ 120.

	anchor := BlElementExtentAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0 @ 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 100 @ 120.
	" the result is the element bounds with an height of 10"
	self
		assert: (anchor
				 appliedOnRectangle: child bounds asRectangle
				 withValue: 10 @ 20)
		equals: (110 @ 20 corner: 120 @ 40)
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testHeightAnchor [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child extent: 100 @ 120.

	anchor := BlElementHeightAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 120.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 110 @ 30)
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testHorizontalCenterAnchor [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child extent: 100 @ 120.

	anchor := BlElementHorizontalCenterAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 60.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (-40 @ 20 corner: 60.0 @ 140.0)
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testLeftAnchor [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child extent: 100 @ 120.

	anchor := BlElementLeftAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 10.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (0 @ 20 corner: 100 @ 140)
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testNeutralAnchor [
	" return the height of a rectangle or create a rectangle with a particular height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child extent: 100 @ 120.

	anchor := child neutralAnchor: 0.
	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 0.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 110 @ 140)
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testNilAnchor [
	" return the height of a rectangle or create a rectangle with a particular height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child extent: 100 @ 120.

	anchor := child nilAnchor.
	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: nil.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: nil.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 110 @ 140)
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testRightAnchor [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 110 @ 20.
	child extent: 100 @ 120.

	anchor := BlElementRightAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 210.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (-200 @ 20 corner: -100 @ 140)
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testTopAnchor [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child extent: 100 @ 120.

	anchor := BlElementTopAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 20.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ -10 corner: 110 @ 110)
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testTopLeftAnchor [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 110 @ 20.
	child extent: 100 @ 120.

	anchor := BlElementTopLeftAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0 @ 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 110 @ 20.
	" the result is the element bounds with an height of 10"
	self
		assert: (anchor
				 appliedOnRectangle: child bounds asRectangle
				 withValue: 10 @ 20)
		equals: (-100 @ 0 corner: 0 @ 120)
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testTopRightAnchor [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 110 @ 20.
	child extent: 100 @ 120.

	anchor := BlElementTopRightAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0 @ 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 210 @ 20.
	" the result is the element bounds with an height of 10"
	self
		assert: (anchor
				 appliedOnRectangle: child bounds asRectangle
				 withValue: 10 @ 20)
		equals: (-200 @ 0 corner: -100 @ 120)
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testVerticalCenterAnchor [
	" return the height of a rectangle or create a rectangle with a height according to element margin "

	| anchor |
	child position: 10 @ 20.
	child extent: 100 @ 120.

	anchor := BlElementVerticalCenterAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 80.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ -50 corner: 110 @ 70)
]

{ #category : #tests }
BlAnchorLayoutConstraintsTest >> testWidthAnchor [
	" return the width of a rectangle or create a rectangle with a particular width according to element margin "

	| anchor |
	child position: 10 @ 20.
	child extent: 100 @ 120.

	anchor := BlElementWidthAnchor new
		          element: child;
		          yourself.

	self waitTestingSpaces.

	self
		assert:
		(anchor valueInBounds:
			 (Rectangle origin: 0 asPoint corner: 0 asPoint))
		equals: 0.
	self
		assert: (anchor valueInBounds: child bounds asRectangle)
		equals: 100.
	" the result is the element bounds with an height of 10"
	self
		assert:
		(anchor appliedOnRectangle: child bounds asRectangle withValue: 10)
		equals: (10 @ 20 corner: 20 @ 140)
]
