Class {
	#name : #BlRelativeLayout,
	#superclass : #BlLayout,
	#category : #'Bloc-Layout-Relative'
}

{ #category : #constraints }
BlRelativeLayout class >> constraints [
	^ BlRelativeLayoutConstraints new
]

{ #category : #measure }
BlRelativeLayout >> layout: aParentLayoutNode [
	self measureRelativePositions: aParentLayoutNode
]

{ #category : #measure }
BlRelativeLayout >> measure: aParentLayoutNode [

	| aConstrainedExtentSpec |
	aConstrainedExtentSpec := aParentLayoutNode extentSpec
		min: aParentLayoutNode minExtent
		max: aParentLayoutNode maxExtent.

	aParentLayoutNode childrenDo: [ :eachChildNode |
		eachChildNode measure: [ self measurementSpecFor: eachChildNode parentSpec: aConstrainedExtentSpec ] ].

	self measureRelativePositions: aParentLayoutNode
]

{ #category : #measure }
BlRelativeLayout >> measureRelativePositions: aParentLayoutNode [
	| aLayoutNodeMap |
	
	aLayoutNodeMap := IdentityDictionary new.
	aParentLayoutNode childrenDo: [ :eachChildNode | aLayoutNodeMap at: eachChildNode constraints put: eachChildNode ].
	
	aParentLayoutNode childrenDo: [ :eachChildNode |
		| aRelativePosition |
		
		aRelativePosition := eachChildNode constraints relative position.
		aRelativePosition isUndefined
			ifFalse: [
				aLayoutNodeMap
					at: aRelativePosition anchorNode constraints
					ifPresent: [ :anAnchorNode |
						| aTranslation |
						
						aTranslation := aRelativePosition translationOf: eachChildNode bounds relativeTo: anAnchorNode bounds.
						eachChildNode position: eachChildNode position + aTranslation ] ] ]
]

{ #category : #measure }
BlRelativeLayout >> measurementSpecFor: aChildNode parentSpec: aParentSpec [

	| childWidthMeasureSpec childHeightMeasureSpec |

	childWidthMeasureSpec := self
		measurementSpecFor: aParentSpec widthSpec
		usedSize: aChildNode parent padding width + aChildNode padding width
		resizer: aChildNode horizontalResizer.

	childHeightMeasureSpec := self
		measurementSpecFor: aParentSpec heightSpec
		usedSize: aChildNode parent padding height + aChildNode margin height
		resizer: aChildNode verticalResizer.

	^ childWidthMeasureSpec @ childHeightMeasureSpec
]
