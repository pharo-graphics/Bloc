Class {
	#name : #BlNodeBasedLayout,
	#superclass : #BlLayout,
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #layout }
BlNodeBasedLayout >> layout: aParentLayoutNode [
]

{ #category : #layout }
BlNodeBasedLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdateContext [
	| aParentNode |
	
	self layoutIgnored: anElement context: aBlElementBoundsUpdateContext.
	
	aParentNode := anElement userData
		at: #layoutNode
		ifAbsent: [ ^ self ].
	
	aParentNode position: aRectangle origin.
	aParentNode extent: aRectangle extent.
	self layout: aParentNode.

	"the layout wants to change my position"
	aParentNode position = aRectangle origin
		ifFalse: [
			anElement
				position: aParentNode position
				extent: aRectangle extent
				context: aBlElementBoundsUpdateContext ].

	aParentNode children do: [ :eachChildNode |
		eachChildNode element applyLayoutIn: eachChildNode layoutBounds context: aBlElementBoundsUpdateContext ].
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
BlNodeBasedLayout >> preMeasureChildNode: aChildNode [
	"Perform a basic independent measurement of each child node"

	aChildNode measure: [
		(BlExtentMeasurementSpec
			widthSpec: (self
				measurementSpecFor: aChildNode parent widthSpec
				usedSize: 0
				resizer: aChildNode horizontalResizer)
			heightSpec: (self
				measurementSpecFor: aChildNode parent heightSpec
				usedSize: 0
				resizer: aChildNode verticalResizer)) ]
]

{ #category : #'private - measurement' }
BlNodeBasedLayout >> preMeasureChildrenNodes: aParentNode [
	"Perform a basic independent measurement of each child node"

	aParentNode childrenDo: [ :eachChildNode | self preMeasureChildNode: eachChildNode ]
]
