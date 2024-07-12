"
A BlLayoutTest is a test class for testing the behavior of BlLayout
"
Class {
	#name : #BlLayoutTest,
	#superclass : #TestCase,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #tests }
BlLayoutTest >> testEqualityBlBasicLayout [

	self assert: BlBasicLayout new equals: BlBasicLayout new.
	
	self assert: BlBasicLayout new hash equals: BlBasicLayout new hash
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlBasicNodeBasedLayout [

	self
		assert: BlBasicNodeBasedLayout new
		equals: BlBasicNodeBasedLayout new.
	
	self assert: BlBasicNodeBasedLayout new hash equals: BlBasicNodeBasedLayout new hash
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlCompositeLayout [

	self assert: BlCompositeLayout new equals: BlCompositeLayout new.
	
	self assert: BlCompositeLayout new hash equals: BlCompositeLayout new hash
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlFitChildrenLayout [

	self assert: BlFitChildrenLayout new equals: BlFitChildrenLayout new.
	
	self assert: BlFitChildrenLayout new hash equals: BlFitChildrenLayout new hash
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlFitLayout [

	self assert: BlFitLayout new equals: BlFitLayout new.
	
	self assert: BlFitLayout new hash equals: BlFitLayout new hash
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlFlowLayout [

	self assert: BlFlowLayout new equals: BlFlowLayout new.
	
	self assert: BlFlowLayout new hash equals: BlFlowLayout new hash.
	
	self assert: BlFlowLayout horizontal equals: BlFlowLayout horizontal.
	self assert: BlFlowLayout vertical equals: BlFlowLayout vertical.
	self deny: BlFlowLayout horizontal equals: BlFlowLayout vertical.

	self
		assert: BlFlowLayout new alignTopLeft
		equals: BlFlowLayout new alignTopLeft.
	self
		assert: BlFlowLayout new alignCenter
		equals: BlFlowLayout new alignCenter.
	self
		assert: BlFlowLayout new alignBottomRight
		equals: BlFlowLayout new alignBottomRight.
	self
		deny: BlFlowLayout new alignTopLeft
		equals: BlFlowLayout new alignCenterLeft.
	self
		deny: BlFlowLayout new alignTopLeft
		equals: BlFlowLayout new alignBottomLeft
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlFrameLayout [

	self assert: BlFrameLayout new equals: BlFrameLayout new.
	
	self assert: BlFrameLayout new hash equals: BlFrameLayout new hash.
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlGridLayout [

	self assert: BlGridLayout new equals: BlGridLayout new.
	
	self assert: BlGridLayout new hash equals: BlGridLayout new hash.

	self
		assert: (BlGridLayout new cellSpacing: 50)
		equals: (BlGridLayout new cellSpacing: 50).
	self
		deny: (BlGridLayout new cellSpacing: 50)
		equals: (BlGridLayout new cellSpacing: 100).

	self
		assert: BlGridLayout new alignBounds
		equals: BlGridLayout new alignBounds.
	self
		assert: BlGridLayout new alignMargins
		equals: BlGridLayout new alignMargins.
	self
		deny: BlGridLayout new alignBounds
		equals: BlGridLayout new alignMargins
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlIgnoredLayout [

	self assert: BlIgnoredLayout new equals: BlIgnoredLayout new.
	
	self assert: BlIgnoredLayout new hash equals: BlIgnoredLayout new hash.

]

{ #category : #tests }
BlLayoutTest >> testEqualityBlLinearLayout [

	self assert: BlLinearLayout new hash equals: BlLinearLayout new hash.
	
	self assert: BlLinearLayout new equals: BlLinearLayout new.
	self
		assert: BlLinearLayout horizontal
		equals: BlLinearLayout horizontal.
	self assert: BlLinearLayout vertical equals: BlLinearLayout vertical.
	self deny: BlLinearLayout horizontal equals: BlLinearLayout vertical.

	self
		assert: BlLinearLayout new alignTopLeft
		equals: BlLinearLayout new alignTopLeft.
	self
		assert: BlLinearLayout new alignCenter
		equals: BlLinearLayout new alignCenter.
	self
		assert: BlLinearLayout new alignBottomRight
		equals: BlLinearLayout new alignBottomRight.
	self
		deny: BlLinearLayout new alignTopLeft
		equals: BlLinearLayout new alignCenterLeft.
	self
		deny: BlLinearLayout new alignTopLeft
		equals: BlLinearLayout new alignBottomLeft.

	self
		assert: (BlLinearLayout new cellSpacing: 50)
		equals: (BlLinearLayout new cellSpacing: 50).
	self
		deny: (BlLinearLayout new cellSpacing: 50)
		equals: (BlLinearLayout new cellSpacing: 100).

	self
		assert: (BlLinearLayout new interspace: 50)
		equals: (BlLinearLayout new interspace: 50).
	self
		deny: (BlLinearLayout new interspace: 50)
		equals: (BlLinearLayout new interspace: 100).

	self
		assert: (BlLinearLayout new weightSum: 50)
		equals: (BlLinearLayout new weightSum: 50).
	self
		deny: (BlLinearLayout new weightSum: 50)
		equals: (BlLinearLayout new weightSum: 100)
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlNodeBasedLayout [

	self assert: BlNodeBasedLayout new equals: BlNodeBasedLayout new.
	self assert: BlNodeBasedLayout new hash equals: BlNodeBasedLayout new hash.
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlOnceLayout [

	self assert: BlOnceLayout new hash equals: BlOnceLayout new hash.
	self assert: BlOnceLayout new equals: BlOnceLayout new.
	self
		assert: (BlOnceLayout on: BlFrameLayout new)
		equals: (BlOnceLayout on: BlFrameLayout new).
	self
		assert: (BlOnceLayout on: BlLinearLayout horizontal)
		equals: (BlOnceLayout on: BlLinearLayout horizontal).
	self
		deny: (BlOnceLayout on: BlLinearLayout horizontal)
		equals: (BlOnceLayout on: BlLinearLayout vertical).
	self
		deny: (BlOnceLayout on: BlFrameLayout new)
		equals: (BlOnceLayout on: BlLinearLayout vertical).

	self
		assert: (BlOnceLayout new isStopped: true)
		equals: (BlOnceLayout new isStopped: true).
	self
		assert: (BlOnceLayout new isStopped: false)
		equals: (BlOnceLayout new isStopped: false).
	self
		deny: (BlOnceLayout new isStopped: true)
		equals: (BlOnceLayout new isStopped: false)
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlProportionalLayout [

	self assert: BlProportionalLayout new hash equals: BlProportionalLayout new hash.
	self
		assert: BlProportionalLayout new
		equals: BlProportionalLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlRelativeLayout [

	self assert: BlRelativeLayout new hash equals: BlRelativeLayout new hash.
	self assert: BlRelativeLayout new equals: BlRelativeLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlSquaredLayout [

	self assert: BlSquaredLayout new hash equals: BlSquaredLayout new hash.
	self assert: BlSquaredLayout new equals: BlSquaredLayout new.
	self
		assert: BlSquaredLayout new beTight
		equals: BlSquaredLayout new beTight.
	self
		assert: BlSquaredLayout new beLoose
		equals: BlSquaredLayout new beLoose.
	self
		deny: BlSquaredLayout new beTight
		equals: BlSquaredLayout new beLoose.
	self
		assert: (BlSquaredLayout on: BlFrameLayout new)
		equals: (BlSquaredLayout on: BlFrameLayout new).
	self
		assert: (BlSquaredLayout on: BlLinearLayout horizontal)
		equals: (BlSquaredLayout on: BlLinearLayout horizontal).
	self
		deny: (BlSquaredLayout on: BlLinearLayout horizontal)
		equals: (BlSquaredLayout on: BlLinearLayout vertical).
	self
		deny: (BlSquaredLayout on: BlFrameLayout new)
		equals: (BlSquaredLayout on: BlLinearLayout vertical)
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlSvgGroupLayout [

	self assert: BlSvgGroupLayout new equals: BlSvgGroupLayout new.
	self assert: BlSvgGroupLayout new hash equals: BlSvgGroupLayout new hash.
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlWrapAroundChildrenLayout [

	self
		assert: BlWrapAroundChildrenLayout new
		equals: BlWrapAroundChildrenLayout new.
		self assert: BlWrapAroundChildrenLayout new hash equals: BlWrapAroundChildrenLayout new hash.
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlZoomableLayout [

	self assert: BlZoomableLayout new equals: BlZoomableLayout new.
	self assert: BlZoomableLayout new hash equals: BlZoomableLayout new hash.

	self
		assert: (BlZoomableLayout new animationDuration: 1 asSeconds)
		equals: (BlZoomableLayout new animationDuration: 1 asSeconds).
	self
		deny: (BlZoomableLayout new animationDuration: 1 asSeconds)
		equals: (BlZoomableLayout new animationDuration: 2 asSeconds).

	self
		assert: (BlZoomableLayout new defaultScale: 2.5)
		equals: (BlZoomableLayout new defaultScale: 2.5).
	self
		deny: (BlZoomableLayout new defaultScale: 1.5)
		equals: (BlZoomableLayout new defaultScale: 2.5)
]
