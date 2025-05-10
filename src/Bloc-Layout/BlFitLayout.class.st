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

	| aBoundingBox |
	aParentNode children isEmpty ifTrue: [
		^ Rectangle left: 0 right: 0 top: 0 bottom: 0 ].

	aBoundingBox := aParentNode children first bounds.
	aParentNode children allButFirstDo: [ :aChild |
		aBoundingBox merge: aChild bounds ].

	aBoundingBox expand.
	
	^ aBoundingBox asRectangle
]

{ #category : #layout }
BlFitLayout >> computeAlignmentTranslation: aParentLayoutNode [

	| boundingBox delta |

	boundingBox := self childrenBoundingBox: aParentLayoutNode.
	delta := ((aParentLayoutNode extent / 2.0) - boundingBox center).

	^ delta
]

{ #category : #layout }
BlFitLayout >> layout: aParentNode [

	| aDelta |
	aDelta := self computeAlignmentTranslation: aParentNode.

	aParentNode childrenDo: [ :eachChildNode |
		eachChildNode position: eachChildNode position + aDelta ]
]

{ #category : #layout }
BlFitLayout >> layout: anElement in: aRectangle context: aBlElementBoundsUpdater [

	| aParentNode |
	self layoutIgnored: anElement context: aBlElementBoundsUpdater.

	aParentNode :=
		anElement userData
			at: #layoutNode
			ifAbsent: [ ^ self ].

	aParentNode extent: aRectangle extent.

	self layout: aParentNode.

	aParentNode children do: [ :eachChildNode |
		eachChildNode element
			applyLayoutIn: eachChildNode layoutBounds
			context: aBlElementBoundsUpdater ]
]

{ #category : #measure }
BlFitLayout >> measure: aParentLayoutNode [
	"Override me to implement a custom child position measurement algorithm.
	Graph or visualisation layouts should implement me"

	self measureChildrenPositions: aParentLayoutNode.
	self measureParentNode: aParentLayoutNode
]

{ #category : #measure }
BlFitLayout >> measure: anElement with: anExtentSpec [

	| aParentNode |
	self
		measuredChildren: anElement
		do: [ :aChild | self measureChild: aChild parentSpec: anExtentSpec ].

	aParentNode :=
		(BlLayoutParentNode alreadyMeasured: anElement) extentSpec: anExtentSpec.

	self measure: aParentNode.

	anElement measuredExtent: aParentNode extent.

	anElement userData at: #layoutNode put: aParentNode.

	self measureIgnored: anElement with: anExtentSpec
]

{ #category : #measure }
BlFitLayout >> measureChildrenPositions: aParentLayoutNode [
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

	aParentNode extent:
		(aParentNode extentSpec sizeForWidth: width height: height)
]
