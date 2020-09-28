Class {
	#name : #BlFitChildrenLayoutExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Layout'
}

{ #category : #'examples - fit children' }
BlFitChildrenLayoutExamples >> atMost_one_child_at_50x50_negated [
	<gtExample>
	| aParentNode aLayout |

	aParentNode := BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec atMost: 500@400);
		children: { 
			BlLayoutChildNode new
				constraints: BlLayoutCommonConstraints new;
				measurement: (BlLayoutNodeComputedMeasurement new
					position: (50@50) negated;
					extent: 100@100).
		}.

	aLayout := BlFitChildrenLayout new.
	aLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(50@50) negated corner: (50@50)
	}.
	self assert: aParentNode extent equals: 100@100.
	
	aLayout layout: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0@0) corner: (100@100)
	}.
		
	^ aParentNode
]

{ #category : #'examples - fit children' }
BlFitChildrenLayoutExamples >> exact_one_child_at_50x50_negated [
	<gtExample>
	| aParentNode aLayout |

	aParentNode := BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec exact: 500@400);
		children: { 
			BlLayoutChildNode new
				constraints: BlLayoutCommonConstraints new;
				measurement: (BlLayoutNodeComputedMeasurement new
					position: (50@50) negated;
					extent: 100@100).
		}.

	aLayout := BlFitChildrenLayout new.
	aLayout measure: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(50@50) negated corner: (50@50)
	}.
	self assert: aParentNode extent equals: 500@400.

	aLayout layout: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(200@150) corner: (300@250)
	}.
		
	^ aParentNode
]

{ #category : #'examples - fit children' }
BlFitChildrenLayoutExamples >> fitContent_one_child_at_0x0 [
	<gtExample>
	| aParentNode aLayout |

	aParentNode := BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec unspecified);
		children: { 
			BlLayoutChildNode new
				constraints: BlLayoutCommonConstraints new;
				measurement: (BlLayoutNodeComputedMeasurement new
					position: 0@0;
					extent: 100@100).
		}.
		
	aLayout := BlFitChildrenLayout new.
	aLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(0@0) corner: (100@100)
	}.
	self assert: aParentNode extent equals: 100@100.
	
	aLayout layout: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0@0) corner: (100@100)
	}.
		
	^ aParentNode
]

{ #category : #'examples - fit children' }
BlFitChildrenLayoutExamples >> fitContent_one_child_at_50x50 [
	<gtExample>
	| aParentNode aLayout |

	aParentNode := BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec unspecified);
		children: { 
			BlLayoutChildNode new
				constraints: BlLayoutCommonConstraints new;
				measurement: (BlLayoutNodeComputedMeasurement new
					position: 50@50;
					extent: 100@100).
		}.

	aLayout := BlFitChildrenLayout new.
	aLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(50@50) corner: (150@150)
	}.
	self assert: aParentNode extent equals: 100@100.
	
	aLayout layout: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0@0) corner: (100@100)
	}.
		
	^ aParentNode
]

{ #category : #'examples - fit children' }
BlFitChildrenLayoutExamples >> fitContent_one_child_at_50x50_negated [
	<gtExample>
	| aParentNode aLayout |

	aParentNode := BlLayoutParentNode new
		constraints: (BlLayoutCommonConstraints new);
		extentSpec: (BlExtentMeasurementSpec unspecified);
		children: { 
			BlLayoutChildNode new
				constraints: BlLayoutCommonConstraints new;
				measurement: (BlLayoutNodeComputedMeasurement new
					position: (50@50) negated;
					extent: 100@100).
		}.

	aLayout := BlFitChildrenLayout new.
	aLayout measure: aParentNode.
	
	self assert: aParentNode children layoutBounds equals: {
		(50@50) negated corner: (50@50)
	}.
	self assert: aParentNode extent equals: 100@100.
	
	aLayout layout: aParentNode.

	self assert: aParentNode children layoutBounds equals: {
		(0@0) corner: (100@100)
	}.
		
	^ aParentNode
]
