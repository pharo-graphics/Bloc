"
I am a special layout that uses measured positions of children to determine parent's extent. This will only work if my sub-layouts assign positions during the measurement step. Graph layouts is a good example.

I should be considered to be a parent of the graph or visualisation layouts

"
Class {
	#name : #BlFitChildrenLayout,
	#superclass : #BlCompositeLayout,
	#category : #'Bloc-Layout-Fit'
}

{ #category : #layout }
BlFitChildrenLayout >> computeAlignmentTranslation: aParentLayoutNode [
	| boundingBox delta |

	boundingBox := aParentLayoutNode children boundingBox.
	delta := ((aParentLayoutNode extent / 2.0) - boundingBox center).

	^ delta
]

{ #category : #layout }
BlFitChildrenLayout >> layout: aParentNode [
	| aTranslation |
	super layout: aParentNode.

	aTranslation := self computeAlignmentTranslation: aParentNode.

	aParentNode childrenDo: [ :eachChildNode | eachChildNode position: (eachChildNode position + aTranslation) ]
]

{ #category : #measure }
BlFitChildrenLayout >> measure: aParentLayoutNode [
	super measure: aParentLayoutNode.

	self measureParentNode: aParentLayoutNode
]

{ #category : #measure }
BlFitChildrenLayout >> measureParentNode: aParentLayoutNode [
	"Compute the measured extent of the parent node based on the measured bounds of the children"

	| boundingBox width height |
	boundingBox := aParentLayoutNode children boundingBox.

	width := boundingBox width + aParentLayoutNode padding width.
	height := boundingBox height + aParentLayoutNode padding height.

	aParentLayoutNode extent:
		(aParentLayoutNode extentSpec sizeForWidth: width height: height)
]
