"
A BlLayoutTest is a test class for testing the behavior of BlLayout
"
Class {
	#name : #BlLayoutTest,
	#superclass : #TestCase,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #tests }
BlLayoutTest >> testEqualityAlbLineFlowLayout [

	self assert: AlbLineFlowLayout new equals: AlbLineFlowLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlBasicLayout [

	self assert: BlBasicLayout new equals: BlBasicLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlBasicNodeBasedLayout [

	self assert: BlBasicNodeBasedLayout new equals: BlBasicNodeBasedLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlCompositeLayout [

	self assert: BlCompositeLayout new equals: BlCompositeLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlFitChildrenLayout [

	self assert: BlFitChildrenLayout new equals: BlFitChildrenLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlFitLayout [

	self assert: BlFitLayout new equals: BlFitLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlFlowLayout [

	self assert: BlFlowLayout new equals: BlFlowLayout new.
	self assert: BlFlowLayout horizontal equals: BlFlowLayout horizontal.
	self assert: BlFlowLayout vertical equals: BlFlowLayout vertical.
	self deny: BlFlowLayout horizontal equals: BlFlowLayout vertical.
	
	self assert: BlFlowLayout new alignTopLeft equals: BlFlowLayout new alignTopLeft.
	self assert: BlFlowLayout new alignCenter equals: BlFlowLayout new alignCenter.
	self assert: BlFlowLayout new alignBottomRight equals: BlFlowLayout new alignBottomRight.
	self deny: BlFlowLayout new alignTopLeft equals: BlFlowLayout new alignCenterLeft.
	self deny: BlFlowLayout new alignTopLeft equals: BlFlowLayout new alignBottomLeft.
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlFrameLayout [

	self assert: BlFrameLayout new equals: BlFrameLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlGridLayout [

	self assert: BlGridLayout new equals: BlGridLayout new.
	
	self assert: (BlGridLayout new cellSpacing: 50) equals: (BlGridLayout new cellSpacing: 50).
	self deny: (BlGridLayout new cellSpacing: 50) equals: (BlGridLayout new cellSpacing: 100).
	
	self assert: (BlGridLayout new rowCount: 50) equals: (BlGridLayout new rowCount: 50).
	self deny: (BlGridLayout new rowCount: 50) equals: (BlGridLayout new rowCount: 100).
	
	self assert: (BlGridLayout new columnCount: 50) equals: (BlGridLayout new columnCount: 50).
	self deny: (BlGridLayout new columnCount: 50) equals: (BlGridLayout new columnCount: 100).
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlGridLayoutImpl [

	self assert: BlGridLayoutImpl new equals: BlGridLayoutImpl new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlIgnoredLayout [

	self assert: BlIgnoredLayout new equals: BlIgnoredLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlInfiniteBasicLayout [

	self assert: BlInfiniteBasicLayout new equals: BlInfiniteBasicLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlInfiniteLayout [

	self assert: BlInfiniteLayout new equals: BlInfiniteLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlInfiniteLinearLayout [

	self assert: BlInfiniteLinearLayout new equals: BlInfiniteLinearLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlLinearLayout [

	self assert: BlLinearLayout new equals: BlLinearLayout new.
	self assert: BlLinearLayout new equals: BlLinearLayout new.
	self assert: BlLinearLayout horizontal equals: BlLinearLayout horizontal.
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
		
	self assert: (BlLinearLayout new cellSpacing: 50) equals: (BlLinearLayout new cellSpacing: 50).
	self deny: (BlLinearLayout new cellSpacing: 50) equals: (BlLinearLayout new cellSpacing: 100).
	
	self assert: (BlLinearLayout new interspace: 50) equals: (BlLinearLayout new interspace: 50).
	self deny: (BlLinearLayout new interspace: 50) equals: (BlLinearLayout new interspace: 100).
	
	self assert: (BlLinearLayout new weightSum: 50) equals: (BlLinearLayout new weightSum: 50).
	self deny: (BlLinearLayout new weightSum: 50) equals: (BlLinearLayout new weightSum: 100).
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlNodeBasedLayout [

	self assert: BlNodeBasedLayout new equals: BlNodeBasedLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlOnceLayout [

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

	self assert: BlProportionalLayout new equals: BlProportionalLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlRelativeLayout [

	self assert: BlRelativeLayout new equals: BlRelativeLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlSquaredLayout [

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
		equals: (BlSquaredLayout on: BlLinearLayout vertical).
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlSvgGroupLayout [

	self assert: BlSvgGroupLayout new equals: BlSvgGroupLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlWrapAroundChildrenLayout [

	self assert: BlWrapAroundChildrenLayout new equals: BlWrapAroundChildrenLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityBlZoomableLayout [

	self assert: BlZoomableLayout new equals: BlZoomableLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityToBarFlowLayout [

	self assert: ToBarFlowLayout new equals: ToBarFlowLayout new
]

{ #category : #tests }
BlLayoutTest >> testEqualityToWindowElementLayout [

	self assert: ToWindowElementLayout new equals: ToWindowElementLayout new
]
