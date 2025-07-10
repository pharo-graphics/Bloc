"
# Layout that helps an element to wrap around its children
Makes sure that the element wraps around its children, taking into account the position of each child and the `padding` of the container element. I am a composite layout and must be used together with some concrete layout that computes the initial positions of the children. `fitContent` is the only container's layout constraint that makes sense in the context of this layout. See an example below:
{{gtExample:BlWrapAroundChildrenLayoutExamples>>#containerWithNodes|previewExpanded=true|codeExpanded=false|previewShow=#gtLiveFor:|previewHeight=350}}

"
Class {
	#name : #BlWrapAroundChildrenLayout,
	#superclass : #BlCompositeLayout,
	#category : #'Bloc-Layout-Fit'
}

{ #category : #protected }
BlWrapAroundChildrenLayout >> isInfluencedByTransformation [
	^ true
]

{ #category : #layout }
BlWrapAroundChildrenLayout >> layout: aParentLayoutNode [
	| anOrigin anOriginWithPadding |
	super layout: aParentLayoutNode.

	"first we should find the position of the top-left child"
	anOrigin := aParentLayoutNode children boundingBox origin.
		
	anOriginWithPadding := anOrigin - aParentLayoutNode padding topLeft.

	"we move all children so that the most top-left child has position 0@0"
	aParentLayoutNode childrenDo: [ :eachChild |		
		eachChild position: eachChild position - anOriginWithPadding ].

	"it also means that the position of the parent must be adjusted too, in this case exactly by the same amount by which
	all children were moved, to compensate their movement and taking parent transformation into account"
	aParentLayoutNode transformationDo: [ :aTransformation |
		anOriginWithPadding := anOriginWithPadding + (aTransformation inverseTransformPoint: aParentLayoutNode padding topLeft).
		anOriginWithPadding := (aTransformation transformBounds: (BlBounds origin: 0@0 extent: anOriginWithPadding abs)) extent * anOriginWithPadding sign ].

	aParentLayoutNode position: aParentLayoutNode constraints position + anOriginWithPadding
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

	aParentLayoutNode extent:
		(aParentLayoutNode extentSpec extentForWidth: width height: height)
]
