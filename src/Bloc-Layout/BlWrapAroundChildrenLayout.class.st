Class {
	#name : #BlWrapAroundChildrenLayout,
	#superclass : #BlCompositeLayout,
	#category : #'Bloc-Layout-Fit'
}

{ #category : #layout }
BlWrapAroundChildrenLayout >> layout: aParentLayoutNode [
	| anOrigin |
	super layout: aParentLayoutNode.

	anOrigin := aParentLayoutNode children boundingBox origin.

	aParentLayoutNode childrenDo: [ :eachChild | eachChild position: eachChild position - anOrigin ].
	aParentLayoutNode position: aParentLayoutNode position + anOrigin
]

{ #category : #protected }
BlWrapAroundChildrenLayout >> mayInfluencePosition [
	^ true
]

{ #category : #measure }
BlWrapAroundChildrenLayout >> measure: aParentLayoutNode [
	super measure: aParentLayoutNode.

	self measureParentNode: aParentLayoutNode
]

{ #category : #measure }
BlWrapAroundChildrenLayout >> measureParentNode: aParentLayoutNode [
	"Compute the measured extent of the parent node based on the measured bounds of the children"
	| boundingBox width height |

	boundingBox := aParentLayoutNode children boundingBox.

	width := boundingBox width + aParentLayoutNode padding width.
	height := boundingBox height + aParentLayoutNode padding height.

	aParentLayoutNode extent: (aParentLayoutNode extentSpec sizeFor: width @ height)
]
