Class {
	#name : #BlNodeBasedLayout,
	#superclass : #BlLayout,
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #layout }
BlNodeBasedLayout >> layout: aParentLayoutNode [
]

{ #category : #layout }
BlNodeBasedLayout >> layout: anElement in: aRectangle [
	| aParentNode |
	
	self layoutIgnored: anElement.
	
	aParentNode := anElement userData
		at: #layoutNode
		ifAbsent: [ ^ self ].

	aParentNode extent: aRectangle extent.
	self layout: aParentNode.

	aParentNode children do: [ :eachChildNode |
		eachChildNode element applyLayoutIn: eachChildNode layoutBounds ]
]

{ #category : #measure }
BlNodeBasedLayout >> measure: aParentLayoutNode [
]

{ #category : #measure }
BlNodeBasedLayout >> measure: anElement with: anExtentSpec [
	| aParentNode |

	aParentNode := (BlLayoutParentNode toMeasure: anElement) extentSpec: anExtentSpec.

	self measure: aParentNode.

	anElement measuredExtent: aParentNode extent.

	anElement userData at: #layoutNode put: aParentNode.
	
	aParentNode childrenDo: [ :eachChildNode |
		eachChildNode popActions do: [ :eachAction |
			eachAction measured: eachChildNode element: eachChildNode element ] ].

	self measureIgnored: anElement with: anExtentSpec
]

{ #category : #'private - measurement' }
BlNodeBasedLayout >> preMeasureChildrenNodes: aParentNode [
	"Perform a basic independent measurement of each child node"

	aParentNode childrenDo: [ :eachChildNode |
		eachChildNode measure: [
			(BlExtentMeasurementSpec new
				widthSpec: (self
					measurementSpecFor: aParentNode widthSpec
					usedSize: 0
					resizer: eachChildNode horizontalResizer);
				heightSpec: (self
					measurementSpecFor: aParentNode heightSpec
					usedSize: 0
					resizer: eachChildNode verticalResizer)) ] ]
]
