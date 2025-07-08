Class {
	#name : #BlFocusFinderExamples,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-FocusFinder-Examples'
}

{ #category : #'instance creation' }
BlFocusFinderExamples >> cell [

	^ BlElement new
		  extent: 50 @ 30;
		  background: Color random muchLighter darker;
		  addEventHandlerOn: BlFocusEvent do: [ :anEvent |
			  anEvent currentTarget border:
					  (BlBorder paint: Color blue width: 2) ];
		  addEventHandlerOn: BlBlurEvent do: [ :anEvent |
			  anEvent currentTarget border:
					  (BlBorder paint: Color gray width: 1) ];
		  addEventHandlerOn: BlClickEvent do: [ :anEvent |
			  anEvent consume.
			  anEvent currentTarget requestFocus ];
		yourself
]

{ #category : #'instance creation' }
BlFocusFinderExamples >> container [
	<gtExample>
	| container children |
	
	children := { {30. 2. 455}. {489}. { 489 }. {26. 2. 18. 2. 437} } collect: [ :eachSegment |
		| grid gridChildren |
		gridChildren := eachSegment collect: [ :eachExtent |
			self cell
				extent: eachExtent @ (eachSegment size = 1 ifTrue: [ 25 ] ifFalse: [ 30 ]);
				background: Color veryVeryLightGray;
				margin: (BlInsets all: 2);
				border: (BlBorder paint: Color gray width: 1) ].

		grid := BlElement new.
		grid layout: BlFlowLayout new.
		grid focusability: BlFocusability after.
		grid constraintsDo: [ :c | 
			c horizontal exact: 506.
			c vertical fitContent ].
		grid addChildren: gridChildren.
		grid ].

	container := BlElement new.
	container layout: BlLinearLayout vertical.
	container constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	
	container addChildren: children.
	container forceLayout.
	
	container addEventHandler: BlFocusExampleNavigationListener new.
	
	^ container
]

{ #category : #'examples - segment 4' }
BlFocusFinderExamples >> focusFinderDownOnContainer [
	<gtExample>
	| aFocusFinder aContainer |
	
	aContainer := self container.
	
	aFocusFinder := BlFocusFinder new
		down;
		root: aContainer;
		referenceElement: aContainer children last children third.

	^ aFocusFinder
]

{ #category : #'examples - segment 2' }
BlFocusFinderExamples >> focusFinderDownOnSegment_2_at_190x30 [
	<gtExample>
	| aFocusFinder aContainer aNextFocus |
	
	aContainer := self segmentWithCells_2.
	
	aFocusFinder := BlFocusFinder new
		down;
		root: aContainer;
		referenceArea: (190@30 corner: 190@30).

	aNextFocus := aFocusFinder
		nextFocusDo: #yourself
		ifNone: [ nil ].

	self
		assert: aNextFocus
		equals: (aContainer children at: 73).

	^ aFocusFinder
]

{ #category : #'examples - segment 2' }
BlFocusFinderExamples >> focusFinderDownOnSegment_2_child_41 [
	<gtExample>
	| aFocusFinder aContainer aNextFocus |
	
	aContainer := self segmentWithCells_2.
	
	aFocusFinder := BlFocusFinder new
		down;
		root: aContainer;
		referenceElement: (aContainer children at: 41).

	aNextFocus := aFocusFinder
		nextFocusDo: #yourself
		ifNone: [ nil ].

	self
		assert: aNextFocus
		equals: (aContainer children at: 73).

	^ aFocusFinder
]

{ #category : #'examples - segment 3' }
BlFocusFinderExamples >> focusFinderDownOnSegment_3_at_285x50 [
	<gtExample>
	| aFocusFinder aContainer aNextFocus |
	
	aContainer := self segmentWithCells_3.
	
	aFocusFinder := BlFocusFinder new
		up;
		root: aContainer;
		referenceArea: (285@50 corner: 285@50).

	aNextFocus := aFocusFinder
		nextFocusDo: #yourself
		ifNone: [ nil ].

	self
		assert: aNextFocus
		equals: (aContainer children at: 39).

	^ aFocusFinder
]

{ #category : #'examples - segment 3' }
BlFocusFinderExamples >> focusFinderDownOnSegment_3_child_57 [
	<gtExample>
	| aFocusFinder aContainer aNextFocus |
	
	aContainer := self segmentWithCells_3.
	
	aFocusFinder := BlFocusFinder new
		up;
		root: aContainer;
		referenceElement: (aContainer children at: 57).

	aNextFocus := aFocusFinder
		nextFocusDo: #yourself
		ifNone: [ nil ].

	self
		assert: aNextFocus
		equals: (aContainer children at: 39).

	^ aFocusFinder
]

{ #category : #'examples - segment 4' }
BlFocusFinderExamples >> focusFinderLeftOnContainer [
	<gtExample>
	| aFocusFinder aContainer |
	
	aContainer := self container.
	
	aFocusFinder := BlFocusFinder new
		left;
		root: aContainer;
		referenceElement: aContainer children last children third.

	^ aFocusFinder
]

{ #category : #'examples - segment 4' }
BlFocusFinderExamples >> focusFinderRightOnContainer [
	<gtExample>
	| aFocusFinder aContainer |
	
	aContainer := self container.
	
	aFocusFinder := BlFocusFinder new
		right;
		root: aContainer;
		referenceElement: aContainer children last children third.

	^ aFocusFinder
]

{ #category : #'examples - segment 4' }
BlFocusFinderExamples >> focusFinderUpOnContainer [
	<gtExample>
	| aFocusFinder aContainer |
	
	aContainer := self container.
	
	aFocusFinder := BlFocusFinder new
		up;
		root: aContainer;
		referenceElement: aContainer children last children third.

	^ aFocusFinder
]

{ #category : #'examples - segment 4' }
BlFocusFinderExamples >> focusFinderUpOnContainerFromBounds [
	<gtExample>
	| aFocusFinder aContainer |
	
	aContainer := self container.
	
	aFocusFinder := BlFocusFinder new
		up;
		root: aContainer;
		referenceArea: (170@100 corner: 200@120).

	^ aFocusFinder
]

{ #category : #'examples - segment 4' }
BlFocusFinderExamples >> focusFinderUpOnSegment_4_at_100x100 [
	<gtExample>
	| aContainer aFocusFinder aNextFocus |
	
	aContainer := self container.
	aFocusFinder := BlFocusFinder new
		up;
		root: aContainer;
		referenceArea: (100@100 extent: 10@10).
	
	aNextFocus := aFocusFinder
		nextFocusDo: #yourself
		ifNone: [ nil ].

	self
		assert: aNextFocus
		equals: (aContainer children third children first).

	^ aFocusFinder
]

{ #category : #'examples - segment 4' }
BlFocusFinderExamples >> focusFinderUpOnSegment_4_at_20x100 [
	<gtExample>
	| aContainer aFocusFinder aNextFocus |
	
	aContainer := self container.
	aFocusFinder := BlFocusFinder new
		up;
		root: aContainer;
		referenceArea: (20@100 extent: 10@10).
	
	aNextFocus := aFocusFinder
		nextFocusDo: #yourself
		ifNone: [ nil ].

	self
		assert: aNextFocus
		equals: (aContainer children third children first).

	^ aFocusFinder
]

{ #category : #'examples - segment 4' }
BlFocusFinderExamples >> focusFinderUpOnSegment_4_at_minus10x100 [
	<gtExample>
	| aContainer aFocusFinder aNextFocus |
	
	aContainer := self container.
	aFocusFinder := BlFocusFinder new
		up;
		root: aContainer;
		referenceArea: (-10@100 extent: 10@10).
	
	aNextFocus := aFocusFinder
		nextFocusDo: #yourself
		ifNone: [ nil ].

	self
		assert: aNextFocus
		equals: (aContainer children third children first).

	^ aFocusFinder
]

{ #category : #'examples - segment 1' }
BlFocusFinderExamples >> focusFinderUpOnSegmentsAt_0x60 [
	<gtExample>
	| aFocusFinder aContainer aNextFocus |
	
	aContainer := self segmentWithCells.
	
	aFocusFinder := BlFocusFinder new
		up;
		root: aContainer;
		referenceArea: (0@60 corner: 0@60).

	aNextFocus := aFocusFinder
		nextFocusDo: #yourself
		ifNone: [ nil ].

	self
		assert: aNextFocus
		equals: (aContainer children at: 27).

	^ aFocusFinder
]

{ #category : #'examples - segment 1' }
BlFocusFinderExamples >> focusFinderUpOnSegmentsAt_minus10x60 [
	<gtExample>
	| aFocusFinder aContainer aNextFocus |
	
	aContainer := self segmentWithCells.
	
	aFocusFinder := BlFocusFinder new
		up;
		root: aContainer;
		referenceArea: (-10@60 corner: 0@60).
		
	aNextFocus := aFocusFinder
		nextFocusDo: #yourself
		ifNone: [ nil ].

	self
		assert: aNextFocus
		equals: (aContainer children at: 27).

	^ aFocusFinder
]

{ #category : #'examples - segment 4' }
BlFocusFinderExamples >> focusedElementAbove_90 [
	<gtExample>
	| aContainer |
	
	aContainer := self container.
	
	0 to: 500 do: [ :eachX |
		| aFocusFinder aFocusedElement |
		aFocusFinder := BlFocusFinder new.
		aFocusedElement := aFocusFinder
			up;
			root: aContainer;
			referenceArea: (eachX @ 90 extent: 0@0);
			nextFocusDo: #yourself ifNone: [ nil ].

		self assert: aFocusedElement == aContainer children third children first 	].

	^ aContainer
]

{ #category : #'examples - segment 1' }
BlFocusFinderExamples >> segmentWithCells [
	<gtExample>
	| container children |
	
	children := { (0.0@0.0) corner: (64.38600158691406@17.59783935546875). (64.38600158691406@0.0) corner: (67.18600153923035@17.59783935546875). (67.18600153923035@0.0) corner: (108.54200053215027@17.59783935546875). (108.54200053215027@0.0) corner: (111.34200048446655@17.59783935546875). (111.34200048446655@0.0) corner: (144.77399969100952@17.59783935546875). (144.77399969100952@0.0) corner: (147.5739996433258@17.59783935546875). (147.5739996433258@0.0) corner: (154.62999987602234@17.59783935546875). (154.62999987602234@0.0) corner: (157.42999982833862@17.59783935546875). (157.42999982833862@0.0) corner: (243.29199934005737@17.59783935546875). (243.29199934005737@0.0) corner: (246.09199929237366@17.59783935546875). (246.09199929237366@0.0) corner: (270.74599862098694@17.59783935546875). (270.74599862098694@0.0) corner: (337.0@17.59783935546875). (0.0@17.59783935546875) corner: (68.19400024414063@35.1956787109375). (68.19400024414063@17.59783935546875) corner: (70.99400019645691@35.1956787109375). (70.99400019645691@17.59783935546875) corner: (86.2400004863739@35.1956787109375). (86.2400004863739@17.59783935546875) corner: (89.04000043869019@35.1956787109375). (89.04000043869019@17.59783935546875) corner: (173.08199262619019@35.1956787109375). (173.08199262619019@17.59783935546875) corner: (175.88199257850647@35.1956787109375). (175.88199257850647@17.59783935546875) corner: (193.8299925327301@35.1956787109375). (193.8299925327301@17.59783935546875) corner: (196.6299924850464@35.1956787109375). (196.6299924850464@17.59783935546875) corner: (217.20999240875244@35.1956787109375). (217.20999240875244@17.59783935546875) corner: (220.00999236106873@35.1956787109375). (220.00999236106873@17.59783935546875) corner: (228.18599200248718@35.1956787109375). (228.18599200248718@17.59783935546875) corner: (230.98599195480347@35.1956787109375). (230.98599195480347@17.59783935546875) corner: (286.8319926261902@35.1956787109375). (286.8319926261902@17.59783935546875) corner: (337.0@35.1956787109375). (0.0@35.1956787109375) corner: (81.54999542236328@52.79351806640625). (81.54999542236328@35.1956787109375) corner: (84.34999537467957@52.79351806640625). (84.34999537467957@35.1956787109375) corner: (102.2979953289032@52.79351806640625). (102.2979953289032@35.1956787109375) corner: (105.09799528121948@52.79351806640625). (105.09799528121948@35.1956787109375) corner: (134.59599447250366@52.79351806640625). (134.59599447250366@35.1956787109375) corner: (137.39599442481995@52.79351806640625). (137.39599442481995@35.1956787109375) corner: (156.68799424171448@52.79351806640625). (156.68799424171448@35.1956787109375) corner: (159.48799419403076@52.79351806640625). (159.48799419403076@35.1956787109375) corner: (235.11599254608154@52.79351806640625). (235.11599254608154@35.1956787109375) corner: (237.91599249839783@52.79351806640625). (237.91599249839783@35.1956787109375) corner: (250.23599219322205@52.79351806640625). (250.23599219322205@35.1956787109375) corner: (253.03599214553833@52.79351806640625). (253.03599214553833@35.1956787109375) corner: (265.2999920845032@52.79351806640625). (265.2999920845032@35.1956787109375) corner: (268.09999203681946@52.79351806640625). (268.09999203681946@35.1956787109375) corner: (287.391991853714@52.79351806640625). (287.391991853714@35.1956787109375) corner: (290.1919918060303@52.79351806640625). (290.1919918060303@35.1956787109375) corner: (337.0@52.79351806640625). (0.0@52.79351806640625) corner: (2.799999952316284@70.391357421875). (2.799999952316284@52.79351806640625) corner: (14.475999593734741@70.391357421875). (14.475999593734741@52.79351806640625) corner: (17.275999546051025@70.391357421875). (17.275999546051025@52.79351806640625) corner: (36.56799936294556@70.391357421875). (36.56799936294556@52.79351806640625) corner: (39.36799931526184@70.391357421875). (39.36799931526184@52.79351806640625) corner: (82.41799855232239@70.391357421875). (82.41799855232239@52.79351806640625) corner: (85.21799850463867@70.391357421875). (85.21799850463867@52.79351806640625) corner: (126.77000045776367@70.391357421875). (126.77000045776367@52.79351806640625) corner: (129.57000041007996@70.391357421875). (129.57000041007996@52.79351806640625) corner: (152.05400156974792@70.391357421875). (152.05400156974792@52.79351806640625) corner: (154.8540015220642@70.391357421875). (154.8540015220642@52.79351806640625) corner: (187.12400197982788@70.391357421875). (187.12400197982788@52.79351806640625) corner: (189.92400193214417@70.391357421875). (189.92400193214417@52.79351806640625) corner: (198.10000157356262@70.391357421875). (198.10000157356262@52.79351806640625) corner: (200.9000015258789@70.391357421875). (200.9000015258789@52.79351806640625) corner: (229.06800079345703@70.391357421875). (229.06800079345703@52.79351806640625) corner: (231.86800074577332@70.391357421875). (231.86800074577332@52.79351806640625) corner: (255.3320014476776@70.391357421875). (255.3320014476776@52.79351806640625) corner: (258.1320013999939@70.391357421875). (258.1320013999939@52.79351806640625) corner: (275.1280016899109@70.391357421875). (275.1280016899109@52.79351806640625) corner: (277.9280016422272@70.391357421875). (277.9280016422272@52.79351806640625) corner: (307.42600083351135@70.391357421875). (307.42600083351135@52.79351806640625) corner: (310.22600078582764@70.391357421875). (310.22600078582764@52.79351806640625) corner: (322.54600048065186@70.391357421875). (322.54600048065186@52.79351806640625) corner: (337.0@70.391357421875). (0.0@70.391357421875) corner: (30.534000396728516@87.98919677734375). (30.534000396728516@70.391357421875) corner: (33.3340003490448@87.98919677734375). (33.3340003490448@70.391357421875) corner: (41.50999999046326@87.98919677734375). (41.50999999046326@70.391357421875) corner: (44.30999994277954@87.98919677734375). (44.30999994277954@70.391357421875) corner: (111.62200403213501@87.98919677734375). (111.62200403213501@70.391357421875) corner: (114.4220039844513@87.98919677734375). (114.4220039844513@70.391357421875) corner: (138.85200428962708@87.98919677734375). (138.85200428962708@70.391357421875) corner: (141.65200424194336@87.98919677734375). (141.65200424194336@70.391357421875) corner: (184.36600494384766@87.98919677734375). (184.36600494384766@70.391357421875) corner: (187.16600489616394@87.98919677734375). (187.16600489616394@70.391357421875) corner: (196.47600531578064@87.98919677734375). (196.47600531578064@70.391357421875) corner: (199.27600526809692@87.98919677734375). (199.27600526809692@70.391357421875) corner: (337.0@87.98919677734375) } collect: [ :eachBounds |
			self cell
				extent: eachBounds extent;
				position: eachBounds origin;
				background: (Color veryVeryLightGray);
				margin: (BlInsets all: 0);
				border: (BlBorder paint: Color lightGray width: 1);
				yourself ].

	container := BlElement new.
	container layout: BlFitLayout new.
	container constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	
	container addChildren: children.
	container forceLayout.
	container addEventHandler: BlFocusExampleNavigationListener new.
	
	^ container
]

{ #category : #'examples - segment 2' }
BlFocusFinderExamples >> segmentWithCells_2 [

	<gtExample>
	| container children |
	children := {
		            (0.0 @ 0.0 corner: 64.38600158691406 @ 17.59783935546875).
		            (64.38600158691406 @ 0.0 corner:
			             67.18600153923035 @ 17.59783935546875).
		            (67.18600153923035 @ 0.0 corner:
			             108.54200053215027 @ 17.59783935546875).
		            (108.54200053215027 @ 0.0 corner:
			             111.34200048446655 @ 17.59783935546875).
		            (111.34200048446655 @ 0.0 corner:
			             131.8800024986267 @ 17.59783935546875).
		            (131.8800024986267 @ 0.0 corner:
			             134.680002450943 @ 17.59783935546875).
		            (134.680002450943 @ 0.0 corner:
			             159.8100016117096 @ 17.59783935546875).
		            (159.8100016117096 @ 0.0 corner:
			             162.61000156402588 @ 17.59783935546875).
		            (162.61000156402588 @ 0.0 corner:
			             208.47399997711182 @ 17.59783935546875).
		            (208.47399997711182 @ 0.0 corner:
			             211.2739999294281 @ 17.59783935546875).
		            (211.2739999294281 @ 0.0 corner:
			             233.75800108909607 @ 17.59783935546875).
		            (233.75800108909607 @ 0.0 corner:
			             236.55800104141235 @ 17.59783935546875).
		            (236.55800104141235 @ 0.0 corner:
			             268.2820019721985 @ 17.59783935546875).
		            (268.2820019721985 @ 0.0 corner:
			             271.08200192451477 @ 17.59783935546875).
		            (271.08200192451477 @ 0.0 corner:
			             299.7680027484894 @ 17.59783935546875).
		            (299.7680027484894 @ 0.0 corner:
			             302.56800270080566 @ 17.59783935546875).
		            (302.56800270080566 @ 0.0 corner:
			             356.608003616333 @ 17.59783935546875).
		            (356.608003616333 @ 0.0 corner:
			             359.4080035686493 @ 17.59783935546875).
		            (359.4080035686493 @ 0.0 corner:
			             377.6220042705536 @ 17.59783935546875).
		            (377.6220042705536 @ 0.0 corner:
			             380.4220042228699 @ 17.59783935546875).
		            (380.4220042228699 @ 0.0 corner:
			             399.7140040397644 @ 17.59783935546875).
		            (399.7140040397644 @ 0.0 corner:
			             402.5140039920807 @ 17.59783935546875).
		            (402.5140039920807 @ 0.0 corner:
			             458.6820070743561 @ 17.59783935546875).
		            (458.6820070743561 @ 0.0 corner:
			             461.48200702667236 @ 17.59783935546875).
		            (461.48200702667236 @ 0.0 corner:
			             470.79200744628906 @ 17.59783935546875).
		            (470.79200744628906 @ 0.0 corner:
			             484.5 @ 17.59783935546875).
		            (0.0 @ 17.59783935546875 corner:
			             19.97800064086914 @ 35.1956787109375).
		            (19.97800064086914 @ 17.59783935546875 corner:
			             22.778000593185425 @ 35.1956787109375).
		            (22.778000593185425 @ 17.59783935546875 corner:
			             38.02400088310242 @ 35.1956787109375).
		            (38.02400088310242 @ 17.59783935546875 corner:
			             40.8240008354187 @ 35.1956787109375).
		            (40.8240008354187 @ 17.59783935546875 corner:
			             60.11600065231323 @ 35.1956787109375).
		            (60.11600065231323 @ 17.59783935546875 corner:
			             62.91600060462952 @ 35.1956787109375).
		            (62.91600060462952 @ 17.59783935546875 corner:
			             114.50600075721741 @ 35.1956787109375).
		            (114.50600075721741 @ 17.59783935546875 corner:
			             117.30600070953369 @ 35.1956787109375).
		            (117.30600070953369 @ 17.59783935546875 corner:
			             137.39600086212158 @ 35.1956787109375).
		            (137.39600086212158 @ 17.59783935546875 corner:
			             140.19600081443787 @ 35.1956787109375).
		            (140.19600081443787 @ 17.59783935546875 corner:
			             155.44200110435486 @ 35.1956787109375).
		            (155.44200110435486 @ 17.59783935546875 corner:
			             158.24200105667114 @ 35.1956787109375).
		            (158.24200105667114 @ 17.59783935546875 corner:
			             177.53400087356567 @ 35.1956787109375).
		            (177.53400087356567 @ 17.59783935546875 corner:
			             180.33400082588196 @ 35.1956787109375).
		            (180.33400082588196 @ 17.59783935546875 corner:
			             203.98000073432922 @ 35.1956787109375).
		            (203.98000073432922 @ 17.59783935546875 corner:
			             206.7800006866455 @ 35.1956787109375).
		            (206.7800006866455 @ 17.59783935546875 corner:
			             228.5220012664795 @ 35.1956787109375).
		            (228.5220012664795 @ 17.59783935546875 corner:
			             231.32200121879578 @ 35.1956787109375).
		            (231.32200121879578 @ 17.59783935546875 corner:
			             295.45600390434265 @ 35.1956787109375).
		            (295.45600390434265 @ 17.59783935546875 corner:
			             298.25600385665894 @ 35.1956787109375).
		            (298.25600385665894 @ 17.59783935546875 corner:
			             352.92600202560425 @ 35.1956787109375).
		            (352.92600202560425 @ 17.59783935546875 corner:
			             355.72600197792053 @ 35.1956787109375).
		            (355.72600197792053 @ 17.59783935546875 corner:
			             384.1600019931793 @ 35.1956787109375).
		            (384.1600019931793 @ 17.59783935546875 corner:
			             386.9600019454956 @ 35.1956787109375).
		            (386.9600019454956 @ 17.59783935546875 corner:
			             394.01600217819214 @ 35.1956787109375).
		            (394.01600217819214 @ 17.59783935546875 corner:
			             396.8160021305084 @ 35.1956787109375).
		            (396.8160021305084 @ 17.59783935546875 corner:
			             422.4920027256012 @ 35.1956787109375).
		            (422.4920027256012 @ 17.59783935546875 corner:
			             425.2920026779175 @ 35.1956787109375).
		            (425.2920026779175 @ 17.59783935546875 corner:
			             467.83800411224365 @ 35.1956787109375).
		            (467.83800411224365 @ 17.59783935546875 corner:
			             470.63800406455994 @ 35.1956787109375).
		            (470.63800406455994 @ 17.59783935546875 corner:
			             484.5 @ 35.1956787109375).
		            (0.0 @ 35.1956787109375 corner:
			             2.799999952316284 @ 52.79351806640625).
		            (2.799999952316284 @ 35.1956787109375 corner:
			             22.553999662399292 @ 52.79351806640625).
		            (22.553999662399292 @ 35.1956787109375 corner:
			             25.353999614715576 @ 52.79351806640625).
		            (25.353999614715576 @ 35.1956787109375 corner:
			             50.610000133514404 @ 52.79351806640625).
		            (50.610000133514404 @ 35.1956787109375 corner:
			             53.41000008583069 @ 52.79351806640625).
		            (53.41000008583069 @ 35.1956787109375 corner:
			             75.06800103187561 @ 52.79351806640625).
		            (75.06800103187561 @ 35.1956787109375 corner:
			             77.8680009841919 @ 52.79351806640625).
		            (77.8680009841919 @ 35.1956787109375 corner:
			             108.76599979400635 @ 52.79351806640625).
		            (108.76599979400635 @ 35.1956787109375 corner:
			             111.56599974632263 @ 52.79351806640625).
		            (111.56599974632263 @ 35.1956787109375 corner:
			             131.65599989891052 @ 52.79351806640625).
		            (131.65599989891052 @ 35.1956787109375 corner:
			             134.4559998512268 @ 52.79351806640625).
		            (134.4559998512268 @ 35.1956787109375 corner:
			             149.81399965286255 @ 52.79351806640625).
		            (149.81399965286255 @ 35.1956787109375 corner:
			             152.61399960517883 @ 52.79351806640625).
		            (152.61399960517883 @ 35.1956787109375 corner:
			             172.59200024604797 @ 52.79351806640625).
		            (172.59200024604797 @ 35.1956787109375 corner:
			             175.39200019836426 @ 52.79351806640625).
		            (175.39200019836426 @ 35.1956787109375 corner:
			             201.3479995727539 @ 52.79351806640625).
		            (201.3479995727539 @ 35.1956787109375 corner:
			             204.1479995250702 @ 52.79351806640625).
		            (204.1479995250702 @ 35.1956787109375 corner:
			             238.72800135612488 @ 52.79351806640625).
		            (238.72800135612488 @ 35.1956787109375 corner:
			             241.52800130844116 @ 52.79351806640625).
		            (241.52800130844116 @ 35.1956787109375 corner:
			             266.61600065231323 @ 52.79351806640625).
		            (266.61600065231323 @ 35.1956787109375 corner:
			             269.4160006046295 @ 52.79351806640625).
		            (269.4160006046295 @ 35.1956787109375 corner:
			             295.26000237464905 @ 52.79351806640625).
		            (295.26000237464905 @ 35.1956787109375 corner:
			             298.06000232696533 @ 52.79351806640625).
		            (298.06000232696533 @ 35.1956787109375 corner:
			             309.72200202941895 @ 52.79351806640625).
		            (309.72200202941895 @ 35.1956787109375 corner:
			             312.52200198173523 @ 52.79351806640625).
		            (312.52200198173523 @ 35.1956787109375 corner:
			             335.5660026073456 @ 52.79351806640625).
		            (335.5660026073456 @ 35.1956787109375 corner:
			             338.36600255966187 @ 52.79351806640625).
		            (338.36600255966187 @ 35.1956787109375 corner:
			             381.08000326156616 @ 52.79351806640625).
		            (381.08000326156616 @ 35.1956787109375 corner:
			             383.88000321388245 @ 52.79351806640625).
		            (383.88000321388245 @ 35.1956787109375 corner:
			             409.724004983902 @ 52.79351806640625).
		            (409.724004983902 @ 35.1956787109375 corner:
			             412.52400493621826 @ 52.79351806640625).
		            (412.52400493621826 @ 35.1956787109375 corner:
			             429.49200534820557 @ 52.79351806640625).
		            (429.49200534820557 @ 35.1956787109375 corner:
			             432.29200530052185 @ 52.79351806640625).
		            (432.29200530052185 @ 35.1956787109375 corner:
			             461.4960057735443 @ 52.79351806640625).
		            (461.4960057735443 @ 35.1956787109375 corner:
			             484.5 @ 52.79351806640625).
		            (0.0 @ 52.79351806640625 corner:
			             24.639999389648438 @ 70.391357421875).
		            (24.639999389648438 @ 52.79351806640625 corner:
			             27.43999934196472 @ 70.391357421875).
		            (27.43999934196472 @ 52.79351806640625 corner:
			             39.75999903678894 @ 70.391357421875).
		            (39.75999903678894 @ 52.79351806640625 corner:
			             42.559998989105225 @ 70.391357421875).
		            (42.559998989105225 @ 52.79351806640625 corner:
			             69.03399801254272 @ 70.391357421875).
		            (69.03399801254272 @ 52.79351806640625 corner:
			             71.83399796485901 @ 70.391357421875).
		            (71.83399796485901 @ 52.79351806640625 corner:
			             99.97399735450745 @ 70.391357421875).
		            (99.97399735450745 @ 52.79351806640625 corner:
			             102.77399730682373 @ 70.391357421875).
		            (102.77399730682373 @ 52.79351806640625 corner:
			             128.00199794769287 @ 70.391357421875).
		            (128.00199794769287 @ 52.79351806640625 corner:
			             130.80199790000916 @ 70.391357421875).
		            (133.80199790000916 @ 51.79351806640625 corner:
			             188.0019986629486 @ 72.87738037109375).
		            (188.0019986629486 @ 51.79351806640625 corner:
			             258.8020017147064 @ 72.87738037109375).
		            (258.8020017147064 @ 51.79351806640625 corner:
			             285.2020013332367 @ 72.87738037109375).
		            (288.2020013332367 @ 52.79351806640625 corner:
			             291.68800139427185 @ 70.391357421875).
		            (291.68800139427185 @ 52.79351806640625 corner:
			             484.5 @ 70.391357421875) } collect: [ :eachBounds |
		            self cell
			            extent: eachBounds extent;
			            position: eachBounds origin;
			            background: Color veryVeryLightGray;
			            margin: (BlInsets all: 0);
			            border: (BlBorder paint: Color lightGray width: 1) ].

	container := BlElement new.
	container layout: BlFitLayout new.
	container constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].

	container addChildren: children.
	container forceLayout.
	container addEventHandler: BlFocusExampleNavigationListener new.

	^ container
]

{ #category : #'examples - segment 3' }
BlFocusFinderExamples >> segmentWithCells_3 [

	<gtExample>
	| container children |
	children := {
		            (0.0 @ 0.0 corner: 64.38600158691406 @ 17.59783935546875).
		            (64.38600158691406 @ 0.0 corner:
			             67.18600153923035 @ 17.59783935546875).
		            (67.18600153923035 @ 0.0 corner:
			             108.54200053215027 @ 17.59783935546875).
		            (108.54200053215027 @ 0.0 corner:
			             111.34200048446655 @ 17.59783935546875).
		            (111.34200048446655 @ 0.0 corner:
			             120.65200090408325 @ 17.59783935546875).
		            (120.65200090408325 @ 0.0 corner:
			             123.45200085639954 @ 17.59783935546875).
		            (123.45200085639954 @ 0.0 corner:
			             156.82800030708313 @ 17.59783935546875).
		            (156.82800030708313 @ 0.0 corner:
			             159.6280002593994 @ 17.59783935546875).
		            (159.6280002593994 @ 0.0 corner:
			             179.56400108337402 @ 17.59783935546875).
		            (179.56400108337402 @ 0.0 corner:
			             182.3640010356903 @ 17.59783935546875).
		            (182.3640010356903 @ 0.0 corner:
			             194.04000067710876 @ 17.59783935546875).
		            (194.04000067710876 @ 0.0 corner:
			             196.84000062942505 @ 17.59783935546875).
		            (199.84000062942505 @ -1.0 corner:
			             222.04000043869019 @ 20.0838623046875).
		            (225.04000043869019 @ 0.0 corner:
			             227.84000039100647 @ 17.59783935546875).
		            (227.84000039100647 @ 0.0 corner:
			             275.3559992313385 @ 17.59783935546875).
		            (275.3559992313385 @ 0.0 corner:
			             278.1559991836548 @ 17.59783935546875).
		            (278.1559991836548 @ 0.0 corner:
			             296.3699998855591 @ 17.59783935546875).
		            (296.3699998855591 @ 0.0 corner:
			             299.16999983787537 @ 17.59783935546875).
		            (299.16999983787537 @ 0.0 corner:
			             372.3900010585785 @ 17.59783935546875).
		            (372.3900010585785 @ 0.0 corner:
			             375.1900010108948 @ 17.59783935546875).
		            (375.1900010108948 @ 0.0 corner:
			             452.46999979019165 @ 17.59783935546875).
		            (452.46999979019165 @ 0.0 corner:
			             455.26999974250793 @ 17.59783935546875).
		            (455.26999974250793 @ 0.0 corner:
			             477.33400082588196 @ 17.59783935546875).
		            (477.33400082588196 @ 0.0 corner:
			             482.09765625 @ 17.59783935546875).
		            (0.0 @ 20.0838623046875 corner:
			             41.74800109863281 @ 37.68170166015625).
		            (41.74800109863281 @ 20.0838623046875 corner:
			             44.5480010509491 @ 37.68170166015625).
		            (44.5480010509491 @ 20.0838623046875 corner:
			             80.44400095939636 @ 37.68170166015625).
		            (80.44400095939636 @ 20.0838623046875 corner:
			             83.24400091171265 @ 37.68170166015625).
		            (83.24400091171265 @ 20.0838623046875 corner:
			             134.02200078964233 @ 37.68170166015625).
		            (134.02200078964233 @ 20.0838623046875 corner:
			             136.82200074195862 @ 37.68170166015625).
		            (136.82200074195862 @ 20.0838623046875 corner:
			             151.53600144386292 @ 37.68170166015625).
		            (151.53600144386292 @ 20.0838623046875 corner:
			             154.3360013961792 @ 37.68170166015625).
		            (154.3360013961792 @ 20.0838623046875 corner:
			             207.24199962615967 @ 37.68170166015625).
		            (207.24199962615967 @ 20.0838623046875 corner:
			             210.04199957847595 @ 37.68170166015625).
		            (210.04199957847595 @ 20.0838623046875 corner:
			             221.7179992198944 @ 37.68170166015625).
		            (221.7179992198944 @ 20.0838623046875 corner:
			             224.5179991722107 @ 37.68170166015625).
		            (224.5179991722107 @ 20.0838623046875 corner:
			             256.62000036239624 @ 37.68170166015625).
		            (256.62000036239624 @ 20.0838623046875 corner:
			             259.4200003147125 @ 37.68170166015625).
		            (259.4200003147125 @ 20.0838623046875 corner:
			             333.21399903297424 @ 37.68170166015625).
		            (333.21399903297424 @ 20.0838623046875 corner:
			             336.0139989852905 @ 37.68170166015625).
		            (336.0139989852905 @ 20.0838623046875 corner:
			             358.4980001449585 @ 37.68170166015625).
		            (358.4980001449585 @ 20.0838623046875 corner:
			             361.2980000972748 @ 37.68170166015625).
		            (361.2980000972748 @ 20.0838623046875 corner:
			             388.8919999599457 @ 37.68170166015625).
		            (388.8919999599457 @ 20.0838623046875 corner:
			             482.09765625 @ 37.68170166015625).
		            (0.0 @ 37.68170166015625 corner:
			             113.2179946899414 @ 55.279541015625).
		            (113.2179946899414 @ 37.68170166015625 corner:
			             116.01799464225769 @ 55.279541015625).
		            (116.01799464225769 @ 37.68170166015625 corner:
			             138.0819957256317 @ 55.279541015625).
		            (138.0819957256317 @ 37.68170166015625 corner:
			             140.881995677948 @ 55.279541015625).
		            (140.881995677948 @ 37.68170166015625 corner:
			             167.3139967918396 @ 55.279541015625).
		            (167.3139967918396 @ 37.68170166015625 corner:
			             170.11399674415588 @ 55.279541015625).
		            (170.11399674415588 @ 37.68170166015625 corner:
			             179.42399716377258 @ 55.279541015625).
		            (179.42399716377258 @ 37.68170166015625 corner:
			             182.22399711608887 @ 55.279541015625).
		            (182.22399711608887 @ 37.68170166015625 corner:
			             242.77400016784668 @ 55.279541015625).
		            (242.77400016784668 @ 37.68170166015625 corner:
			             245.57400012016296 @ 55.279541015625).
		            (245.57400012016296 @ 37.68170166015625 corner:
			             273.896000623703 @ 55.279541015625).
		            (273.896000623703 @ 37.68170166015625 corner:
			             276.6960005760193 @ 55.279541015625).
		            (276.6960005760193 @ 37.68170166015625 corner:
			             291.9420008659363 @ 55.279541015625).
		            (291.9420008659363 @ 37.68170166015625 corner:
			             294.74200081825256 @ 55.279541015625).
		            (294.74200081825256 @ 37.68170166015625 corner:
			             322.74200081825256 @ 55.279541015625).
		            (322.74200081825256 @ 37.68170166015625 corner:
			             325.54200077056885 @ 55.279541015625).
		            (325.54200077056885 @ 37.68170166015625 corner:
			             393.47000217437744 @ 55.279541015625).
		            (393.47000217437744 @ 37.68170166015625 corner:
			             396.2700021266937 @ 55.279541015625).
		            (396.2700021266937 @ 37.68170166015625 corner:
			             408.59000182151794 @ 55.279541015625).
		            (408.59000182151794 @ 37.68170166015625 corner:
			             411.39000177383423 @ 55.279541015625).
		            (411.39000177383423 @ 37.68170166015625 corner:
			             441.4760003089905 @ 55.279541015625).
		            (441.4760003089905 @ 37.68170166015625 corner:
			             444.27600026130676 @ 55.279541015625).
		            (444.27600026130676 @ 37.68170166015625 corner:
			             475.27200055122375 @ 55.279541015625).
		            (475.27200055122375 @ 37.68170166015625 corner:
			             482.09765625 @ 55.279541015625).
		            (0.0 @ 55.279541015625 corner:
			             34.7339973449707 @ 72.87738037109375).
		            (34.7339973449707 @ 55.279541015625 corner:
			             37.53399729728699 @ 72.87738037109375).
		            (37.53399729728699 @ 55.279541015625 corner:
			             482.09765625 @ 72.87738037109375) } collect: [
		            :eachBounds |
		            self cell
			            extent: eachBounds extent;
			            position: eachBounds origin;
			            background: Color veryVeryLightGray;
			            margin: (BlInsets all: 0);
			            border: (BlBorder paint: Color lightGray width: 1) ].

	container := BlElement new.
	container layout: BlFitLayout new.
	container constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].

	container addChildren: children.
	container forceLayout.
	container addEventHandler: BlFocusExampleNavigationListener new.

	^ container
]

{ #category : #'examples - segment 4' }
BlFocusFinderExamples >> segmentWithCells_4 [
	<gtExample>
	| container children |
	
	children := { {30. 2. 455}. {489}. { 489 }. {26. 2. 18. 2. 437} } collect: [ :eachSegment |
		| grid gridChildren |
		gridChildren := eachSegment collect: [ :eachExtent |
			self cell
				extent: eachExtent @ (eachSegment size = 1 ifTrue: [ 25 ] ifFalse: [ 30 ]);
				background: Color veryVeryLightGray;
				margin: (BlInsets all: 2);
				border: (BlBorder paint: Color gray width: 1) ].

		grid := BlElement new.
		grid layout: BlFlowLayout new.
		grid focusability: BlFocusability after.
		grid constraintsDo: [ :c | 
			c horizontal exact: 506.
			c vertical fitContent ].
		grid addChildren: gridChildren.
		grid ].

	container := BlElement new.
	container layout: BlLinearLayout vertical.
	container constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	
	container addChildren: children.
	container forceLayout.
	
	container addEventHandler: BlFocusExampleNavigationListener new.
	
	^ container
]
