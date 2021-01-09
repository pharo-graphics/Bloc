"
! Layout that wraps an element around its children
"
Class {
	#name : #BlWrapAroundChildrenLayout,
	#superclass : #BlCompositeLayout,
	#category : #'Bloc-Layout-Fit'
}

{ #category : #layout }
BlWrapAroundChildrenLayout >> layout: aParentLayoutNode [
	| anOrigin |
	super layout: aParentLayoutNode.

	"first we should find the position of the top-left child"
	anOrigin := aParentLayoutNode children boundingBox origin.
	
	"we move all children so that the most top-left child has position 0@0"
	aParentLayoutNode childrenDo: [ :eachChild | eachChild position: eachChild position - anOrigin ].
	"it also means that the position of the parent must be adjusted too, in this case exactly by the same amount by which
	all children were moved, to compensate their movement"
	aParentLayoutNode position: aParentLayoutNode position + anOrigin
]

{ #category : #protected }
BlWrapAroundChildrenLayout >> mayInfluencePosition [
	^ true
]

{ #category : #measure }
BlWrapAroundChildrenLayout >> measure: aParentLayoutNode [
	"Compute the measured extent of the parent node based on the measured bounds of the children"
	| boundingBox width height |
	super measure: aParentLayoutNode.

	boundingBox := aParentLayoutNode children boundingBox.

	width := boundingBox width + aParentLayoutNode padding width.
	height := boundingBox height + aParentLayoutNode padding height.

	aParentLayoutNode extent: (aParentLayoutNode extentSpec sizeFor: width @ height)
]
