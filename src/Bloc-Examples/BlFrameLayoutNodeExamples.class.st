Class {
	#name : #BlFrameLayoutNodeExamples,
	#superclass : #BlFrameLayoutExamples,
	#category : #'Bloc-Examples-Layout'
}

{ #category : #examples }
BlFrameLayoutNodeExamples >> empty_parent_at_most [
	<gtExample>
	| aLayout aParentNode |

	aParentNode := BlLayoutParentNode new.
	aParentNode constraints: (BlLayoutCommonConstraints new).
	aParentNode extentSpec: (BlExtentMeasurementSpec atMost: 200@100).

	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.

	self assert: aParentNode measuredExtent equals: 0.0@0.0.

	^ aParentNode
]

{ #category : #examples }
BlFrameLayoutNodeExamples >> empty_parent_exact [
	<gtExample>
	| aLayout aParentNode |

	aParentNode := BlLayoutParentNode new.
	aParentNode constraints: (BlLayoutCommonConstraints new).
	aParentNode extentSpec: (BlExtentMeasurementSpec exact: 200@100).

	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.

	self assert: aParentNode measuredExtent equals: 200.0@100.0.

	^ aParentNode
]

{ #category : #examples }
BlFrameLayoutNodeExamples >> one_child_match_parent_exact [
	<gtExample>
	| aLayout aParentNode aChildNode |

	aChildNode := BlLayoutChildNode new
		constraints: (BlLayoutCommonConstraints new);
		measurement: (BlLayoutNodeResizerMeasurement new);
		matchParent.

	aParentNode := BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec exact: 200@100);
		children: { aChildNode }.

	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.
	
	self assert: aParentNode measuredExtent equals: 200.0@100.0.
	self assert: aChildNode extent equals: 200.0@100.0.

	aParentNode layoutExtent: aParentNode measuredExtent.
	aLayout layout: aParentNode.

	self assert: aChildNode layoutBounds equals: (0@0 extent: 200.0@100.0).

	^ aParentNode
]

{ #category : #examples }
BlFrameLayoutNodeExamples >> one_child_match_parent_fit_content [
	<gtExample>
	| aLayout aParentNode aChildNode |

	aChildNode := BlLayoutChildNode new
		constraints: (BlLayoutCommonConstraints new);
		measurement: (BlLayoutNodeResizerMeasurement new);
		hMatchParent;
		vExact: 50.

	aParentNode := BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new padding: (BlInsets all: 15));
		extentSpec: (BlMeasurementSpec exact: 200) @ BlMeasurementSpec unspecified;
		children: { aChildNode }.

	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.
	
	self assert: aParentNode measuredExtent equals: 200.0@80.0.
	self assert: aChildNode extent equals: 170.0@50.0.

	aParentNode layoutExtent: aParentNode measuredExtent.
	aLayout layout: aParentNode.

	self assert: aChildNode layoutBounds equals: (15@15 extent: 170.0@50.0).

	^ aParentNode
]

{ #category : #examples }
BlFrameLayoutNodeExamples >> one_child_match_parent_matrix_exact [
	<gtExample>
	| aLayout aParentNode aChildNode |

	aChildNode := (BlLayoutChildNode new
		constraints: (BlLayoutCommonConstraints new);
		measurement: (BlLayoutNodeResizerMeasurement new);
		matchParent) withMatrix: (BlMatrix2D scale: 2@2).

	aParentNode := BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec exact: 200@100);
		children: { aChildNode }.

	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.
	
	self assert: aParentNode measuredExtent equals: 200.0@100.0.
	self assert: aChildNode extent equals: 400.0@200.0.

	aParentNode layoutExtent: aParentNode measuredExtent.
	aLayout layout: aParentNode.

	self assert: aChildNode layoutBounds equals: (0@0 extent: 200.0@100.0).

	^ aParentNode
]

{ #category : #examples }
BlFrameLayoutNodeExamples >> one_child_match_weight_matrix_downscacle_align_top_right_parent_exact [
	<gtExample>
	| aLayout aParentNode aChildNode aChildConstraints |

	aChildConstraints := BlLayoutCommonConstraints new.
	aChildConstraints frame horizontal weight: 0.5; alignRight.
	aChildConstraints frame vertical weight: 0.5; alignTop.

	aChildNode := (BlLayoutChildNode new
		constraints: (aChildConstraints);
		measurement: (BlLayoutNodeResizerMeasurement new);
		matchParent) withMatrix: (BlMatrix2D scale: 0.5).

	aParentNode := BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec exact: 200@100);
		children: { aChildNode }.

	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.

	self assert: aParentNode measuredExtent equals: 200.0@100.0.
	self assert: aChildNode extent equals: 50.0@25.0.

	aParentNode layoutExtent: aParentNode measuredExtent.
	aLayout layout: aParentNode.

	self assert: aChildNode layoutBounds equals: (150@0 extent: 100.0@50.0).

	^ aParentNode
]

{ #category : #examples }
BlFrameLayoutNodeExamples >> one_child_match_weight_matrix_upscale_align_top_right_parent_exact [
	<gtExample>
	| aLayout aParentNode aChildNode aChildConstraints |

	aChildConstraints := BlLayoutCommonConstraints new.
	aChildConstraints frame horizontal weight: 0.5; alignRight.
	aChildConstraints frame vertical weight: 0.5; alignTop.

	aChildNode := (BlLayoutChildNode new
		constraints: (aChildConstraints);
		measurement: (BlLayoutNodeResizerMeasurement new);
		matchParent)
			withMatrix: (BlMatrix2D scale: 2).

	aParentNode := BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec exact: 200@100);
		children: { aChildNode }.

	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.

	self assert: aParentNode measuredExtent equals: 200.0@100.0.
	self assert: aChildNode extent equals: 200.0@100.0.

	aParentNode layoutExtent: aParentNode measuredExtent.
	aLayout layout: aParentNode.

	self assert: aChildNode layoutBounds equals: (0.0@0.0 extent: 100.0@50.0).

	^ aParentNode
]

{ #category : #examples }
BlFrameLayoutNodeExamples >> one_child_match_weight_parent_exact [
	<gtExample>
	| aLayout aParentNode aChildNode aChildConstraints |

	aChildConstraints := BlLayoutCommonConstraints new.
	aChildConstraints frame horizontal weight: 0.5.
	aChildConstraints frame vertical weight: 0.5.

	aChildNode := BlLayoutChildNode new
		constraints: (aChildConstraints);
		measurement: (BlLayoutNodeResizerMeasurement new);
		matchParent.

	aParentNode := BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec exact: 200@100);
		children: { aChildNode }.

	aLayout := BlFrameLayout new.
	aLayout measure: aParentNode.

	self assert: aParentNode measuredExtent equals: 200.0@100.0.
	self assert: aChildNode extent equals: 100.0@50.0.
	
	aParentNode layoutExtent: aParentNode measuredExtent.
	aLayout layout: aParentNode.

	self assert: aChildNode layoutBounds equals: (0@0 extent: 100.0@50.0).

	^ aParentNode
]
