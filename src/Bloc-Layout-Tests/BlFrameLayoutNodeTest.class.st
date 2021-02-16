"
I have been automatically converted and probably manually tweaked from BlFrameLayoutNodeExamples. Pay attention there is an important design decision in such tests. First to let GT people execute them, the tests and helpers are tagged with <gtExample> do not remove them, let also the <label:...>.
	Finally and more important such tests should not use setup because every method should be in capacity of returning a fully working object called an example :)
"
Class {
	#name : #BlFrameLayoutNodeTest,
	#superclass : #BlRootLayoutTest,
	#category : #'Bloc-Layout-Tests'
}

{ #category : #metadata }
BlFrameLayoutNodeTest >> originClassName [
	"This test was generated from..."
	^ 'BlFrameLayoutNodeExamples'
]

{ #category : #tests }
BlFrameLayoutNodeTest >> testEmptyParentAtMost [
	<gtExample>
	| aLayout aParentNode |
	aParentNode := BlLayoutParentNode new.
	aParentNode constraints: BlLayoutCommonConstraints new.
	aParentNode extentSpec: (BlExtentMeasurementSpec atMost: 200 @ 100).
	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.
	self assert: aParentNode extent equals: 0.0 @ 0.0.
	^ aParentNode
]

{ #category : #tests }
BlFrameLayoutNodeTest >> testEmptyParentExact [
	<gtExample>
	| aLayout aParentNode |
	aParentNode := BlLayoutParentNode new.
	aParentNode constraints: BlLayoutCommonConstraints new.
	aParentNode extentSpec: (BlExtentMeasurementSpec exact: 200 @ 100).
	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.
	self assert: aParentNode extent equals: 200.0 @ 100.0.
	^ aParentNode
]

{ #category : #tests }
BlFrameLayoutNodeTest >> testOneChildMatchParentExact [
	<gtExample>
	| aLayout aParentNode aChildNode |
	aChildNode := BlLayoutChildNode new
		constraints: BlLayoutCommonConstraints new;
		measurement: BlLayoutNodeResizerMeasurement new;
		matchParent.
	aParentNode := BlLayoutParentNode new
		constraints: BlLayoutCommonConstraints new;
		extentSpec: (BlExtentMeasurementSpec exact: 200 @ 100);
		children: {aChildNode}.
	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.
	self assert: aParentNode extent equals: 200.0 @ 100.0.
	self assert: aChildNode extent equals: 200.0 @ 100.0.
	aLayout layout: aParentNode.
	self
		assert: aChildNode layoutBounds
		equals: (0 @ 0 extent: 200.0 @ 100.0).
	^ aParentNode
]

{ #category : #tests }
BlFrameLayoutNodeTest >> testOneChildMatchParentFitContent [
	<gtExample>
	| aLayout aParentNode aChildNode |
	aChildNode := BlLayoutChildNode new
		constraints: BlLayoutCommonConstraints new;
		measurement: BlLayoutNodeResizerMeasurement new;
		hMatchParent;
		vExact: 50.
	aParentNode := BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new padding: (BlInsets all: 15));
		extentSpec: (BlMeasurementSpec exact: 200) @ BlMeasurementSpec unspecified;
		children: {aChildNode}.
	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.
	self assert: aParentNode extent equals: 200.0 @ 80.0.
	self assert: aChildNode extent equals: 170.0 @ 50.0.
	aLayout layout: aParentNode.
	self
		assert: aChildNode layoutBounds
		equals: (15 @ 15 extent: 170.0 @ 50.0).
	^ aParentNode
]

{ #category : #tests }
BlFrameLayoutNodeTest >> testOneChildMatchParentMatrixExact [
	<gtExample>
	| aLayout aParentNode aChildNode |
	aChildNode := (BlLayoutChildNode new
		constraints: BlLayoutCommonConstraints new;
		measurement: BlLayoutNodeResizerMeasurement new;
		matchParent) withMatrix: (BlMatrix2D scale: 2 @ 2).
	aParentNode := BlLayoutParentNode new
		constraints: BlLayoutCommonConstraints new;
		extentSpec: (BlExtentMeasurementSpec exact: 200 @ 100);
		children: {aChildNode}.
	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.
	self assert: aParentNode extent equals: 200.0 @ 100.0.
	self assert: aChildNode extent equals: 400.0 @ 200.0.
	aLayout layout: aParentNode.
	self
		assert: aChildNode layoutBounds
		equals: (0 @ 0 extent: 200.0 @ 100.0).
	^ aParentNode
]

{ #category : #tests }
BlFrameLayoutNodeTest >> testOneChildMatchWeightMatrixDownscacleAlignTopRightParentExact [
	<gtExample>
	| aLayout aParentNode aChildNode aChildConstraints |
	aChildConstraints := BlLayoutCommonConstraints new.
	aChildConstraints frame horizontal
		weight: 0.5;
		alignRight.
	aChildConstraints frame vertical
		weight: 0.5;
		alignTop.
	aChildNode := (BlLayoutChildNode new
		constraints: aChildConstraints;
		measurement: BlLayoutNodeResizerMeasurement new;
		matchParent) withMatrix: (BlMatrix2D scale: 0.5).
	aParentNode := BlLayoutParentNode new
		constraints: BlLayoutCommonConstraints new;
		extentSpec: (BlExtentMeasurementSpec exact: 200 @ 100);
		children: {aChildNode}.
	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.
	self assert: aParentNode extent equals: 200.0 @ 100.0.
	self assert: aChildNode extent equals: 50.0 @ 25.0.
	aLayout layout: aParentNode.
	self
		assert: aChildNode layoutBounds
		equals: (150 @ 0 extent: 100.0 @ 50.0).
	^ aParentNode
]

{ #category : #tests }
BlFrameLayoutNodeTest >> testOneChildMatchWeightMatrixUpscaleAlignTopRightParentExact [
	<gtExample>
	| aLayout aParentNode aChildNode aChildConstraints |
	aChildConstraints := BlLayoutCommonConstraints new.
	aChildConstraints frame horizontal
		weight: 0.5;
		alignRight.
	aChildConstraints frame vertical
		weight: 0.5;
		alignTop.
	aChildNode := (BlLayoutChildNode new
		constraints: aChildConstraints;
		measurement: BlLayoutNodeResizerMeasurement new;
		matchParent) withMatrix: (BlMatrix2D scale: 2).
	aParentNode := BlLayoutParentNode new
		constraints: BlLayoutCommonConstraints new;
		extentSpec: (BlExtentMeasurementSpec exact: 200 @ 100);
		children: {aChildNode}.
	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.
	self assert: aParentNode extent equals: 200.0 @ 100.0.
	self assert: aChildNode extent equals: 200.0 @ 100.0.
	aLayout layout: aParentNode.
	self
		assert: aChildNode layoutBounds
		equals: (0.0 @ 0.0 extent: 100.0 @ 50.0).
	^ aParentNode
]

{ #category : #tests }
BlFrameLayoutNodeTest >> testOneChildMatchWeightParentExact [
	<gtExample>
	| aLayout aParentNode aChildNode aChildConstraints |
	aChildConstraints := BlLayoutCommonConstraints new.
	aChildConstraints frame horizontal weight: 0.5.
	aChildConstraints frame vertical weight: 0.5.
	aChildNode := BlLayoutChildNode new
		constraints: aChildConstraints;
		measurement: BlLayoutNodeResizerMeasurement new;
		matchParent.
	aParentNode := BlLayoutParentNode new
		constraints: BlLayoutCommonConstraints new;
		extentSpec: (BlExtentMeasurementSpec exact: 200 @ 100);
		children: {aChildNode}.
	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.
	self assert: aParentNode extent equals: 200.0 @ 100.0.
	self assert: aChildNode extent equals: 100.0 @ 50.0.
	aLayout layout: aParentNode.
	self
		assert: aChildNode layoutBounds
		equals: (0 @ 0 extent: 100.0 @ 50.0).
	^ aParentNode
]
