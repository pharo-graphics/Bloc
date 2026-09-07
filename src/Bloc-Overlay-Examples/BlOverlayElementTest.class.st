Class {
	#name : #BlOverlayElementTest,
	#superclass : #BlSpaceTestCase,
	#category : #'Bloc-Overlay-Examples'
}

{ #category : #tests }
BlOverlayElementTest >> testOverlayOnParent [

	| aContainer anOverlay |
	aContainer :=
		BlElement new
			extent: 500 @ 400;
			border: (BlBorder builder dashed; paint: Color gray; width: 2; build);
			yourself.

	anOverlay := BlOverlayElement on: aContainer.
	anOverlay background: (Color gray alpha: 0.2).
	aContainer addChild: anOverlay as: #overlay.

	space deferAndSettle: [ space root addChild: aContainer ].

	self assert: aContainer extent equals: 500 @ 400.
	self assert: aContainer position equals: 0 @ 0.
	self assert: (aContainer childWithId: #overlay) extent equals: 500 @ 400.
	self assert: (aContainer childWithId: #overlay) position equals: 0 @ 0
]

{ #category : #tests }
BlOverlayElementTest >> testOverlayOnParentWithOffset [

	| aContainer anOverlay |
	aContainer :=
		BlElement new
			position: 50 @ 100;
			extent: 500 @ 400;
			border: (BlBorder builder dashed; paint: Color gray; width: 2; build);
			yourself.

	anOverlay := BlOverlayElement on: aContainer.
	anOverlay background: (Color gray alpha: 0.2).
	aContainer addChild: anOverlay as: #overlay.

	space deferAndSettle: [ space root addChild: aContainer ].

	self assert: aContainer extent equals: 500 @ 400.
	self assert: aContainer position equals: 50 @ 100.
	self assert: (aContainer childWithId: #overlay) extent equals: 500 @ 400.
	self assert: (aContainer childWithId: #overlay) position equals: 0 @ 0
]

{ #category : #tests }
BlOverlayElementTest >> testOverlayOnSibling [

	| aContainer aSibling anOverlay |
	aContainer :=
		BlElement new
			extent: 500 @ 400;
			border: (BlBorder builder dashed; paint: Color gray; width: 2; build);
			yourself.

	aSibling :=
		BlElement new
			extent: 300 @ 200;
			border: (BlBorder paint: Color gray width: 2);
			addEventHandler: BlPullHandler new;
			yourself.

	anOverlay := BlOverlayElement on: aSibling.
	anOverlay background: (Color gray alpha: 0.2).

	aContainer addChild: aSibling as: #sibling.
	aContainer addChild: anOverlay as: #overlay.

	space deferAndSettle: [ space root addChild: aContainer ].

	self assert: aContainer extent equals: 500 @ 400.
	self assert: aContainer position equals: 0 @ 0.
	self assert: (aContainer childWithId: #overlay) extent equals: 300 @ 200.
	self assert: (aContainer childWithId: #overlay) position equals: 0 @ 0
]

{ #category : #tests }
BlOverlayElementTest >> testOverlayOnSiblingWithOffset [

	| aContainer aSibling anOverlay |
	aContainer :=
		BlElement new
			position: 10 @ 20;
			extent: 500 @ 400;
			border: (BlBorder builder dashed; paint: Color gray; width: 2; build);
			yourself.

	aSibling :=
		BlElement new
			position: 30 @ 40;
			extent: 300 @ 200;
			border: (BlBorder paint: Color gray width: 2);
			addEventHandler: BlPullHandler new;
			yourself.

	anOverlay := BlOverlayElement on: aSibling.
	anOverlay background: (Color gray alpha: 0.2).

	aContainer addChild: aSibling as: #sibling.
	aContainer addChild: anOverlay as: #overlay.

	space deferAndSettle: [ space root addChild: aContainer ].

	self assert: aContainer extent equals: 500 @ 400.
	self assert: aContainer position equals: 10 @ 20.
	self assert: (aContainer childWithId: #overlay) extent equals: 300 @ 200.
	self assert: (aContainer childWithId: #overlay) position equals: 30 @ 40
]
