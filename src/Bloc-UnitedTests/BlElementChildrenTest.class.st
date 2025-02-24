"
I have been automatically converted and probably manually tweaked from BlElementChildrenExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlElementChildrenTest,
	#superclass : #TestCase,
	#category : #'Bloc-UnitedTests-Children'
}

{ #category : #tests }
BlElementChildrenTest >> hierarchyChildren [

	<sampleInstance>
	<demo>
	| aContainer current |
	aContainer := BlElement new
		              size: 400 @ 400;
		              background: Color veryVeryLightGray;
		              labeled: 'Container';
		              yourself.
	current := aContainer.
	1 to: 10 do: [ :i |
		| son |
		son := BlElement new
			       size: 10 - i * 40 asPoint;
			       position: 10 asPoint;
			       background: (Color h: i * 360 / 10 s: 1.0 v: 1.0);
			       labeled: 'shape_' , i asString;
			       yourself.
		current addChild: son.
		current := son ].

	^ aContainer
]

{ #category : #tests }
BlElementChildrenTest >> multipleChildren [

	<sampleInstance>
	<demo>
	| aContainer |
	aContainer := BlElement new
		              size: 400 @ 400;
		              background: Color veryVeryLightGray;
		              labeled: 'Container'.

	self multipleChildrenIn: aContainer depth: 1.

	^ aContainer
]

{ #category : #tests }
BlElementChildrenTest >> multipleChildrenDepth2 [

	<sampleInstance>
	<demo>
	^ self multipleChildrenDepth: 2
]

{ #category : #tests }
BlElementChildrenTest >> multipleChildrenDepth3 [

	<sampleInstance>
	<demo>
	^ self multipleChildrenDepth: 3
]

{ #category : #tests }
BlElementChildrenTest >> multipleChildrenDepth: aDepth [

	| aContainer |
	aContainer := self multipleChildren.
	aContainer childrenDo: [ :child | self multipleChildrenIn: child depth: aDepth - 1].
	^ aContainer
]

{ #category : #tests }
BlElementChildrenTest >> multipleChildrenIn: aContainer depth: aDepth [

	<sampleInstance>
	aDepth = 0 ifTrue: [ ^ self ].
	1 to: 10 do: [ :i |
		| son |
		son := BlElement new
			       size: 10 - i * 40 asPoint;
			       position: 10 asPoint;
			       background: (Color h: i * 360 / 10 s: 1.0 v: 1.0);
			       labeled: 'shape_' , i asString.
		aContainer addChild: son.
		self multipleChildrenIn: son depth: aDepth - 1 ].

	^ aContainer
]

{ #category : #tests }
BlElementChildrenTest >> overlappingChildren [

	<sampleInstance>
	<demo>
	| aContainer aRedChild aBlueChild |
	aContainer := BlElement new
		              size: 400 @ 400;
		              background: Color veryVeryLightGray;
		              labeled: 'Container'.
	aRedChild := BlElement new
		             size: 300 @ 150;
		             position: 50 @ 125;
		             background: (Color red alpha: 0.5);
		             labeled: 'Red'.
	aBlueChild := BlElement new
		              size: 150 @ 300;
		              position: 125 @ 50;
		              background: (Color blue alpha: 0.5);
		              labeled: 'Blue'.
	aContainer addChild: aRedChild as: #red.
	aContainer addChild: aBlueChild as: #blue.
	aContainer forceLayout.
	^ aContainer
]

{ #category : #tests }
BlElementChildrenTest >> testAllChildrenBreadthFirstWithDepthDo [

	| aContainer allChildren founds all |
	aContainer := self multipleChildrenDepth3.
	allChildren := aContainer children.
	self assert: allChildren size equals: 10.
	self assert:
		(allChildren allSatisfy: [ :each | each parent = aContainer ]).
	self
		assert: allChildren first
		equals: (aContainer childWithId: #shape_1).
	self
		assert: allChildren last
		equals: (aContainer childWithId: #shape_10).
		
	founds := Dictionary new.
	aContainer allChildrenBreadthFirstWithDepthDo: [ :child :depth |
		founds at: depth ifAbsentPut: [ OrderedCollection new ].
		(founds at: depth) add: child ].
	self assert: (founds at: 1) size equals: 10.
	self assert: (founds at: 2) size equals: 100.
	self assert: (founds at: 3) size equals: 1000.
	all := OrderedCollection new.
	founds valuesDo: [ :c | all addAll: c ].
	self assert: all asSet size equals: 1110.
	
]

{ #category : #tests }
BlElementChildrenTest >> testAllLeafChildrenAt100200 [

	| aContainer theChildren |
	aContainer := self overlappingChildren.
	theChildren := aContainer withAllLeafChildrenAt: 100 @ 200.
	self assert: theChildren equals: { (aContainer childWithId: #red) }.
	^ theChildren
]

{ #category : #tests }
BlElementChildrenTest >> testAllLeafChildrenAt200100 [

	| aContainer theChildren |
	aContainer := self overlappingChildren.
	theChildren := aContainer withAllLeafChildrenAt: 200 @ 100.
	self assert: theChildren equals: { (aContainer childWithId: #blue) }.
	^ theChildren
]

{ #category : #tests }
BlElementChildrenTest >> testAllLeafChildrenAt200200 [

	| aContainer theChildren |
	aContainer := self overlappingChildren.
	theChildren := aContainer withAllLeafChildrenAt: 200 @ 200.
	self assert: theChildren equals: {
			(aContainer childWithId: #blue).
			(aContainer childWithId: #red) }.
	^ theChildren
]

{ #category : #tests }
BlElementChildrenTest >> testAllLeafChildrenAt5050 [

	| aContainer theChildren |
	aContainer := self overlappingChildren.
	theChildren := aContainer withAllLeafChildrenAt: 50 @ 50.
	self assert: theChildren equals: { aContainer }.
	^ theChildren
]

{ #category : #tests }
BlElementChildrenTest >> testAllLeafChildrenAt600600 [

	| aContainer theChildren |
	aContainer := self overlappingChildren.
	theChildren := aContainer withAllLeafChildrenAt: 600 @ 600.
	self assert: theChildren equals: {  }.
	^ theChildren
]

{ #category : #tests }
BlElementChildrenTest >> testAllParentsDetectifFoundifNone1 [

	| aContainer aChild |
	aContainer := self hierarchyChildren.
	aChild := aContainer childWithId: #shape_10.

	aChild
		allParentsDetect: [ :parent | true ]
		ifFound: [ :parent | self assert: true ]
		ifNone: [ self assert: false ].
	aChild
		allParentsDetect: [ :parent | false ]
		ifFound: [ :parent | self assert: false ]
		ifNone: [ self assert: true ].

	aContainer
		allParentsDetect: [ :parent | true ]
		ifFound: [ :parent | self assert: false ]
		ifNone: [ self assert: true ]
]

{ #category : #tests }
BlElementChildrenTest >> testAllParentsDetectifFoundifNone2 [

	| aContainer aChild |
	aContainer := self hierarchyChildren.
	aChild := aContainer childWithId: #shape_10.

	aChild
		allParentsDetect: [ :parent | parent hasParent not ]
		ifFound: [ :parent | self assert: parent equals: aContainer ]
		ifNone: [ self assert: false ]
]

{ #category : #tests }
BlElementChildrenTest >> testAllParentsDo [

	| aContainer aChild res |
	aContainer := self hierarchyChildren.
	aChild := aContainer childWithId: #shape_10.
	res := OrderedCollection new.

	aChild allParentsDo: [ :parent | res add: parent ].
	self assert: res asArray equals: {
			(aContainer childWithId: #shape_9).
			(aContainer childWithId: #shape_8).
			(aContainer childWithId: #shape_7).
			(aContainer childWithId: #shape_6).
			(aContainer childWithId: #shape_5).
			(aContainer childWithId: #shape_4).
			(aContainer childWithId: #shape_3).
			(aContainer childWithId: #shape_2).
			(aContainer childWithId: #shape_1).
			aContainer }.

	res := OrderedCollection new.
	aContainer allParentsDo: [ :parent | res add: parent ].
	self assert: res asArray equals: {  }
]

{ #category : #tests }
BlElementChildrenTest >> testAllParentsReversedDo [

	| aContainer aChild all |
	aContainer := self hierarchyChildren.
	aChild := aContainer childWithId: #shape_10.
	all := Array streamContents: [ :stream |
		aChild allParentsReverseDo: [ :each |
			stream nextPut: each ] ].
	self
		assert: all
		equals: {
			aContainer.
			(aContainer childWithId: #shape_1).
			(aContainer childWithId: #shape_2).
			(aContainer childWithId: #shape_3).
			(aContainer childWithId: #shape_4).
			(aContainer childWithId: #shape_5).
			(aContainer childWithId: #shape_6).
			(aContainer childWithId: #shape_7).
			(aContainer childWithId: #shape_8).
			(aContainer childWithId: #shape_9) }
]

{ #category : #tests }
BlElementChildrenTest >> testAllParentsToDo [

	| aContainer res |
	aContainer := self hierarchyChildren.
	res := OrderedCollection new.

	(aContainer childWithId: #shape_10)
		allParentsTo: (aContainer childWithId: #shape_5)
		do: [ :parent | res add: parent ].
	self assert: res asArray equals: {
			(aContainer childWithId: #shape_9).
			(aContainer childWithId: #shape_8).
			(aContainer childWithId: #shape_7).
			(aContainer childWithId: #shape_6).
			(aContainer childWithId: #shape_5) }.

	res := OrderedCollection new.
	(aContainer childWithId: #shape_5)
		allParentsTo: (aContainer childWithId: #shape_10)
		do: [ :parent | res add: parent ].
	self assert: res asArray equals: {
			(aContainer childWithId: #shape_4).
			(aContainer childWithId: #shape_3).
			(aContainer childWithId: #shape_2).
			(aContainer childWithId: #shape_1).
			aContainer }
]

{ #category : #tests }
BlElementChildrenTest >> testChildAt [

	| aContainer |
	aContainer := self multipleChildren.
	self assert: (aContainer childAt: 1) id equals: #shape_1.
	self assert: (aContainer childAt: 5) id equals: #shape_5.
	self assert: (aContainer childAt: 10) id equals: #shape_10.

	[
	aContainer childAt: 11.
	self assert: false ] onErrorDo: [ :err |
		SubscriptOutOfBounds = err class
			ifTrue: [ self assert: true ]
			ifFalse: [ self assert: false ] ]
]

{ #category : #tests }
BlElementChildrenTest >> testChildIndexOf [

	| aContainer aNonChild |
	aContainer := self multipleChildren.
	aNonChild := BlElement new.
	self
		assert: (aContainer childIndexOf: (aContainer childWithId: #shape_1))
		equals: 1.
	self
		assert: (aContainer childIndexOf: (aContainer childWithId: #shape_5))
		equals: 5.
	self
		assert:
		(aContainer childIndexOf: (aContainer childWithId: #shape_10))
		equals: 10.
	self assert: (aContainer childIndexOf: aNonChild) equals: 0
]

{ #category : #tests }
BlElementChildrenTest >> testChildWithId [

	| aContainer aChild1 aChild2 |
	aContainer := self hierarchyChildren.
	aChild1 := aContainer childWithId: #shape_1.
	self assert: aChild1 parent equals: aContainer.
	self assert: aChild1 id equals: #shape_1.

	aChild2 := aContainer childWithId: #shape_2.
	self assert: aChild2 parent equals: aChild1.
	self assert: aChild2 id equals: #shape_2.

	aChild1 := aContainer childWithId: #shape_5.
	self assert: aChild1 id equals: #shape_5.

	aChild2 := aContainer childWithId: #shape_6.
	self assert: aChild2 parent equals: aChild1.
	self assert: aChild2 id equals: #shape_6.

	[
	aContainer childWithId: #idontexist.
	self assert: false ] onErrorDo: [ :err | self assert: true ]
]

{ #category : #tests }
BlElementChildrenTest >> testChildWithId1 [

	<sampleInstance>
	| aContainer aChild |
	aContainer := self multipleChildren.
	aChild := aContainer childWithId: #shape_1.
	self assert: aChild parent equals: aContainer.
	self assert: aChild id equals: #shape_1.

	aChild := aContainer childWithId: #shape_5.
	self assert: aChild parent equals: aContainer.
	self assert: aChild id equals: #shape_5.

	aChild := aContainer childWithId: #shape_10.
	self assert: aChild parent equals: aContainer.
	self assert: aChild id equals: #shape_10.

	[
	aContainer childWithId: #idontexist.
	self assert: false ] onErrorDo: [ :err | self assert: true ]
]

{ #category : #tests }
BlElementChildrenTest >> testChildWithId2 [

	<sampleInstance>
	| aContainer aChild1 aChild2 |
	aContainer := self hierarchyChildren.
	aChild1 := aContainer childWithId: #shape_1.
	self assert: aChild1 parent equals: aContainer.
	self assert: aChild1 id equals: #shape_1.

	aChild2 := aContainer childWithId: #shape_2.
	self assert: aChild2 parent equals: aChild1.
	self assert: aChild2 id equals: #shape_2.

	aChild1 := aContainer childWithId: #shape_5.
	self assert: aChild1 id equals: #shape_5.

	aChild2 := aContainer childWithId: #shape_6.
	self assert: aChild2 parent equals: aChild1.
	self assert: aChild2 id equals: #shape_6.

	[
	aContainer childWithId: #idontexist.
	self assert: false ] onErrorDo: [ :err | self assert: true ]
]

{ #category : #tests }
BlElementChildrenTest >> testChildWithIdIfFound1 [

	| aContainer |
	aContainer := self multipleChildren.
	aContainer
		childWithId: #shape_1
		ifFound: [ self assert: true ].
	aContainer
		childWithId: #shape_5
		ifFound: [ self assert: true ].
	aContainer
		childWithId: #shape_10
		ifFound: [ self assert: true ].
	aContainer
		childWithId: #shape_11
		ifFound: [ self assert: false ]
]

{ #category : #tests }
BlElementChildrenTest >> testChildWithIdIfFound2 [

	| aContainer |
	aContainer := self hierarchyChildren.
	aContainer
		childWithId: #shape_1
		ifFound: [ self assert: true ].
	aContainer
		childWithId: #shape_5
		ifFound: [ self assert: true ].
	aContainer
		childWithId: #shape_10
		ifFound: [ self assert: true ].
	aContainer
		childWithId: #shape_11
		ifFound: [ self assert: false ]
]

{ #category : #tests }
BlElementChildrenTest >> testChildWithIdIfFoundifNone1 [

	| aContainer |
	aContainer := self multipleChildren.
	aContainer
		childWithId: #shape_1
		ifFound: [ self assert: true ]
		ifNone: [ self assert: false ].
	aContainer
		childWithId: #shape_5
		ifFound: [ self assert: true ]
		ifNone: [ self assert: false ].
	aContainer
		childWithId: #shape_10
		ifFound: [ self assert: true ]
		ifNone: [ self assert: false ].
	aContainer
		childWithId: #shape_11
		ifFound: [ self assert: false ]
		ifNone: [ self assert: true ]
]

{ #category : #tests }
BlElementChildrenTest >> testChildWithIdIfFoundifNone2 [

	| aContainer |
	aContainer := self hierarchyChildren.
	aContainer
		childWithId: #shape_1
		ifFound: [ self assert: true ]
		ifNone: [ self assert: false ].
	aContainer
		childWithId: #shape_5
		ifFound: [ self assert: true ]
		ifNone: [ self assert: false ].
	aContainer
		childWithId: #shape_10
		ifFound: [ self assert: true ]
		ifNone: [ self assert: false ].
	aContainer
		childWithId: #shape_11
		ifFound: [ self assert: false ]
		ifNone: [ self assert: true ]
]

{ #category : #tests }
BlElementChildrenTest >> testChildWithIdifNone1 [

	| aContainer |
	aContainer := self multipleChildren.
	aContainer
		childWithId: #shape_1
		ifNone: [ self assert: false ].
	aContainer
		childWithId: #shape_5
		ifNone: [ self assert: false ].
	aContainer
		childWithId: #shape_10
		ifNone: [ self assert: false ].
	aContainer
		childWithId: #shape_11
		ifNone: [ self assert: true ]
]

{ #category : #tests }
BlElementChildrenTest >> testChildWithIdifNone2 [

	| aContainer |
	aContainer := self hierarchyChildren.
	aContainer
		childWithId: #shape_1
		ifNone: [ self assert: false ].
	aContainer
		childWithId: #shape_5
		ifNone: [ self assert: false ].
	aContainer
		childWithId: #shape_10
		ifNone: [ self assert: false ].
	aContainer
		childWithId: #shape_11
		ifNone: [ self assert: true ]
]

{ #category : #tests }
BlElementChildrenTest >> testChildren1 [

	| aContainer allChildren |
	aContainer := self multipleChildren.
	allChildren := aContainer children.
	self assert: allChildren size equals: 10.
	self assert:
		(allChildren allSatisfy: [ :each | each parent = aContainer ]).
	self
		assert: (allChildren at: 1)
		equals: (aContainer childWithId: #shape_1).
	self
		assert: (allChildren at: 5)
		equals: (aContainer childWithId: #shape_5).
	self
		assert: (allChildren at: 10)
		equals: (aContainer childWithId: #shape_10)
]

{ #category : #tests }
BlElementChildrenTest >> testChildren2 [

	| aContainer allChildren |
	aContainer := self hierarchyChildren.
	allChildren := aContainer children.
	self assert: allChildren size equals: 1.
	self assert:
		(allChildren allSatisfy: [ :each | each parent = aContainer ]).
	self
		assert: (allChildren at: 1)
		equals: (aContainer childWithId: #shape_1)
]

{ #category : #tests }
BlElementChildrenTest >> testChildrenCount1 [

	| aContainer |
	aContainer := self multipleChildren.
	self assert: aContainer childrenCount equals: 10
]

{ #category : #tests }
BlElementChildrenTest >> testChildrenCount2 [

	<sampleInstance>
	| aContainer |
	aContainer := self hierarchyChildren.
	self assert: aContainer childrenCount equals: 1
]

{ #category : #'children - accessing' }
BlElementChildrenTest >> testDirectChildWithIdifFoundifNone [

	| aContainer |
	aContainer := self hierarchyChildren.
	aContainer
		directChildWithId: #shape_1
		ifFound: [ self assert: true ]
		ifNone: [ self assert: false ].
	aContainer
		directChildWithId: #shape_2
		ifFound: [ self assert: false ]
		ifNone: [ self assert: true ].
	aContainer
		directChildWithId: #shape_10
		ifFound: [ self assert: false ]
		ifNone: [ self assert: true ]
]

{ #category : #tests }
BlElementChildrenTest >> testFirstChild [

	| aContainer anElementWithNoChild |
	aContainer := self multipleChildren.

	self assert: aContainer firstChild parent equals: aContainer.
	self assert: aContainer firstChild id equals: #shape_1.

	anElementWithNoChild := BlElement new.
	[
	anElementWithNoChild firstChild.
	self assert: false ] onErrorDo: [ :err | self assert: true ]
]

{ #category : #tests }
BlElementChildrenTest >> testFirstCommonParentifFoundifNone [

	| aContainer aChild1 aChild2 |
	aContainer := self hierarchyChildren.

	aChild1 := aContainer childWithId: #shape_1.
	aChild2 := aContainer childWithId: #shape_2.
	aChild1
		firstCommonParent: aChild2
		ifFound: [ :parent | self assert: parent equals: aChild1 ]
		ifNone: [ self assert: false ].
	aChild2
		firstCommonParent: aChild1
		ifFound: [ :parent | self assert: parent equals: aChild1 ]
		ifNone: [ self assert: false ].

	aChild1 := aContainer childWithId: #shape_1.
	aChild2 := aContainer childWithId: #shape_10.
	aChild1
		firstCommonParent: aChild2
		ifFound: [ :parent | self assert: parent equals: aChild1 ]
		ifNone: [ self assert: false ].
	aChild2
		firstCommonParent: aChild1
		ifFound: [ :parent | self assert: parent equals: aChild1 ]
		ifNone: [ self assert: false ].

	aChild1 := aContainer childWithId: #shape_1.
	aChild2 := BlElement new.
	aChild1
		firstCommonParent: aChild2
		ifFound: [ :parent | self assert: false ]
		ifNone: [ self assert: true ].
	aChild2
		firstCommonParent: aChild1
		ifFound: [ :parent | self assert: false ]
		ifNone: [ self assert: true ]
]

{ #category : #tests }
BlElementChildrenTest >> testHasChildren [

	| aContainer |
	self deny: (BlElement new) hasChildren.
	
	aContainer := self multipleChildren.
	self assert: aContainer hasChildren.
	
	aContainer := self hierarchyChildren.
	self assert: aContainer hasChildren.
]

{ #category : #tests }
BlElementChildrenTest >> testIsFirstChild [

	| aContainer aChild |
	aContainer := self multipleChildren.
	aChild := aContainer childWithId: #shape_1.
	self assert: aChild isFirstChild equals: true.

	aChild := aContainer childWithId: #shape_2.
	self assert: aChild isFirstChild equals: false.

	aChild := aContainer childWithId: #shape_9.
	self assert: aChild isFirstChild equals: false.

	aChild := aContainer childWithId: #shape_10.
	self assert: aChild isFirstChild equals: false.

	aChild := BlElement new.
	[
	aChild isFirstChild.
	self assert: false ] onErrorDo: [ self assert: true ]
]

{ #category : #tests }
BlElementChildrenTest >> testIsLastChild [

	| aContainer aChild |
	aContainer := self multipleChildren.
	aChild := aContainer childWithId: #shape_1.
	self assert: aChild isLastChild equals: false.

	aChild := aContainer childWithId: #shape_2.
	self assert: aChild isLastChild equals: false.

	aChild := aContainer childWithId: #shape_9.
	self assert: aChild isLastChild equals: false.

	aChild := aContainer childWithId: #shape_10.
	self assert: aChild isLastChild equals: true.

	aChild := BlElement new.
	[
	aChild isLastChild.
	self assert: false ] onErrorDo: [ self assert: true ]
]

{ #category : #tests }
BlElementChildrenTest >> testNextSiblingDo [

	| aContainer aChild |
	aContainer := self multipleChildren.
	aChild := aContainer childWithId: #shape_1.
	aChild nextSiblingDo: [ :next |
		self assert: next equals: (aContainer childWithId: #shape_2) ].
	aChild := aContainer childWithId: #shape_5.
	aChild nextSiblingDo: [ :next |
		self assert: next equals: (aContainer childWithId: #shape_6) ].
	aChild := aContainer childWithId: #shape_10.
	aChild nextSiblingDo: [ :next | self assert: false ]
]

{ #category : #tests }
BlElementChildrenTest >> testNextSiblingSuchThatdo [

	| aContainer aChild |
	aContainer := self multipleChildren.
	aChild := aContainer childWithId: #shape_1.
	aChild
		nextSiblingSuchThat: [ :next | next id = #shape_8 ]
		do: [ :next |
		self assert: next equals: (aContainer childWithId: #shape_8) ].
	aChild := aContainer childWithId: #shape_5.
	aChild
		nextSiblingSuchThat: [ :next | next id = #shape_8 ]
		do: [ :next |
		self assert: next equals: (aContainer childWithId: #shape_8) ].
	aChild := aContainer childWithId: #shape_5.
	aChild
		nextSiblingSuchThat: [ :next | next id = #shape_4 ]
		do: [ :next | self assert: false ].
	aChild := aContainer childWithId: #shape_10.
	aChild
		nextSiblingSuchThat: [ :next | next id = #shape_8 ]
		do: [ :next | self assert: false ]
]

{ #category : #tests }
BlElementChildrenTest >> testParent [

	| aContainer |
	aContainer := self multipleChildren.
	self
		assert: (aContainer childWithId: #shape_1) parent
		equals: aContainer.
	self
		assert: (aContainer childWithId: #shape_5) parent
		equals: aContainer.
	self
		assert: (aContainer childWithId: #shape_10) parent
		equals: aContainer.
	self assert: aContainer parent equals: nil
]

{ #category : #tests }
BlElementChildrenTest >> testParentDo [

	| aContainer aChild res |
	aContainer := self hierarchyChildren.
	aChild := aContainer childWithId: #shape_10.
	res := OrderedCollection new.

	aChild parentDo: [ :parent | res add: parent ].
	self
		assert: res asArray
		equals: { (aContainer childWithId: #shape_9) }.

	res := OrderedCollection new.
	aContainer parentDo: [ :parent | res add: parent ].
	self assert: res asArray equals: {  }
]

{ #category : #tests }
BlElementChildrenTest >> testPreviousSiblingDo [

	| aContainer aChild |
	aContainer := self multipleChildren.
	aChild := aContainer childWithId: #shape_1.
	aChild previousSiblingDo: [ :next | self assert: false ].
	aChild := aContainer childWithId: #shape_5.
	aChild previousSiblingDo: [ :next |
		self assert: next equals: (aContainer childWithId: #shape_4) ].
	aChild := aContainer childWithId: #shape_10.
	aChild previousSiblingDo: [ :next |
		self assert: next equals: (aContainer childWithId: #shape_9) ]
]

{ #category : #tests }
BlElementChildrenTest >> testPreviousSiblingSuchThatdo [

	| aContainer aChild |
	aContainer := self multipleChildren.
	aChild := aContainer childWithId: #shape_1.
	aChild
		previousSiblingSuchThat: [ :next | next id = #shape_8 ]
		do: [ :next | self assert: false ].
	aChild := aContainer childWithId: #shape_5.
	aChild
		previousSiblingSuchThat: [ :next | next id = #shape_8 ]
		do: [ :next | self assert: false ].
	aChild := aContainer childWithId: #shape_5.
	aChild
		previousSiblingSuchThat: [ :next | next id = #shape_4 ]
		do: [ :next |
		self assert: next equals: (aContainer childWithId: #shape_4) ].
	aChild := aContainer childWithId: #shape_10.
	aChild
		previousSiblingSuchThat: [ :next | next id = #shape_8 ]
		do: [ :next |
		self assert: next equals: (aContainer childWithId: #shape_8) ]
]

{ #category : #tests }
BlElementChildrenTest >> testSiblingsDo [

	| aContainer aChild found |
	aContainer := self multipleChildren.
	aChild := aContainer children first.
	found := OrderedCollection new.
	aChild siblingsDo: [ :next | found add: next ].
	self assert: found size equals: aContainer children size - 1.
	self assert: (found includes: aChild) not.
	aChild := aContainer childWithId: #shape_5.
	found := OrderedCollection new.
	aChild siblingsDo: [ :next | found add: next ].
	self assert: found size equals: aContainer children size - 1.
	self assert: (found includes: aChild) not.
	aChild := aContainer children last.
	found := OrderedCollection new.
	aChild siblingsDo: [ :next | found add: next ].
	self assert: found size equals: aContainer children size - 1.
	self assert: (found includes: aChild) not.
	

]

{ #category : #tests }
BlElementChildrenTest >> testTopMostParent [

	| aContainer aChild |
	aContainer := self hierarchyChildren.
	aChild := aContainer childWithId: #shape_10.
	self assert: aChild topMostParent equals: aContainer
]

{ #category : #tests }
BlElementChildrenTest >> testTopMostParentSuchThatifFoundifNone [

	| aContainer aChild |
	aContainer := self hierarchyChildren.
	aChild := aContainer childWithId: #shape_10.
	aChild
		topMostParentSuchThat: [ :cur | cur id = #shape_1 ]
		ifFound: [ :parent | self assert: parent parent equals: aContainer ]
		ifNone: [ self assert: false ].
	aContainer
		topMostParentSuchThat: [ :cur | cur id = #shape_1 ]
		ifFound: [ self assert: false ]
		ifNone: [ self assert: true ]
]

{ #category : #tests }
BlElementChildrenTest >> testWithAllParents [

	| aContainer aChild |
	aContainer := self hierarchyChildren.
	aChild := aContainer childWithId: #shape_10.
	self assert: aChild withAllParents equals: {
			(aContainer childWithId: #shape_10).
			(aContainer childWithId: #shape_9).
			(aContainer childWithId: #shape_8).
			(aContainer childWithId: #shape_7).
			(aContainer childWithId: #shape_6).
			(aContainer childWithId: #shape_5).
			(aContainer childWithId: #shape_4).
			(aContainer childWithId: #shape_3).
			(aContainer childWithId: #shape_2).
			(aContainer childWithId: #shape_1).
			aContainer }
]

{ #category : #tests }
BlElementChildrenTest >> testWithAllParentsDetectifFoundifNone [

	| aContainer aChild |
	aContainer := self hierarchyChildren.
	aChild := aContainer childWithId: #shape_10.

	aChild
		withAllParentsDetect: [ :parent | parent id = #shape_5 ]
		ifFound: [ :parent |
			self assert: parent equals: (aContainer childWithId: #shape_5) ]
		ifNone: [ self assert: false ].

	aChild
		withAllParentsDetect: [ :parent | true ]
		ifFound: [ :parent | self assert: parent equals: aChild ]
		ifNone: [ self assert: false ].

	aChild
		withAllParentsDetect: [ :parent | false ]
		ifFound: [ :parent | self assert: false ]
		ifNone: [ self assert: true ]
]

{ #category : #tests }
BlElementChildrenTest >> testWithAllParentsDo [

	| aContainer aChild res |
	aContainer := self hierarchyChildren.
	aChild := aContainer childWithId: #shape_10.
	res := OrderedCollection new.

	aChild withAllParentsDo: [ :parent | res add: parent ].
	self assert: res asArray equals: {
			(aContainer childWithId: #shape_10).
			(aContainer childWithId: #shape_9).
			(aContainer childWithId: #shape_8).
			(aContainer childWithId: #shape_7).
			(aContainer childWithId: #shape_6).
			(aContainer childWithId: #shape_5).
			(aContainer childWithId: #shape_4).
			(aContainer childWithId: #shape_3).
			(aContainer childWithId: #shape_2).
			(aContainer childWithId: #shape_1).
			aContainer }.

	res := OrderedCollection new.
	aContainer withAllParentsDo: [ :parent | res add: parent ].
	self assert: res asArray equals: { aContainer }
]

{ #category : #tests }
BlElementChildrenTest >> testWithAllParentsReversedDo [

	| aContainer aChild all |
	aContainer := self hierarchyChildren.
	aChild := aContainer childWithId: #shape_10.
	all := Array streamContents: [ :stream |
		aChild withAllParentsReverseDo: [ :each |
			stream nextPut: each ] ].
	self
		assert: all
		equals: {
			aContainer.
			(aContainer childWithId: #shape_1).
			(aContainer childWithId: #shape_2).
			(aContainer childWithId: #shape_3).
			(aContainer childWithId: #shape_4).
			(aContainer childWithId: #shape_5).
			(aContainer childWithId: #shape_6).
			(aContainer childWithId: #shape_7).
			(aContainer childWithId: #shape_8).
			(aContainer childWithId: #shape_9).
			(aContainer childWithId: #shape_10) }
]

{ #category : #tests }
BlElementChildrenTest >> testWithAllParentsUpToDo [

	| aContainer res |
	aContainer := self hierarchyChildren.
	res := OrderedCollection new.

	(aContainer childWithId: #shape_10)
		withAllParentsUpTo: (aContainer childWithId: #shape_5)
		do: [ :parent | res add: parent ].
	self assert: res asArray equals: {
			(aContainer childWithId: #shape_10).
			(aContainer childWithId: #shape_9).
			(aContainer childWithId: #shape_8).
			(aContainer childWithId: #shape_7).
			(aContainer childWithId: #shape_6) }.

	res := OrderedCollection new.
	(aContainer childWithId: #shape_5)
		withAllParentsUpTo: (aContainer childWithId: #shape_10)
		do: [ :parent | res add: parent ].
	self assert: res asArray equals: {
			(aContainer childWithId: #shape_5).
			(aContainer childWithId: #shape_4).
			(aContainer childWithId: #shape_3).
			(aContainer childWithId: #shape_2).
			(aContainer childWithId: #shape_1).
			aContainer }
]

{ #category : #tests }
BlElementChildrenTest >> testWithAllParentsUpTodetectifFoundIfNone [

	| aContainer res |
	aContainer := self hierarchyChildren.

	res := true.
	(aContainer childWithId: #shape_10)
		withAllParentsUpTo: (aContainer childWithId: #shape_5)
		detect: [ :parent | parent = (aContainer childWithId: #shape_7) ]
		ifFound: [ :parent | res := false ]
		ifNone: [ self assert: true ].
	self assert: res equals: false.

	res := true.
	(aContainer childWithId: #shape_10)
		withAllParentsUpTo: (aContainer childWithId: #shape_5)
		detect: [ :parent | true ]
		ifFound: [ :parent | res := false ]
		ifNone: [ self assert: true ].
	self assert: res equals: false.

	res := true.
	(aContainer childWithId: #shape_10)
		withAllParentsUpTo: (aContainer childWithId: #shape_5)
		detect: [ :parent | false ]
		ifFound: [ :parent | res := false ]
		ifNone: [ self assert: true ].
	self assert: res equals: true
]
