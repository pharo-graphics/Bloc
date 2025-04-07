"
# Frame layout

I am a layout designed to block out an area on the screen to display a single child. 

I should be mainly used to display a single child, as it can be difficult to display multiple children at different positions on the screen without overlapping each other. 
However, elements with a frame layout can have multiple child elements. The `'weight'` and `'alignment'` attributes can be used to control the position of children. However, weight only works when the child matches the parent; if it fits content or has an exact size, the weight attribute is ignored. I rely on custom layout constraints for setting  attributes (see `BlFrameLayoutConstraints`, `BlFrameLayoutConstraintsHorizontal` and `BlFrameLayoutConstraintsVertical`).

I position each child element based on the top left of the screen. Child elements are stacked on top of each other, with the most recently added child on top. An important property is that the location of a child is independent from the location of other children. 

I am similar to the frame layout from Android. The main differences are that I:
- provide support for controlling the size of a child element using the `'weight'`  attribute;
- the `'gravity'`  attribute is not present; instead the `'alignment'`  attribute should be used.

## Alignment
The alignment attribute controls the position of children within a FrameLayout. Children can be aligned both vertically and horizontally as follows:
- horizontally children can be aligned to left, center or right;
- vertically children can be aligned to top, center or bottom.

For example, below we align a fixed-size child horizontally to the right and vertically to the bottom. Alignment is a constraint specific to frame layouts, as it's not relevant to all layouts. To access frame-specific contraints, we send `BlLayoutCommonConstraints>>#frame` to the current constraint object, which returns an instance of `BlFrameLayoutConstraints` that we can use to set the desired alignment. Other constraints like the size of an element are common to all layouts and can be set directly without requesting a specific constraint object. Both cases are illustrated by the following example:
{{gtExample:BlFrameLayoutSingleChildExamples>>#elementDocumentationWithOneExactChildAlignBottomRightInExactParent|previewExpanded|previewHeight=400}}

When using multiple children, if we do not specify any alignment they will be placed in the top-left corner in the order in which they were added to the parent.
{{gtExample:BlFrameLayoutMultipleChildrenExamples>>#elementWithTwoExactChildrenAndNoAlignment|previewExpanded|previewHeight=400}}

With an alignment, we can better arrange these children. For example, we can place one to the right and center it. This will result in no overlapping.
{{gtExample:BlFrameLayoutMultipleChildrenExamples>>#elementWithExactChildAlignTopLeftAndExactChildRightCenter|previewExpanded|previewHeight=400}}

We can also use a different alignment that results in partial overapping. 
{{gtExample:BlFrameLayoutMultipleChildrenExamples>>#elementWithExactChildAlignLeftCenterAndExactChildCenter|previewExpanded|previewHeight=400}}

Here is an example of more advanced child placement:
{{gtExample:BlFrameLayoutCompositionExamples>>#example|previewExpanded|previewHeight=400}}

To wrap up, below are all nine ways in which we can place a child using alignment.
{{gtExample:BlFrameLayoutMultipleChildrenExamples>>#elementWithNineExactChildrenWithAllAlignments|previewExpanded|previewHeight=400}}

## Weight
Above we saw that one way to set the size of a child element is by using an exact size. A second option is for a child to match the size of the parent. In this case, children that match their parent can also be configured to occupy only a fraction of the parent's size using the `weight` attribute.

A child can match its parent both horizontally and vertically. If no padding or margin is used, the child will overlap the parent completely.
{{gtExample:BlFrameLayoutSingleChildExamples>>#elementWithOneChildMatchExactParent|previewExpanded|previewHeight=400}}

Let's try adding some padding so we can see that, indeed, the parent is also rendered.
{{gtExample:BlFrameLayoutSingleChildExamples>>#elementWithOneChildMatchExactParentWithPadding|previewExpanded|previewHeight=400}}

By indicating a weight value when the child matches its parent, we can control the actual space it occupies. For example, in the code below the child takes 90% of the space horizontally and 50% vertically, starting from the top left corner. 
{{gtExample:BlFrameLayoutSingleChildExamples>>#elementForDocumentationWithOneChildMatchExactParentWithWeight|previewExpanded|previewHeight=400}}

We can also have multiple children that match the same parent and take different proportions of the available space, as in the following example.
{{gtExample:BlFrameLayoutMultipleChildrenExamples>>#elementWithTwoChildrenMatchingParentWithWeight|previewExpanded|previewHeight=400}}

Setting this attribute only works when the element matches its parent. In other scenarios, like when the element has a fixed size, any weight specified will be ignored.
{{gtExample:BlFrameLayoutSingleChildExamples>>#elementWithOneChildWithExactSizeParentWithWeight|previewExpanded|previewHeight=400}}

If a child element has an alignment in addition to a fixed size, the weight will also be ignored.
{{gtExample:BlFrameLayoutSingleChildExamples>>#elementWithOneExactChildAlignBottomCenterAndWithWeightInExactParent|previewExpanded|previewHeight=400}}

## Fit content in parent 
The previous examples assumened that the parent had a fixed size. That, or having the parent use a ""match parent"" strategy are the common ways to use a frame layout. It is however also possible to have the parent match to its content, if the child has a fixed size. In that case, the parent size will be the same a the child's, if no padding or margin is used.
{{gtExample:BlFrameLayoutSingleChildExamples>>#elementWithOneExactChildAndFitContentParent|previewExpanded|previewHeight=400}}
 
This also works in case multiple children are present having different sizes.
{{gtExample:BlFrameLayoutMultipleChildrenExamples>>#elementWithTwoExactChildrenAndFitContentParent|previewExpanded|previewHeight=400}}

However, this will not work when the parent uses ""fit content"" and the child uses ""match parent"", as there is no way to determine the size. In such cases, the size of both the parent and the child will be `0@0`.
{{gtExample:BlFrameLayoutSingleChildExamples>>#elementWithOneMatchParentChildAndFitContentParent|previewExpanded|previewHeight=400}}

## More examples
For more example on how to use frame layouts, check out these classes:
- `BlFrameLayoutSingleChildExamples`
- `BlFrameLayoutMultipleChildrenExamples`
- `BlFrameLayoutCompositionExamples`


"
Class {
	#name : #BlFrameLayout,
	#superclass : #BlNodeBasedLayout,
	#category : #'Bloc-Layout-Frame'
}

{ #category : #constraints }
BlFrameLayout class >> constraints [
	^ BlFrameLayoutConstraints new
]

{ #category : #'api - alignment' }
BlFrameLayout >> align: aChildElement horizontal: aBlAlignment [

	aChildElement constraintsDo: [ :c |
		(c at: self class) horizontal alignment: aBlAlignment ]
]

{ #category : #'api - alignment' }
BlFrameLayout >> align: aChildElement vertical: aBlAlignment [

	aChildElement constraintsDo: [ :c |
		(c at: self class) vertical alignment: aBlAlignment ]
]

{ #category : #private }
BlFrameLayout >> canMeasureNodeFirstPass: aChild parentSpec: anExtentSpec [
	"Return true if we can measure a given child during the first measurement pass given that we received the provided parent extent spec, false otherwise"

	| canMeasureWidth canMeasureHeight |
	
	"if parent spec is exact, we can definitely measure"
	anExtentSpec isExact ifTrue: [ ^ true ].

	canMeasureWidth := anExtentSpec widthSpec isExact
		or: [ aChild isHorizontalMatchParent not ].
	canMeasureHeight := anExtentSpec heightSpec isExact
		or: [ aChild isVerticalMatchParent not ].

	^ canMeasureWidth and: [ canMeasureHeight ]
]

{ #category : #layout }
BlFrameLayout >> layout: aParentNode [

	| parentBounds |

	"first store parent's local bounds"
	parentBounds := aParentNode padding inset: (0.0@0.0 extent: aParentNode extent).

	aParentNode childrenDo: [ :eachChildNode |
		| childBounds allowedBounds aTranslation alignment |

		"ask child for its measured bounds"
		childBounds := eachChildNode bounds.
		allowedBounds := eachChildNode margin inset: parentBounds.

		"a composite alignment"
		alignment := eachChildNode constraints frame alignment directed: self direction.
		aTranslation := alignment translationOf: childBounds in: allowedBounds.

		"and finally set new bounds"
		eachChildNode position: (childBounds position + aTranslation) ]
]

{ #category : #measure }
BlFrameLayout >> measure: aParentNode [

	self preMeasureChildrenNodes: aParentNode.
	self measureParentNode: aParentNode.
	self postMeasureChildrenNodes: aParentNode
]

{ #category : #measure }
BlFrameLayout >> measureParentNode: aParentNode [
	"Compute the measured extent of the parent node based on the measured extents of the children and their weight"

	| maxExtent aMeasuredExtent |
	maxExtent := 0.0 @ 0.0.

	aParentNode childrenDo: [ :eachChildNode | 
		| aWeightX aWeightY aProportion |
		aWeightX := eachChildNode constraints frame horizontal weight.
		aWeightY := eachChildNode constraints frame vertical weight.

		aProportion :=
			(aWeightX isZero
				ifTrue: [ 0.0 ]
				ifFalse: [ 1.0 / aWeightX ])
					@ (aWeightY isZero
						ifTrue: [ 0.0 ]
						ifFalse: [ 1.0 / aWeightY ]).
		maxExtent := maxExtent max:
			(eachChildNode extent * aProportion) + eachChildNode margin extent ].

	maxExtent := maxExtent + aParentNode padding extent.
	maxExtent := maxExtent
		min: aParentNode maxExtent
		max: aParentNode minExtent.

	aMeasuredExtent := aParentNode extentSpec sizeFor: maxExtent.

	aMeasuredExtent := aMeasuredExtent
		min: aParentNode maxExtent
		max: aParentNode minExtent.

	aParentNode extent: aMeasuredExtent
]

{ #category : #private }
BlFrameLayout >> measurementSpecFor: aChildNode parentExtent: aParentExtent [
	
	| aParentWidth aParentHeight childWidthMeasureSpec childHeightMeasureSpec |
	aParentWidth := aParentExtent x.
	aParentHeight := aParentExtent y.

	aChildNode isHorizontalMatchParent
		ifTrue: [ 
			| weight width |
			weight := (aChildNode constraints frame horizontal weight max: 0.0).
			width := ((aParentWidth - aChildNode parent padding width - aChildNode margin width) * weight) max: aChildNode constraints minWidth.
			childWidthMeasureSpec := BlMeasurementSpec exact: width ]
		ifFalse: [ 
			childWidthMeasureSpec := self
				measurementSpecFor: aChildNode parent widthSpec
				usedSize: aChildNode parent padding width + aChildNode padding width
				resizer: aChildNode horizontalResizer ].
 
	aChildNode isVerticalMatchParent
		ifTrue: [ 
			| weight height |
			weight := (aChildNode  constraints frame vertical weight max: 0.0).
			height := ((aParentHeight - aChildNode parent padding height - aChildNode margin height) * weight) max: aChildNode constraints minHeight.
			childHeightMeasureSpec := BlMeasurementSpec exact: height ]
		ifFalse: [ 
			childHeightMeasureSpec := self
				measurementSpecFor: aChildNode parent heightSpec
				usedSize: aChildNode parent padding height + aChildNode margin height
				resizer: aChildNode verticalResizer ].

	^ childWidthMeasureSpec @ childHeightMeasureSpec
]

{ #category : #measure }
BlFrameLayout >> postMeasureChildrenNodes: aParentNode [

	aParentNode childrenDo: [ :eachChildNode |
		eachChildNode measure: [
			self
				measurementSpecFor: eachChildNode
				parentExtent: aParentNode extent ] ]
]

{ #category : #measure }
BlFrameLayout >> preMeasureChildrenNodes: aParentNode [
	"Perform a first measurement pass and measure those children for which we can
	determine an extent, otherwise skip them"

	| aConstrainedExtentSpec |
	aConstrainedExtentSpec := aParentNode extentSpec
		                          min: aParentNode minExtent
		                          max: aParentNode maxExtent.

	aParentNode childrenDo: [ :eachChildNode |
		(self
			 canMeasureNodeFirstPass: eachChildNode
			 parentSpec: aConstrainedExtentSpec) ifTrue: [
			eachChildNode measure: (self
					 preMeasurementSpecFor: eachChildNode
					 parentSpec: aConstrainedExtentSpec) ] ]
]

{ #category : #private }
BlFrameLayout >> preMeasurementSpecFor: aChildNode parentSpec: aParentSpec [

	| aParentWidth aParentHeight |
	aParentWidth := aParentSpec widthSpec size.
	aParentHeight := aParentSpec heightSpec size.

	^ self
		measurementSpecFor: aChildNode
		parentExtent: aParentWidth @ aParentHeight
]
