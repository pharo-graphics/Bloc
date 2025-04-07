"
I have been automatically converted and probably manually tweaked from BlFitChildrenLayoutExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlFitChildrenLayoutTest,
	#superclass : #TestCase,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #fixture }
BlFitChildrenLayoutTest >> graphNodesDataLayedOut [

	^ {
		  (610.5 @ 0.5 corner: 615.5 @ 5.5).
		  (460.5 @ 20.5 corner: 465.5 @ 25.5).
		  (730.5 @ 20.5 corner: 735.5 @ 25.5).
		  (230.5 @ 40.5 corner: 235.5 @ 45.5).
		  (460.5 @ 40.5 corner: 465.5 @ 45.5).
		  (730.5 @ 40.5 corner: 735.5 @ 45.5).
		  (850.5 @ 40.5 corner: 855.5 @ 45.5).
		  (110.5 @ 60.5 corner: 115.5 @ 65.5).
		  (230.5 @ 60.5 corner: 235.5 @ 65.5).
		  (430.5 @ 60.5 corner: 435.5 @ 65.5).
		  (510.5 @ 60.5 corner: 515.5 @ 65.5).
		  (710.5 @ 60.5 corner: 715.5 @ 65.5).
		  (750.5 @ 60.5 corner: 755.5 @ 65.5).
		  (850.5 @ 60.5 corner: 855.5 @ 65.5).
		  (910.5 @ 60.5 corner: 915.5 @ 65.5).
		  (50.5 @ 80.5 corner: 55.5 @ 85.5).
		  (110.5 @ 80.5 corner: 115.5 @ 85.5).
		  (210.5 @ 80.5 corner: 215.5 @ 85.5).
		  (250.5 @ 80.5 corner: 255.5 @ 85.5).
		  (370.5 @ 80.5 corner: 375.5 @ 85.5).
		  (430.5 @ 80.5 corner: 435.5 @ 85.5).
		  (510.5 @ 80.5 corner: 515.5 @ 85.5).
		  (570.5 @ 80.5 corner: 575.5 @ 85.5).
		  (680.5 @ 80.5 corner: 685.5 @ 85.5).
		  (710.5 @ 80.5 corner: 715.5 @ 85.5).
		  (750.5 @ 80.5 corner: 755.5 @ 85.5).
		  (780.5 @ 80.5 corner: 785.5 @ 85.5).
		  (840.5 @ 80.5 corner: 845.5 @ 85.5).
		  (860.5 @ 80.5 corner: 865.5 @ 85.5).
		  (910.5 @ 80.5 corner: 915.5 @ 85.5).
		  (940.5 @ 80.5 corner: 945.5 @ 85.5).
		  (20.5 @ 100.5 corner: 25.5 @ 105.5).
		  (50.5 @ 100.5 corner: 55.5 @ 105.5).
		  (100.5 @ 100.5 corner: 105.5 @ 105.5).
		  (120.5 @ 100.5 corner: 125.5 @ 105.5).
		  (180.5 @ 100.5 corner: 185.5 @ 105.5).
		  (210.5 @ 100.5 corner: 215.5 @ 105.5).
		  (250.5 @ 100.5 corner: 255.5 @ 105.5).
		  (280.5 @ 100.5 corner: 285.5 @ 105.5).
		  (340.5 @ 100.5 corner: 345.5 @ 105.5).
		  (370.5 @ 100.5 corner: 375.5 @ 105.5).
		  (420.5 @ 100.5 corner: 425.5 @ 105.5).
		  (440.5 @ 100.5 corner: 445.5 @ 105.5).
		  (500.5 @ 100.5 corner: 505.5 @ 105.5).
		  (520.5 @ 100.5 corner: 525.5 @ 105.5).
		  (570.5 @ 100.5 corner: 575.5 @ 105.5).
		  (600.5 @ 100.5 corner: 605.5 @ 105.5).
		  (660.5 @ 100.5 corner: 665.5 @ 105.5).
		  (680.5 @ 100.5 corner: 685.5 @ 105.5).
		  (700.5 @ 100.5 corner: 705.5 @ 105.5).
		  (720.5 @ 100.5 corner: 725.5 @ 105.5).
		  (740.5 @ 100.5 corner: 745.5 @ 105.5).
		  (760.5 @ 100.5 corner: 765.5 @ 105.5).
		  (780.5 @ 100.5 corner: 785.5 @ 105.5).
		  (800.5 @ 100.5 corner: 805.5 @ 105.5).
		  (820.5 @ 100.5 corner: 825.5 @ 105.5).
		  (840.5 @ 100.5 corner: 845.5 @ 105.5).
		  (860.5 @ 100.5 corner: 865.5 @ 105.5).
		  (880.5 @ 100.5 corner: 885.5 @ 105.5).
		  (900.5 @ 100.5 corner: 905.5 @ 105.5).
		  (920.5 @ 100.5 corner: 925.5 @ 105.5).
		  (940.5 @ 100.5 corner: 945.5 @ 105.5).
		  (960.5 @ 100.5 corner: 965.5 @ 105.5).
		  (0.5 @ 120.5 corner: 5.5 @ 125.5).
		  (20.5 @ 120.5 corner: 25.5 @ 125.5).
		  (40.5 @ 120.5 corner: 45.5 @ 125.5).
		  (60.5 @ 120.5 corner: 65.5 @ 125.5).
		  (80.5 @ 120.5 corner: 85.5 @ 125.5).
		  (100.5 @ 120.5 corner: 105.5 @ 125.5).
		  (120.5 @ 120.5 corner: 125.5 @ 125.5).
		  (140.5 @ 120.5 corner: 145.5 @ 125.5).
		  (160.5 @ 120.5 corner: 165.5 @ 125.5).
		  (180.5 @ 120.5 corner: 185.5 @ 125.5).
		  (200.5 @ 120.5 corner: 205.5 @ 125.5).
		  (220.5 @ 120.5 corner: 225.5 @ 125.5).
		  (240.5 @ 120.5 corner: 245.5 @ 125.5).
		  (260.5 @ 120.5 corner: 265.5 @ 125.5).
		  (280.5 @ 120.5 corner: 285.5 @ 125.5).
		  (300.5 @ 120.5 corner: 305.5 @ 125.5).
		  (320.5 @ 120.5 corner: 325.5 @ 125.5).
		  (340.5 @ 120.5 corner: 345.5 @ 125.5).
		  (360.5 @ 120.5 corner: 365.5 @ 125.5).
		  (380.5 @ 120.5 corner: 385.5 @ 125.5).
		  (400.5 @ 120.5 corner: 405.5 @ 125.5).
		  (420.5 @ 120.5 corner: 425.5 @ 125.5).
		  (440.5 @ 120.5 corner: 445.5 @ 125.5).
		  (460.5 @ 120.5 corner: 465.5 @ 125.5).
		  (480.5 @ 120.5 corner: 485.5 @ 125.5).
		  (500.5 @ 120.5 corner: 505.5 @ 125.5).
		  (520.5 @ 120.5 corner: 525.5 @ 125.5).
		  (540.5 @ 120.5 corner: 545.5 @ 125.5).
		  (560.5 @ 120.5 corner: 565.5 @ 125.5).
		  (580.5 @ 120.5 corner: 585.5 @ 125.5).
		  (600.5 @ 120.5 corner: 605.5 @ 125.5).
		  (620.5 @ 120.5 corner: 625.5 @ 125.5).
		  (640.5 @ 120.5 corner: 645.5 @ 125.5).
		  (660.5 @ 120.5 corner: 665.5 @ 125.5).
		  (680.5 @ 120.5 corner: 685.5 @ 125.5).
		  (700.5 @ 120.5 corner: 705.5 @ 125.5).
		  (720.5 @ 120.5 corner: 725.5 @ 125.5) }
]

{ #category : #fixture }
BlFitChildrenLayoutTest >> graphNodesDataRaw [

	^ {
		  (180.5 @ -9.5 corner: 185.5 @ -4.5).
		  (30.5 @ 10.5 corner: 35.5 @ 15.5).
		  (300.5 @ 10.5 corner: 305.5 @ 15.5).
		  (-199.5 @ 30.5 corner: -194.5 @ 35.5).
		  (30.5 @ 30.5 corner: 35.5 @ 35.5).
		  (300.5 @ 30.5 corner: 305.5 @ 35.5).
		  (420.5 @ 30.5 corner: 425.5 @ 35.5).
		  (-319.5 @ 50.5 corner: -314.5 @ 55.5).
		  (-199.5 @ 50.5 corner: -194.5 @ 55.5).
		  (0.5 @ 50.5 corner: 5.5 @ 55.5).
		  (80.5 @ 50.5 corner: 85.5 @ 55.5).
		  (280.5 @ 50.5 corner: 285.5 @ 55.5).
		  (320.5 @ 50.5 corner: 325.5 @ 55.5).
		  (420.5 @ 50.5 corner: 425.5 @ 55.5).
		  (480.5 @ 50.5 corner: 485.5 @ 55.5).
		  (-379.5 @ 70.5 corner: -374.5 @ 75.5).
		  (-319.5 @ 70.5 corner: -314.5 @ 75.5).
		  (-219.5 @ 70.5 corner: -214.5 @ 75.5).
		  (-179.5 @ 70.5 corner: -174.5 @ 75.5).
		  (-59.5 @ 70.5 corner: -54.5 @ 75.5).
		  (0.5 @ 70.5 corner: 5.5 @ 75.5).
		  (80.5 @ 70.5 corner: 85.5 @ 75.5).
		  (140.5 @ 70.5 corner: 145.5 @ 75.5).
		  (250.5 @ 70.5 corner: 255.5 @ 75.5).
		  (280.5 @ 70.5 corner: 285.5 @ 75.5).
		  (320.5 @ 70.5 corner: 325.5 @ 75.5).
		  (350.5 @ 70.5 corner: 355.5 @ 75.5).
		  (410.5 @ 70.5 corner: 415.5 @ 75.5).
		  (430.5 @ 70.5 corner: 435.5 @ 75.5).
		  (480.5 @ 70.5 corner: 485.5 @ 75.5).
		  (510.5 @ 70.5 corner: 515.5 @ 75.5).
		  (-409.5 @ 90.5 corner: -404.5 @ 95.5).
		  (-379.5 @ 90.5 corner: -374.5 @ 95.5).
		  (-329.5 @ 90.5 corner: -324.5 @ 95.5).
		  (-309.5 @ 90.5 corner: -304.5 @ 95.5).
		  (-249.5 @ 90.5 corner: -244.5 @ 95.5).
		  (-219.5 @ 90.5 corner: -214.5 @ 95.5).
		  (-179.5 @ 90.5 corner: -174.5 @ 95.5).
		  (-149.5 @ 90.5 corner: -144.5 @ 95.5).
		  (-89.5 @ 90.5 corner: -84.5 @ 95.5).
		  (-59.5 @ 90.5 corner: -54.5 @ 95.5).
		  (-9.5 @ 90.5 corner: -4.5 @ 95.5).
		  (10.5 @ 90.5 corner: 15.5 @ 95.5).
		  (70.5 @ 90.5 corner: 75.5 @ 95.5).
		  (90.5 @ 90.5 corner: 95.5 @ 95.5).
		  (140.5 @ 90.5 corner: 145.5 @ 95.5).
		  (170.5 @ 90.5 corner: 175.5 @ 95.5).
		  (230.5 @ 90.5 corner: 235.5 @ 95.5).
		  (250.5 @ 90.5 corner: 255.5 @ 95.5).
		  (270.5 @ 90.5 corner: 275.5 @ 95.5).
		  (290.5 @ 90.5 corner: 295.5 @ 95.5).
		  (310.5 @ 90.5 corner: 315.5 @ 95.5).
		  (330.5 @ 90.5 corner: 335.5 @ 95.5).
		  (350.5 @ 90.5 corner: 355.5 @ 95.5).
		  (370.5 @ 90.5 corner: 375.5 @ 95.5).
		  (390.5 @ 90.5 corner: 395.5 @ 95.5).
		  (410.5 @ 90.5 corner: 415.5 @ 95.5).
		  (430.5 @ 90.5 corner: 435.5 @ 95.5).
		  (450.5 @ 90.5 corner: 455.5 @ 95.5).
		  (470.5 @ 90.5 corner: 475.5 @ 95.5).
		  (490.5 @ 90.5 corner: 495.5 @ 95.5).
		  (510.5 @ 90.5 corner: 515.5 @ 95.5).
		  (530.5 @ 90.5 corner: 535.5 @ 95.5).
		  (-429.5 @ 110.5 corner: -424.5 @ 115.5).
		  (-409.5 @ 110.5 corner: -404.5 @ 115.5).
		  (-389.5 @ 110.5 corner: -384.5 @ 115.5).
		  (-369.5 @ 110.5 corner: -364.5 @ 115.5).
		  (-349.5 @ 110.5 corner: -344.5 @ 115.5).
		  (-329.5 @ 110.5 corner: -324.5 @ 115.5).
		  (-309.5 @ 110.5 corner: -304.5 @ 115.5).
		  (-289.5 @ 110.5 corner: -284.5 @ 115.5).
		  (-269.5 @ 110.5 corner: -264.5 @ 115.5).
		  (-249.5 @ 110.5 corner: -244.5 @ 115.5).
		  (-229.5 @ 110.5 corner: -224.5 @ 115.5).
		  (-209.5 @ 110.5 corner: -204.5 @ 115.5).
		  (-189.5 @ 110.5 corner: -184.5 @ 115.5).
		  (-169.5 @ 110.5 corner: -164.5 @ 115.5).
		  (-149.5 @ 110.5 corner: -144.5 @ 115.5).
		  (-129.5 @ 110.5 corner: -124.5 @ 115.5).
		  (-109.5 @ 110.5 corner: -104.5 @ 115.5).
		  (-89.5 @ 110.5 corner: -84.5 @ 115.5).
		  (-69.5 @ 110.5 corner: -64.5 @ 115.5).
		  (-49.5 @ 110.5 corner: -44.5 @ 115.5).
		  (-29.5 @ 110.5 corner: -24.5 @ 115.5).
		  (-9.5 @ 110.5 corner: -4.5 @ 115.5).
		  (10.5 @ 110.5 corner: 15.5 @ 115.5).
		  (30.5 @ 110.5 corner: 35.5 @ 115.5).
		  (50.5 @ 110.5 corner: 55.5 @ 115.5).
		  (70.5 @ 110.5 corner: 75.5 @ 115.5).
		  (90.5 @ 110.5 corner: 95.5 @ 115.5).
		  (110.5 @ 110.5 corner: 115.5 @ 115.5).
		  (130.5 @ 110.5 corner: 135.5 @ 115.5).
		  (150.5 @ 110.5 corner: 155.5 @ 115.5).
		  (170.5 @ 110.5 corner: 175.5 @ 115.5).
		  (190.5 @ 110.5 corner: 195.5 @ 115.5).
		  (210.5 @ 110.5 corner: 215.5 @ 115.5).
		  (230.5 @ 110.5 corner: 235.5 @ 115.5).
		  (250.5 @ 110.5 corner: 255.5 @ 115.5).
		  (270.5 @ 110.5 corner: 275.5 @ 115.5).
		  (290.5 @ 110.5 corner: 295.5 @ 115.5) }
]

{ #category : #tests }
BlFitChildrenLayoutTest >> testAtMostOneChildAt50x50Negated [

	<sampleInstance>
	| aParentNode aLayout |
	aParentNode := BlLayoutParentNode new
		               constraints: BlLayoutCommonConstraints new;
		               extentSpec:
			               (BlExtentMeasurementSpec atMost: 500 @ 400);
		               children: { (BlLayoutChildNode new
				                constraints: BlLayoutCommonConstraints new;
				                measurement: (BlLayoutNodeComputedMeasurement
						                 position: (50 @ 50) negated
						                 extent: 100 @ 100);
				                yourself) };
		               yourself.

	aLayout := BlFitChildrenLayout new.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: { ((50 @ 50) negated corner: 50 @ 50) }.
	self assert: aParentNode extent equals: 100 @ 100.

	aLayout layout: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: { (0 @ 0 corner: 100 @ 100) }.

	^ aParentNode
]

{ #category : #tests }
BlFitChildrenLayoutTest >> testExactOneChildAt50x50Negated [

	<sampleInstance>
	| aParentNode aLayout |
	aParentNode := BlLayoutParentNode new
		               constraints: BlLayoutCommonConstraints new;
		               extentSpec:
			               (BlExtentMeasurementSpec exact: 500 @ 400);
		               children: { (BlLayoutChildNode new
				                constraints: BlLayoutCommonConstraints new;
				                measurement: (BlLayoutNodeComputedMeasurement
						                 position: (50 @ 50) negated
						                 extent: 100 @ 100);
				                yourself) };
		               yourself.

	aLayout := BlFitChildrenLayout new.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: { ((50 @ 50) negated corner: 50 @ 50) }.
	self assert: aParentNode extent equals: 500 @ 400.

	aLayout layout: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: { (200 @ 150 corner: 300 @ 250) }.

	^ aParentNode
]

{ #category : #tests }
BlFitChildrenLayoutTest >> testFitContentGraph [

	<sampleInstance>
	| aParentNode aLayout |
	aParentNode := BlLayoutParentNode new
		               constraints: BlLayoutCommonConstraints new;
		               extentSpec: BlExtentMeasurementSpec unspecified;
		               children:
			               (self graphNodesDataRaw collect: [ :bounds |
					                BlLayoutChildNode new
						                constraints: BlLayoutCommonConstraints new;
						                measurement: (BlLayoutNodeComputedMeasurement
								                 position: bounds origin
								                 extent: bounds extent);
						                yourself ]);
		               yourself.

	aLayout := BlFitChildrenLayout new.
	aLayout measure: aParentNode.
	aLayout layout: aParentNode.

	self assert: aParentNode extent equals: 966.0 @ 126.0.
	self
		assert: aParentNode children layoutBounds
		equals: self graphNodesDataLayedOut.

	^ aParentNode
]

{ #category : #tests }
BlFitChildrenLayoutTest >> testFitContentOneChildAt0x0 [

	<sampleInstance>
	| aParentNode aLayout |
	aParentNode := BlLayoutParentNode new
		               constraints: BlLayoutCommonConstraints new;
		               extentSpec: BlExtentMeasurementSpec unspecified;
		               children: { (BlLayoutChildNode new
				                constraints: BlLayoutCommonConstraints new;
				                measurement: (BlLayoutNodeComputedMeasurement new
						                 position: 0 @ 0;
						                 extent: 100 @ 100);
				                yourself) };
		               yourself.

	aLayout := BlFitChildrenLayout new.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: { (0 @ 0 corner: 100 @ 100) }.
	self assert: aParentNode extent equals: 100 @ 100.

	aLayout layout: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: { (0 @ 0 corner: 100 @ 100) }.

	^ aParentNode
]

{ #category : #tests }
BlFitChildrenLayoutTest >> testFitContentOneChildAt50x50 [

	<sampleInstance>
	| aParentNode aLayout |
	aParentNode := BlLayoutParentNode new
		               constraints: BlLayoutCommonConstraints new;
		               extentSpec: BlExtentMeasurementSpec unspecified;
		               children: { (BlLayoutChildNode new
				                constraints: BlLayoutCommonConstraints new;
				                measurement: (BlLayoutNodeComputedMeasurement
						                 position: 50 @ 50
						                 extent: 100 @ 100)) };
		               yourself.

	aLayout := BlFitChildrenLayout new.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: { (50 @ 50 corner: 150 @ 150) }.
	self assert: aParentNode extent equals: 100 @ 100.

	aLayout layout: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: { (0 @ 0 corner: 100 @ 100) }.

	^ aParentNode
]

{ #category : #tests }
BlFitChildrenLayoutTest >> testFitContentOneChildAt50x50Negated [

	<sampleInstance>
	| aParentNode aLayout |
	aParentNode := BlLayoutParentNode new
		               constraints: BlLayoutCommonConstraints new;
		               extentSpec: BlExtentMeasurementSpec unspecified;
		               children: { (BlLayoutChildNode new
				                constraints: BlLayoutCommonConstraints new;
				                measurement: (BlLayoutNodeComputedMeasurement
						                 position: (50 @ 50) negated
						                 extent: 100 @ 100);
				                yourself) };
		               yourself.

	aLayout := BlFitChildrenLayout new.
	aLayout measure: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: { ((50 @ 50) negated corner: 50 @ 50) }.
	self assert: aParentNode extent equals: 100 @ 100.

	aLayout layout: aParentNode.

	self
		assert: aParentNode children layoutBounds
		equals: { (0 @ 0 corner: 100 @ 100) }.

	^ aParentNode
]
