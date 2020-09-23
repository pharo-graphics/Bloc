"
I am a special layout that uses measured positions of children to determine parent's extent.

I should be considered to be a root of graph or visualisation layouts. For that purpose override measurePositions: with:
"
Class {
	#name : #BlFitLayout,
	#superclass : #BlLayout,
	#category : #'Bloc-Layout-Fit'
}

{ #category : #measure }
BlFitLayout >> childrenBoundingBox: aParentNode [
	<return: #Rectangle>
	| aBoundingBox |

	aParentNode children isEmpty
		ifTrue: [ ^ BlBounds new asRectangle ].

	aBoundingBox := nil.

	aParentNode children do: [ :aChild |
		aBoundingBox
			ifNil: [ aBoundingBox := aChild measuredBounds inParent asBounds ]
			ifNotNil: [ aBoundingBox merge: aChild measuredBounds inParent asBounds ] ].

	^ aBoundingBox expanded asRectangle
]

{ #category : #layout }
BlFitLayout >> layout: aParentNode [
	| aDelta |
	aDelta := self normalizedDelta: aParentNode.

	aParentNode childrenDo: [ :eachChildNode | eachChildNode layoutBounds: (eachChildNode measuredBounds translateBy: aDelta) ]
]

{ #category : #layout }
BlFitLayout >> layout: anElement in: aRectangle [
	| aParentNode |
	
	self layoutIgnored: anElement.
	
	aParentNode := anElement userData
		at: #layoutNode
		ifAbsent: [ ^ self ].
		
	aParentNode layoutExtent: aRectangle extent.

	self layout: aParentNode.

	aParentNode children do: [ :eachChildNode |
		eachChildNode element applyLayoutIn: eachChildNode layoutBounds ]
]

{ #category : #measure }
BlFitLayout >> measure: aParentLayoutNode [
	"Override me to implement a custom child position measurement algorithm.
	Graph or visualisation layouts should implement me"
	
	self measureChildrenNodes: aParentLayoutNode.
	self measureParentNode: aParentLayoutNode
]

{ #category : #measure }
BlFitLayout >> measure: anElement with: anExtentSpec [
	| aParentNode |

	self measuredChildren: anElement do: [ :aChild |
		self
			measureChild: aChild
			parentSpec: anExtentSpec ].

	aParentNode := (BlLayoutParentNode alreadyMeasured: anElement) extentSpec: anExtentSpec.

	self measure: aParentNode.

	aParentNode children do: [ :eachChildNode |
		eachChildNode element measuredBounds position: eachChildNode measurement position.
		eachChildNode element measuredBounds extent: eachChildNode measurement extent ].
	
	anElement measuredExtent: aParentNode measuredExtent.

	anElement userData at: #layoutNode put: aParentNode.
	
	self measureIgnored: anElement with: anExtentSpec
]

{ #category : #measure }
BlFitLayout >> measureChildrenNodes: aParentLayoutNode [
	"Override me to implement a custom child position measurement algorithm.
	Graph or visualisation layouts should implement me"
]

{ #category : #measure }
BlFitLayout >> measureParentNode: aParentNode [
	"Compute the measured extent of the parent node based on the measured bounds of the children"
	| boundingBox width height |

	boundingBox := self childrenBoundingBox: aParentNode.

	width := boundingBox width + aParentNode padding width.
	height := boundingBox height + aParentNode padding height.

	aParentNode measuredExtent: (aParentNode extentSpec sizeFor: width @ height)
]

{ #category : #layout }
BlFitLayout >> normalizedDelta: aParentLayoutNode [
	| boundingBox delta |

	boundingBox := self childrenBoundingBox: aParentLayoutNode.
	delta := ((aParentLayoutNode layoutExtent / 2.0) - boundingBox center).

	^ delta
]
