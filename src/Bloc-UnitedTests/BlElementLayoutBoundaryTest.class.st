Class {
	#name : #BlElementLayoutBoundaryTest,
	#superclass : #BlSpaceTestCase,
	#category : #'Bloc-UnitedTests-Layout'
}

{ #category : #tests }
BlElementLayoutBoundaryTest >> testExactLayoutBoundary [

	| aContainer aLayoutBoundary aChild |
	space extent: 500 @ 400.
	aContainer := BlElement new extent: 400 @ 300.
	aLayoutBoundary := BlElement new extent: 300 @ 200.
	aChild :=
		BlElement new
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			yourself.

	self assert: aLayoutBoundary isLayoutBoundary.
	self assert: aChild isLayoutBoundary.

	aLayoutBoundary addChild: aChild as: #child.
	aContainer addChild: aLayoutBoundary as: #boundary.
	space deferAndSettle: [ space root addChild: aContainer as: #container ].

	self assert: space root extent equals: 500 @ 400.
	self assert: (space root childWithId: #container) extent equals: 400 @ 300.
	self assert: (space root childWithId: #boundary) extent equals: 300 @ 200.
	self assert: (space root childWithId: #child) extent equals: 300 @ 200.
	self deny: space isLayoutRequested.
	self assert: space elementsNeedingLayout isEmpty
]

{ #category : #tests }
BlElementLayoutBoundaryTest >> testExactLayoutBoundaryRequestLayoutChild [

	| aContainer aLayoutBoundary aChild |
	space extent: 500 @ 400.
	aContainer := BlElement new extent: 400 @ 300.
	aLayoutBoundary := BlElement new extent: 300 @ 200.
	aChild :=
		BlElement new
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			yourself.

	aLayoutBoundary addChild: aChild as: #child.
	aContainer addChild: aLayoutBoundary as: #boundary.
	space deferAndSettle: [ space root addChild: aContainer as: #container ].

	aChild requestLayout.
	self assert: space isLayoutRequested.
	self assert: space elementsNeedingLayout equals: { aLayoutBoundary } asSet.

	space settle.
	self deny: space isLayoutRequested.
	self assert: space elementsNeedingLayout isEmpty
]
