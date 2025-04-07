"
I am layout supposed to be used by infinite element to position children within visible bounds.
Concrete layouting algorithms used to support infinite amount of children differs from non-infinite case, meaning that normal layouts can not be used by infinite element.

# Animations

The `BlInfiniteLayout` is in charge of the behavior of item animations. By default, `BlInfiniteElement` has a non-null `#itemAnimator`, and simple item animations are enabled. This means that add/remove operations on the datasource will result in animations to add new or appearing items, removed or disappearing items, and moved items.

If a `BlInfiniteLayout` returns false from `#supportsPredictiveItemAnimations`, which is the default, and runs a normal layout operation during `#layoutChildrenIn: state:`, the `BlInfiniteElement` will have enough information to run those animations in a simple way. For example, the default `BlInfiniteItemAnimator`, will simply fade elements in and out, whether they are actually added/removed or whether they are moved on or off the screen due to other add/remove operations.

A `BlInfiniteLayout` wanting a better item animation experience, where items can be animated onto and off of the screen according to where the items exist when they are not on screen, then the `BlInfiniteLayout` should return true from `#supportsPredictiveItemAnimations` and add additional logic to `#layoutChildrenIn: state:`. Supporting predictive animations means that `#layoutChildrenIn: state:` will be called twice; once as a  layout step to determine where items would have been prior to a real layout, and again to do the 'real' layout. In the pre-layout phase, items will remember their pre-layout positions to allow them to be laid out appropriately. Also, removed (`BlInfiniteLayoutConstraints>>#isItemRemoved`) items will be returned from the scrap to help determine correct placement of other items. These removed items should not be added to the child list, but should be used to help calculate correct positioning of other elements, including elements that were not previously onscreen (referred to as APPEARING elements), but whose pre-layout offscreen position can be determined given the extra information about the pre-layout removed elements.

The second layout pass is the real layout in which only non-removed elements will be used. The only additional requirement during this pass is, if `#supportsPredictiveItemAnimations` returns true, to note which elements exist in the child list prior to layout and which are not there after layout (referred to as DISAPPEARING elements), and to position/layout those children appropriately, without regard to the actual bounds of the `BlInfiniteElement`. This allows the animation system to know the location to which to animate these disappearing elements.

The default `BlInfiniteLayout` implementations for `BlInfiniteElement` handle all of these requirements for animations already. Clients of `BlInfiniteElement` can either use one of these layouts directly or look at their implementations of `#layoutChildrenIn: state:` to see how they account for the APPEARING and DISAPPEARING e;ements.

"
Class {
	#name : #BlInfiniteLayout,
	#superclass : #BlLayout,
	#instVars : [
		'infiniteElement',
		'horizontalChildFinder',
		'verticalChildFinder',
		'width',
		'height',
		'heightSpec',
		'widthSpec',
		'autoMeasure',
		'measurementCacheEnabled',
		'smoothScroller',
		'announcer',
		'lastExactSize'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : #'Bloc-Infinite-Core'
}

{ #category : #constraints }
BlInfiniteLayout class >> constraints [
	^ BlInfiniteLayoutConstraints new
]

{ #category : #'children - add/remove' }
BlInfiniteLayout >> addChild: anElement [
	"Add an element to the currently attached infinite element if needed.
	Infinite Layouts should use me to add elements obtained from a Recycler using Recycler>>#elementFor:"

	self addChild: anElement at: 0
]

{ #category : #'children - add/remove' }
BlInfiniteLayout >> addChild: anElement at: anIndex [
	"If anIndex == 0 child will be added at the end"

	self addChild: anElement at: anIndex disappearing: false
]

{ #category : #'private - children' }
BlInfiniteLayout >> addChild: anElement at: anIndex disappearing: isDisappearing [

	| anElementHolder anInfiniteConstraints |
	anElementHolder := self elementHolderOf: anElement.
	anInfiniteConstraints := anElement constraints infinite.
	anElementHolder wasReturnedFromScrap
		ifTrue: [
			anElementHolder clearReturnedFromScrap.
			infiniteElement attachChild: anElement at: anIndex ]
		ifFalse: [
			anElement parent == infiniteElement
				ifTrue: [
					| currentIndex index |
					index := anIndex = 0
						         ifTrue: [ self childrenCount ]
						         ifFalse: [ anIndex ].
					currentIndex := infiniteElement childIndexOf: anElement.
					currentIndex <= 0 ifTrue: [
						self error:
							'Added element has infinite element as parent but is not a direct child of it' ].
					currentIndex ~= index ifTrue: [
						self moveChildFrom: currentIndex to: index ] ]
				ifFalse: [
					infiniteElement addChild: anElement at: anIndex.
					anInfiniteConstraints insetsDirty: true.
					self smoothScroller ifNotNil: [ :aSmoothScroller |
						aSmoothScroller isRunning ifTrue: [
							aSmoothScroller onChildAttached: anElement ] ] ] ].

	anInfiniteConstraints pendingInvalidate ifFalse: [ ^ self ].
	anInfiniteConstraints pendingInvalidate: false
]

{ #category : #accessing }
BlInfiniteLayout >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'private - assertions' }
BlInfiniteLayout >> assertNotInLayoutOrScroll [

	"During layout initialization infinite element may still be not set"
	infiniteElement ifNotNil: [ :anElement |
		anElement assertNotInLayoutOrScroll ]
]

{ #category : #'children - add/remove' }
BlInfiniteLayout >> attachChild: anElement at: anIndex [
	"Reattach a previously detached child element.
	If anIndex == 0 child will be attached at the end"
	infiniteElement attachChild: anElement at: anIndex
]

{ #category : #geometry }
BlInfiniteLayout >> baseline [
	"Returns offset of the Infinite elements's text baseline from the its top boundary.
	Returns -1 if there is no baseline."
	<return: #Number>

	^ -1
]

{ #category : #'children - geometry' }
BlInfiniteLayout >> bottomDecorationHeight: anElement [
	"Returns the total width of item decorations applied to child's bottom"
	<return: #Number>
	| anInsets |

	anInsets := anElement constraints infinite decorationInsets.
	^ anInsets bottom
]

{ #category : #'children - geometry' }
BlInfiniteLayout >> boundsInParent: anElement includeDecoration: shouldIncludeDecoration [
	"Calculate the bounding box of the Element while taking into account its matrix changes
	(translation, scale etc) with respect to the InfiniteElement.
	If shouldIncludeDecoration is true, they are applied first before applying
	the Elements's matrix so that the decor offsets also go through the same transformation"
	<return: #Rectangle>
	| aLocalBounds |

	aLocalBounds := shouldIncludeDecoration
		ifTrue: [ anElement constraints infinite decorationInsets expand: anElement boundsInLocal ]
		ifFalse: [ anElement boundsInLocal ].
	
	^ (anElement localBoundsToParent: (BlBounds fromRectangle: aLocalBounds)) asRectangle
]

{ #category : #'measurement - computation' }
BlInfiniteLayout >> calculateChildMeasureSpec: aParentSize parentSpec: aParentSpec padding: aPadding childResizer: aChildResizer canScroll: canScroll [
	"Calculate a MeasurementSpec for measuring a child element in one dimension"
	<return: #BlMeasurementSpec>

	| aSize |
	
	aSize := (aParentSize - aPadding) max: 0.0.
	
	aChildResizer isExact
		ifTrue: [ ^ BlMeasurementSpec exact: aChildResizer size ].	
	
	canScroll
		ifTrue: [
			aChildResizer isMatchParent
				ifTrue: [
					aParentSpec isAtMost
						ifTrue: [ ^ BlMeasurementSpec atMost: aSize ].
					aParentSpec isExact
						ifTrue: [ ^ BlMeasurementSpec exact: aSize ].
					aParentSpec isUnspecified
						ifTrue: [ ^ BlMeasurementSpec unspecified ] ]
				ifFalse: [
					aChildResizer isFitContent
						ifTrue: [ ^ BlMeasurementSpec unspecified ] ] ]
		ifFalse: [ 
			aChildResizer isMatchParent
				ifTrue: [ ^ BlMeasurementSpec size: aSize mode: aParentSpec mode ].
			aChildResizer isFitContent
				ifTrue: [ 
					(aParentSpec isAtMost or: [ aParentSpec isExact ])
						ifTrue: [ ^ BlMeasurementSpec atMost: aSize ]
						ifFalse: [ ^ BlMeasurementSpec unspecified ] ] ].
	
	^ BlMeasurementSpec unspecified
]

{ #category : #'private - measurement' }
BlInfiniteLayout >> calculateSize: aMeasurementSpec desired: aDesiredSize min: aMinSize [
	"Answer the size from the given measurement specs and parameters that
	is closer to the desired size and also complies with the spec.
	The desired and minimum sizes must be numbers that satisfy `#isBlocFiniteFloat`."

	aMeasurementSpec isExact
		ifTrue: [ ^ aMeasurementSpec size ].
	
	aMeasurementSpec isAtMost
		ifTrue: [ ^ aMeasurementSpec size min: (aDesiredSize max: aMinSize) ].
	
	"Unspecified and the rest of types if any"
	^ aDesiredSize max: aMinSize
]

{ #category : #'scrolling - testing' }
BlInfiniteLayout >> canScrollHorizontally [
	"Return true if I can scroll the current contents horizontally, false otherwise"

	^ false
]

{ #category : #'scrolling - testing' }
BlInfiniteLayout >> canScrollVertically [
	"Return true if I can scroll the current contents vertically, false otherwise"
	<return: #Boolean>

	^ false
]

{ #category : #'children - accessing' }
BlInfiniteLayout >> childAt: anIndex [
	"Return a child element at the given index"
	<return: #BlElement>
	
	^ infiniteElement childAt: anIndex
]

{ #category : #'children - accessing' }
BlInfiniteLayout >> childAtPosition: aPosition [
	"Finds the element which represents the given datasource position.
	I traverse each child since I have no information about child order.
	Override me to improve performance if your infinite layout keeps data about child elements"

	<return: #BlElement or: nil>
	1 to: self childrenCount do: [ :anIndex |
		| anElement anElementHolder |
		anElement := self childAt: anIndex.
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder ifNotNil: [ :aHolder |
			(aHolder position = aPosition and: [
				 aHolder shouldIgnore not and: [ aHolder isRemoved not ] ])
				ifTrue: [ ^ anElement ] ] ].
	^ nil
]

{ #category : #'children - accessing' }
BlInfiniteLayout >> childContainingItemElement: anElement [
	"Traverses the ancestors of the given element and returns the item view that contains it and
	also my direct child. Returned element can be used to get the ElementHolder by sending #childHolderOf:
	Return nil if such element was not found or if the element is a child of the InfiniteElement but not a child of the InfiniteLayout
	which may happen if, for example, we are running a disappear animation"
	<return: #BlElement or: nil>
	
	^ infiniteElement childContainingItemElement: anElement
]

{ #category : #'children - accessing' }
BlInfiniteLayout >> childPositionOf: anElement [
	"Returns the datasource position of the item represented by the given Element.
	This does not contain any datasource changes that might have happened after the last layout"

	^ anElement constraints infinite elementLayoutPosition
]

{ #category : #'children - accessing' }
BlInfiniteLayout >> childrenCount [
	"Return the current number of child elements attached to the parent infinite element.
	This does not include children that were temporarily detached and/or scrapped."

	^ infiniteElement childrenCount
]

{ #category : #'children - accessing' }
BlInfiniteLayout >> childrenDo: aBlock [

	1 to: self childrenCount do: [ :anIndex |
		aBlock cull: (self childAt: anIndex) cull: anIndex ]
]

{ #category : #'scrolling - thumb' }
BlInfiniteLayout >> computeHorizontalScrollExtent [
	"Compute and return the horizontal extent of the scrollbar's thumb.
	Override me if you want to support scroll bars."
	<return: #Number>

	^ 0
]

{ #category : #'scrolling - thumb' }
BlInfiniteLayout >> computeHorizontalScrollOffset [
	^ 0
]

{ #category : #'scrolling - thumb' }
BlInfiniteLayout >> computeHorizontalScrollRange [
	^ 0
]

{ #category : #'scrolling - thumb' }
BlInfiniteLayout >> computeVerticalScrollExtent [
	"Compute and return the vertical extent of the scrollbar's thumb.
	Override me if you want to support scroll bars."
	<return: #Number>

	^ 0
]

{ #category : #'scrolling - thumb' }
BlInfiniteLayout >> computeVerticalScrollOffset [

	^ 0
]

{ #category : #'scrolling - thumb' }
BlInfiniteLayout >> computeVerticalScrollRange [
	^ 0
]

{ #category : #accessing }
BlInfiniteLayout >> dataSource [
	^ infiniteElement dataSource
]

{ #category : #'children - geometry' }
BlInfiniteLayout >> decoratedBottom: anElement [
	"Returns the bottom edge of the given child element within its parent, offset by any applied ItemDecoration"
	<return: #Number>

	^ anElement bounds inParent bottom + (self bottomDecorationHeight: anElement)
]

{ #category : #'children - geometry' }
BlInfiniteLayout >> decoratedBoundsWithMargins: anElement [
	"Returns the bounds of the child element including its decoration and margins"
	<return: #Rectangle>

	^ infiniteElement decoratedBoundsWithMargins: anElement
]

{ #category : #'children - geometry' }
BlInfiniteLayout >> decoratedLeft: anElement [
	"Returns the left edge of the given child element within its parent, offset by any applied ItemDecoration"
	<return: #Number>

	^ anElement bounds inParent left - (self leftDecorationWidth: anElement)
]

{ #category : #'children - geometry' }
BlInfiniteLayout >> decoratedMeasuredHeight: anElement [
	"Return the measured height of the given child, plus the additional size of any insets applied by ItemDecoration"
	<return: #Number>
	| anInsets |
	
	anInsets := anElement constraints infinite decorationInsets.
	^ anElement measuredHeight + anInsets height
]

{ #category : #'children - geometry' }
BlInfiniteLayout >> decoratedMeasuredWidth: anElement [
	"Return the measured width of the given child, plus the additional size of any insets applied by ItemDecoration"
	<return: #Number>
	| anInsets |

	anInsets := anElement constraints infinite decorationInsets.
	^ anElement measuredWidth + anInsets width
]

{ #category : #'children - geometry' }
BlInfiniteLayout >> decoratedRight: anElement [
	"Returns the right edge of the given child element within its parent, offset by any applied ItemDecoration"
	<return: #Number>

	^ anElement bounds inParent right + (self rightDecorationWidth: anElement)
]

{ #category : #'children - geometry' }
BlInfiniteLayout >> decoratedTop: anElement [
	"Returns the top edge of the given child element within its parent, offset by any applied ItemDecoration"
	<return: #Number>

	^ anElement bounds inParent top - (self topDecorationHeight: anElement)
]

{ #category : #initialization }
BlInfiniteLayout >> defaultAutoMeasure [
	^ false
]

{ #category : #measurement }
BlInfiniteLayout >> defaultMeasure: anElement with: anExtentSpec [
	| aWidth aHeight |

	aWidth := self
		calculateSize: anExtentSpec widthSpec
		desired: self paddingLeft + self paddingRight
		min: self minimumWidth.
	
	aWidth := aWidth min: self maximumWidth.
	
	aHeight := self
		calculateSize: anExtentSpec heightSpec
		desired: self paddingTop + self paddingBottom
		min: self minimumHeight.
		
	aHeight := aHeight min: self maximumHeight.
	
	anElement measuredExtent: aWidth @ aHeight
]

{ #category : #'children - add/remove' }
BlInfiniteLayout >> detachAndScrapAttachedChildren [
	"Temporarily detach and scrap all currently attached child element.
	Elements will be scrapped into the InfiniteRecycler.
	The Recycler may prefer to reuse scrap elements before other elements that were previously recycled"
	
	self reverseChildrenDo: [ :anElement :anIndex |
		self scrapOrRecycleChild: anElement at: anIndex ]
]

{ #category : #'children - add/remove' }
BlInfiniteLayout >> detachChild: anElement [
	"Temporarily detach a child element"

	self detachChildAt: (infiniteElement childIndexOf: anElement)
]

{ #category : #'children - add/remove' }
BlInfiniteLayout >> detachChildAt: anIndex [
	"Temporarily detach a child element at the index"

	infiniteElement detachChildAt: anIndex
]

{ #category : #'children - accessing' }
BlInfiniteLayout >> elementHolderOf: anElement [
	"Return an element holder assigned to aChildElement.
	Element holder can not be nil"
	<return: #BlInfiniteHolder>

	^ infiniteElement elementHolderOf: anElement
]

{ #category : #initialization }
BlInfiniteLayout >> exactMeasurementSpecFrom: anInfiniteElement [

	self measurementSpec:
		(BlExtentMeasurementSpec exact: anInfiniteElement extent)
]

{ #category : #focus }
BlInfiniteLayout >> focusedChild [
	"Return direct child of infinite element which has focus or contains the focused child"
	<return: #BlElement or: nil>
	
	^ infiniteElement focusedChild
]

{ #category : #'children - testing' }
BlInfiniteLayout >> hasChildren [
	"Return true if there are children attached to the parent infinite element"
	<return: #Boolean>

	^ self childrenCount > 0
]

{ #category : #testing }
BlInfiniteLayout >> hasFlexibleChildInBothOrientations [
	"Return true if there are children with non-exact resizer"
	<return: #Boolean>
	
	self childrenDo: [ :anElement |
		(anElement constraints horizontal resizer isExact or: [ 
			anElement constraints vertical resizer isExact ])
				ifFalse: [ ^ true ] ].
	^ false
]

{ #category : #focus }
BlInfiniteLayout >> hasFocus [
	"Return true if the infinite element I am bound to has or contains focus"
	
	^ infiniteElement hasFocus
]

{ #category : #geometry }
BlInfiniteLayout >> height [
	"Returns the height that is currently relevant to the layout.

	This value is usually equal to the laid out height of the InfiniteElement
	but may reflect the current MeasurementSpec height if the InfiniteLayout
	is using AutoMeasure and the InfiniteElement is in the process of measuring.
	
	The InfiniteLayout must always use this method to retrieve the height relevant to it at any given time."
	<return: #Number>
	
	^ height
]

{ #category : #geometry }
BlInfiniteLayout >> heightSpec [
	"Return the height measurement spec of the infinite element"
	<return: #BlMeasurementSpec>

	^ heightSpec
]

{ #category : #initialization }
BlInfiniteLayout >> infiniteElement: anInfiniteElement [
	"Attach infinite layout to its element.
	It is only possible to attach infinite element once!
	anInfiniteElement must not be nil"
	self assert: [ infiniteElement isNil ] description: [ 'Infinite element is already attached' ].
	
	infiniteElement := anInfiniteElement.

	width := infiniteElement width min: self maximumWidth.
	height := infiniteElement height min: self maximumHeight.

	widthSpec := BlMeasurementSpec exact: width.
	heightSpec := BlMeasurementSpec exact: height
]

{ #category : #'private - children' }
BlInfiniteLayout >> infoRemoveHolder: anElementHolder [
]

{ #category : #initialization }
BlInfiniteLayout >> initialize [

	super initialize.
	
	horizontalChildFinder :=
		BlInfiniteHorizontalChildBoundsBasedFinder new
			layout: self;
			yourself.
	verticalChildFinder :=
		BlInfiniteVerticalChildBoundsBasedFinder new
			layout: self;
			yourself.
	
	autoMeasure := self defaultAutoMeasure.

	"InfiniteLayout has its own more strict measurement cache to avoid re-measuring a child
	if the space that will be given to it is already larger than what it has measured before"
	measurementCacheEnabled := true.

	
	smoothScroller := nil "when not running smoothScroller is nil"
]

{ #category : #focus }
BlInfiniteLayout >> isFocused [
	"Return true if the infinit element I am bound to has focus"
	
	^ infiniteElement isFocused
]

{ #category : #'measurement - testing' }
BlInfiniteLayout >> isMeasurementUpToDate: aMeasuredSize spec: aMeasurementSpec resizer: aResizer [
	"Return true if measured child's size is up-to-date with measured specification and dimension"

	(aResizer isExact and: [ aMeasuredSize ~= aResizer size ])
		ifTrue: [ ^ false ].

	aMeasurementSpec isUnspecified
		ifTrue: [ ^ true ].

	(aMeasurementSpec isAtMost and: [ aResizer isFitContentLimited not ])
		ifTrue: [ ^ aMeasurementSpec size >= aMeasuredSize ].

	aMeasurementSpec isExact
		ifTrue: [ ^ aMeasurementSpec size = aMeasuredSize ].
		
	^ false
]

{ #category : #'scrolling - testing' }
BlInfiniteLayout >> isSmoothScrolling [
	"Return true if InfiniteElement is currently in the state of smooth scrolling,
	false otherwise"
	<return: #Boolean>

	^ smoothScroller isNotNil and: [ smoothScroller isRunning ]
]

{ #category : #items }
BlInfiniteLayout >> itemCount [
	"Returns the number of items in the datasource bound to the parent infinite element.
	Note that this number is not necessarily equal to BlInfiniteState>>#itemCount.
	In methods where State is available, you should use BlInfiniteState>>#itemCount instead"
	<return: #Number>
	
	^ self dataSource itemCount
]

{ #category : #accessing }
BlInfiniteLayout >> lastExactSize [

	^ lastExactSize
]

{ #category : #'api - layout' }
BlInfiniteLayout >> layoutChildrenIn: aBlInfiniteRecycler state: aBlInfiniteState [
	"Lay out all relevant child elements from the given datasource.
	aBlInfiniteRecycler - a Recycler to use for fetching potentially cached item element for a position.
	aBlInfiniteState - a transient state of BlInfiniteElement
	See my class comment, Animations section for more information"

	self subclassResponsibility
]

{ #category : #layout }
BlInfiniteLayout >> layoutCompleted [
]

{ #category : #layout }
BlInfiniteLayout >> layoutDecoratedWithMargins: anElement in: aRectangle context: aBlElementBoundsUpdateContext [
	"Lay out the given child view within the infinite element using coordinates that
	include any current ItemDecoration and take child margins into account.
	InfiniteLayouts should prefer working in sizes and coordinates that include
	item decoration insets whenever possible. This allows the InfiniteLayouts to effectively
	ignore decoration insets within measurement and layout code."
	| anInsets aMargin |

	anInsets := anElement constraints infinite decorationInsets.
	aMargin := anElement constraints margin.
	anElement applyLayoutIn: (aMargin inset: (anInsets inset: aRectangle)) context: aBlElementBoundsUpdateContext
]

{ #category : #'children - geometry' }
BlInfiniteLayout >> leftDecorationWidth: anElement [
	"Returns the total width of item decorations applied to child's left"
	<return: #Number>
	| anInsets |

	anInsets := anElement constraints infinite decorationInsets.
	^ anInsets left
]

{ #category : #geometry }
BlInfiniteLayout >> maximumHeight [
	"Return a maximum height of an infinite element"
	<return: #Number>
	
	^ infiniteElement constraints maxHeight
]

{ #category : #geometry }
BlInfiniteLayout >> maximumWidth [
	"Return a maximum width of an infinite element"
	<return: #Number>
	
	^ infiniteElement constraints maxWidth
]

{ #category : #measurement }
BlInfiniteLayout >> measure: anElement with: anExtentSpec [
	"Override me to customise!"
	
	self defaultMeasure: anElement with: anExtentSpec
]

{ #category : #measurement }
BlInfiniteLayout >> measureBasedOnChildren: anExtentSpec [
	"Measures infinite element based on children' bounding box.
	Custom infinite layouts may want to override me to handle
	bounding box calculation differently"
	| minX minY maxX maxY |
	
	self hasChildren
		ifFalse: [ ^ self defaultMeasure: infiniteElement with: anExtentSpec ].

	minX := Float infinity.
	minY := Float infinity.
	maxX := Float negativeInfinity.
	maxY := Float negativeInfinity.
	
	self childrenDo: [ :aChildElement |
		| aChildBounds |
		aChildBounds := self decoratedBoundsWithMargins: aChildElement.

		minX := minX min: aChildBounds left.
		maxX := maxX max: aChildBounds right.
		minY := minY min: aChildBounds top.
		maxY := maxY max: aChildBounds bottom ].
	
	self
		measuredBoundingBox: ((minX @ minY) corner: (maxX @ maxY))
		with: anExtentSpec
]

{ #category : #measurement }
BlInfiniteLayout >> measureChildWithMargins: anElement widthUsed: aWidthUsed heightUsed: aHeightUsed [
	"Measure a child element using standard measurement policy, taking the padding
	of the parent InfiniteElement, any added item decorations and the child margins
	into account.
	If the InfiniteElement can be scrolled in either dimension the sender may 
	pass 0 as the widthUsed or heightUsed parameters as they will be irrelevant"

	| widthUsed heightUsed aWidthSpec aHeightSpec anExtentSpec anInsets aConstraints |
	
	aConstraints := anElement constraints.
	anInsets := infiniteElement decorationsInsetsOfChildElement: anElement.
	widthUsed := aWidthUsed + anInsets width.
	heightUsed := aHeightUsed + anInsets height.
	
	aWidthSpec := self
		calculateChildMeasureSpec: self width
		parentSpec: self widthSpec
		padding: self paddingLeft + self paddingRight + aConstraints margin width + widthUsed
		childResizer: aConstraints horizontal resizer
		canScroll: self canScrollHorizontally.
	
	aHeightSpec := self
		calculateChildMeasureSpec: self height
		parentSpec: self heightSpec
		padding: self paddingTop + self paddingBottom + aConstraints margin height + heightUsed
		childResizer: aConstraints vertical resizer
		canScroll: self canScrollVertically.
		
	anExtentSpec := aWidthSpec @ aHeightSpec.
	
	(self shouldMeasureChild: anElement spec: anExtentSpec)
		ifTrue: [ anElement measure: anExtentSpec ]
]

{ #category : #measurement }
BlInfiniteLayout >> measuredBoundingBox: aChildrenBounds with: anExtentSpec [
	"Sets the measured extent from the given bounding box of the children and the measurement specs"
	| usedWidth usedHeight aMeasuredWidth aMeasuredHeight |

	usedWidth := aChildrenBounds width + self paddingLeft + self paddingRight.
	usedHeight := aChildrenBounds height + self paddingTop + self paddingBottom.
	
	aMeasuredWidth := self calculateSize: anExtentSpec widthSpec desired: usedWidth min: self minimumWidth.
	aMeasuredHeight := self calculateSize: anExtentSpec heightSpec desired: usedHeight min: self minimumHeight.

	aMeasuredWidth := aMeasuredWidth min: self maximumWidth.
	aMeasuredHeight := aMeasuredHeight min: self maximumHeight.

	infiniteElement measuredExtent: aMeasuredWidth @ aMeasuredHeight
]

{ #category : #accessing }
BlInfiniteLayout >> measurementCacheEnabled [
	"Return true if measurement cache enabled, false otherwise"
	<return: #Boolean>

	^ measurementCacheEnabled
]

{ #category : #accessing }
BlInfiniteLayout >> measurementCacheEnabled: aBoolean [
	"Set if measurement cache is enabled"

	measurementCacheEnabled := aBoolean
]

{ #category : #initialization }
BlInfiniteLayout >> measurementSpec: anExtentMeasurementSpec [
	"Update measurement specifications. I am sent from onMeasure: by infinite element.
	anExtentMeasurementSpec must not be nil"

	self
		assert: [ anExtentMeasurementSpec isNotNil ]
		description: [ 'Measurement specification must not be nil' ].

	widthSpec := anExtentMeasurementSpec widthSpec.
	heightSpec := anExtentMeasurementSpec heightSpec.

	width := widthSpec isUnspecified
		         ifTrue: [ 0 ]
		         ifFalse: [ widthSpec size ].

	width := width min: self maximumWidth.

	height := heightSpec isUnspecified
		          ifTrue: [ 0 ]
		          ifFalse: [ heightSpec size ].

	height := height min: self maximumHeight.

	(width isZero or: [height isZero ]) ifFalse: [ lastExactSize := width @ height ]
]

{ #category : #geometry }
BlInfiniteLayout >> minimumHeight [
	"Return a minimum height of an infinite element"
	<return: #Number>
	
	^ infiniteElement constraints minHeight
]

{ #category : #geometry }
BlInfiniteLayout >> minimumWidth [
	"Return a minimum width of an infinite element"
	<return: #Number>
	
	^ infiniteElement constraints minWidth
]

{ #category : #'children - add/remove' }
BlInfiniteLayout >> moveChildFrom: aFromIndex to: aToIndex [
	"Moves a child element from one position to another"
	| anElement |
	
	anElement := self childAt: aFromIndex.
	self
		assert: [ anElement isNotNil ]
		description: [ 'Can not move a child from non-existing index' ].
	
	self detachChildAt: aFromIndex.
	self attachChild: anElement at: aToIndex
]

{ #category : #geometry }
BlInfiniteLayout >> offsetChildrenHorizontallyBy: aNumber [
	"Offset all child elements attached to the parent infinite element by aNumber along the horizontal axis"

	infiniteElement offsetChildrenHorizontallyBy: aNumber
]

{ #category : #geometry }
BlInfiniteLayout >> offsetChildrenVerticallyBy: aNumber [
	"Offset all child elements attached to the parent infinite element by aNumber along the vertical axis"

	infiniteElement offsetChildrenVerticallyBy: aNumber
]

{ #category : #'items - hooks' }
BlInfiniteLayout >> onItemsAddedAt: positionStart count: itemCount [
]

{ #category : #'items - hooks' }
BlInfiniteLayout >> onItemsChanged [
]

{ #category : #'items - hooks' }
BlInfiniteLayout >> onItemsRemovedAt: positionStart count: itemCount [
]

{ #category : #'items - hooks' }
BlInfiniteLayout >> onItemsUpdatedAt: positionStart count: itemCount [
]

{ #category : #'scrolling - hooks' }
BlInfiniteLayout >> onScrollStateChanged: aScrollState [
	"InfiniteElement sends me to notify InfiniteElement that scroll state has changed"
]

{ #category : #'scrolling - hooks' }
BlInfiniteLayout >> onSmoothScrollerStopped: aSmoothScroller [
	"Is sent when smooth scroller stop scrolling"

	smoothScroller == aSmoothScroller
		ifTrue: [ smoothScroller := nil ]
]

{ #category : #geometry }
BlInfiniteLayout >> paddingBottom [
	"Return the bottom padding of an infinite element."
	
	^ infiniteElement constraints padding bottom
]

{ #category : #geometry }
BlInfiniteLayout >> paddingEnd [
	"Returns the end padding of infinite element depending on layout direction."
	<return: #Number>
	
	^ self direction isLeftToRight
		ifTrue: [ infiniteElement constraints padding right ]
		ifFalse: [ infiniteElement constraints padding left ]
]

{ #category : #geometry }
BlInfiniteLayout >> paddingLeft [
	"Return left padding of an infinite element"
	<return: #Number>
	
	^ infiniteElement constraints padding left
]

{ #category : #geometry }
BlInfiniteLayout >> paddingRight [
	"Return right padding of an infinite element"
	<return: #Number>
	
	^ infiniteElement constraints padding right
]

{ #category : #geometry }
BlInfiniteLayout >> paddingStart [
	"Returns the start padding of infinite element depending on layout direction."
	<return: #Number>

	^ self direction isLeftToRight
		ifTrue: [ infiniteElement constraints padding left  ]
		ifFalse: [ infiniteElement constraints padding right ]
]

{ #category : #geometry }
BlInfiniteLayout >> paddingTop [
	"Return top padding (a number) of an infinite element"

	^ infiniteElement constraints padding top
]

{ #category : #accessing }
BlInfiniteLayout >> recycler [
	^ infiniteElement recycler
]

{ #category : #'children - add/remove' }
BlInfiniteLayout >> removeAllChildren [
	"Remove all elements from the currently attached infinite element.
	This will not recycle any of the affected element; the InfiniteLayout is responsible for doing so if desired."

	self reverseChildrenDo: [ :anElement :anIndex |
		infiniteElement removeChildAt: anIndex ]
]

{ #category : #'children - add/remove' }
BlInfiniteLayout >> removeAndRecycleAllChildrenIn: aBlInfiniteRecycler [
	"Remove all elements and recycle them using the given infinite recycler.
	If you want to clean cached elements as well, you should sent #BlInfiniteRecycler>>#clear too.
	If an element is marked as 'ignored', it is not removed nor recycled."

	self reverseChildrenDo: [ :anElement :anIndex |
		(infiniteElement elementHolderOf: anElement) shouldIgnore
			ifFalse: [ self removeAndRecycleChildAt: anIndex ] ]
]

{ #category : #'children - add/remove' }
BlInfiniteLayout >> removeAndRecycleChild: anElement [
	"Remove a child element and recycle it using BlInfiniteRecycler."

	self removeChild: anElement.
	self recycler recycleElement: anElement in: infiniteElement 
]

{ #category : #'children - add/remove' }
BlInfiniteLayout >> removeAndRecycleChildAt: anIndex [
	"Remove a child element at anIndex and recycle it using BlInfiniteRecycler."
	| anElement |

	anElement := self childAt: anIndex.
	self removeChildAt: anIndex.
	self recycler recycleElement: anElement in: infiniteElement 
]

{ #category : #'private - recycling' }
BlInfiniteLayout >> removeAndRecycleScrap [
	| aScrapCount |
	
	"Store amount of scrapped element in order to decide if we need to invalidate
	infinite element later"
	aScrapCount := self recycler scrapCount.
	self recycler reverseScrapDo: [ :aScrappedElement :anIndex |
		| anElementHolder |
		anElementHolder := self elementHolderOf: aScrappedElement.
		anElementHolder shouldIgnore
			ifFalse: [ 
				"If the scrap element is animating, we need to cancel them first. If we cancel it
				here, ItemAnimator may recycle it which will cause double recycling.
				To avoid this, we mark it as not recycleable before using the item animator.
				Since removeDetachedChild: may use a user API, a common mistake (ending animations on
				the element) may recycle it too, so we guard it before we use user APIs."
				anElementHolder isTmpDetached
					ifTrue: [ infiniteElement removeDetachedChild: aScrappedElement].
				self recycler quickRecycleScrap: aScrappedElement	] ].
	"we used quick recycling mechanism in the loop and have to clear scrap manually"
	self recycler clearScrap.
	
	"invalidate infinite element if needed"
	aScrapCount isZero
		ifFalse: [
			"invalidate is required, otherwise the removed items may not visually disappear"
			infiniteElement invalidate ]
]

{ #category : #'children - add/remove' }
BlInfiniteLayout >> removeChild: anElement [
	"Remove an element from the currently attached infinite element if needed.
	InfiniteLayouts should use this method to completely remove a child view that is no longer needed.
   Note: InfiniteLayouts should strongly consider recycling removed views using BlInfiniteRecycler#recycleElement:"

	infiniteElement removeChild: anElement
]

{ #category : #'children - add/remove' }
BlInfiniteLayout >> removeChildAt: anIndex [
	"Remove an element at the index from the currently attached infinite element if needed.
	InfiniteLayouts should use this method to completely remove a child view that is no longer needed.
   Note: InfiniteLayouts should strongly consider recycling removed views using BlInfiniteRecycler#recycleElement:"

	(self childAt: anIndex)
		ifNotNil: [ infiniteElement removeChildAt: anIndex ]
]

{ #category : #'children - add/remove' }
BlInfiniteLayout >> removeDetachedChild: anElement [
	"Finish removing a child element that was previously temporarily detached"

	infiniteElement removeDetachedChild: anElement
]

{ #category : #layout }
BlInfiniteLayout >> requestLayout [
	"During layout initialization infinite element may still be not set"
	infiniteElement
		ifNotNil: [ :anElement | anElement requestLayout ]
]

{ #category : #'children - accessing' }
BlInfiniteLayout >> reverseChildrenDo: aBlock [

	self childrenCount isZero
		ifTrue: [ ^ self ].

	self childrenCount to: 1 by: -1 do: [ :anIndex |
		aBlock cull: (self childAt: anIndex) cull: anIndex ]
]

{ #category : #'children - geometry' }
BlInfiniteLayout >> rightDecorationWidth: anElement [
	"Returns the total width of item decorations applied to child's right"
	<return: #Number>
	| anInsets |

	anInsets := anElement constraints infinite decorationInsets.
	^ anInsets right
]

{ #category : #'private - children' }
BlInfiniteLayout >> scrapOrRecycleChild: anElement at: anIndex [
	| anElementHolder |
	
	anElementHolder := self elementHolderOf: anElement.
	anElementHolder shouldIgnore
		ifTrue: [ ^ self ].

	(anElementHolder isInvalid and: [
		anElementHolder isRemoved not
			and: [ self dataSource hasStableIds not ] ])
		ifTrue: [ 
			self removeChildAt: anIndex ]
		ifFalse: [
			self detachChildAt: anIndex.
			self recycler scrapElement: anElement in: infiniteElement ]
]

{ #category : #scrolling }
BlInfiniteLayout >> scrollHorizontallyBy: aNumber [
	"Scroll horizontally by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."
	<return: #Number>

	^ 0
]

{ #category : #scrolling }
BlInfiniteLayout >> scrollToPosition: aPositionInDataSource [
	"Scroll to the specified data source position.
	Actual position of the item on the screen depends on layout implementation"

	^ self subclassResponsibility
]

{ #category : #scrolling }
BlInfiniteLayout >> scrollToPosition: aPositionInDataSource offset: anOffset [
	"Scroll the InfiniteELement to make the datasource position visible with the given offset from resolved layout start.
	For example, if layout is ===vertical=== and ===stackFromEnd=== is true,
	sending ===scrollToPosition: 10 offset: 20=== will layout such that 10th item's
	bottom is 20 pixels above the InfiniteElement's bottom.
	Note: scroll position change will not be reflected until the next layout cycle (space pulse)"
	
	^ self subclassResponsibility
]

{ #category : #scrolling }
BlInfiniteLayout >> scrollVerticallyBy: aNumber [
	"Scroll vertically by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."

	^ 0
]

{ #category : #testing }
BlInfiniteLayout >> shouldAutoMeasure [

	^ autoMeasure
]

{ #category : #'measurement - testing' }
BlInfiniteLayout >> shouldMeasureChild: anElement spec: anExtentSpec [
	"Return true of a child element should be measured, false otherwise"
	<return: #Boolean>
	
	^ anElement isLayoutRequested or: [
		self shouldReMeasureChild: anElement spec: anExtentSpec ]
]

{ #category : #testing }
BlInfiniteLayout >> shouldMeasureTwice [
	"Internal API to allow InfiniteElement to be measured twice in order to support
	fit content in both horizontal and vertical directions"
	<return: #Boolean>

	^ false
]

{ #category : #'measurement - testing' }
BlInfiniteLayout >> shouldReMeasureChild: anElement spec: anExtentSpec [
	"Return true of a child element should be re-measured, false otherwise.
	If measurement cache is enabled we check if child's measured dimensions
	are up-to-date"
	<return: #Boolean>
	
	^ (self measurementCacheEnabled and: [
			(self
				isMeasurementUpToDate: anElement measuredWidth
				spec: anExtentSpec widthSpec
				resizer: anElement constraints horizontal resizer) and: [ 
					self
						isMeasurementUpToDate: anElement measuredHeight
						spec: anExtentSpec heightSpec
						resizer: anElement constraints vertical resizer ] ]) not
]

{ #category : #scrolling }
BlInfiniteLayout >> smoothScrollToPosition: aPosition [
	"Smooth scroll to the specified datasource position.
	To support smooth scrolling, override me, create your SmoothScroller instance
	and send #startSmoothScroll: with SmoothScroller as argument"

	^ self subclassResponsibility
]

{ #category : #accessing }
BlInfiniteLayout >> smoothScroller [
	"Return currently used smooth scroller or nil if I am not in a smooth scrolling state"
	<return: #BlInfiniteSmoothScroller>

	^ smoothScroller
]

{ #category : #scrolling }
BlInfiniteLayout >> startSmoothScroll: aSmoothScroller [
	"Starts a smooth scroll using the provided SmoothScroller.
	Calling me will cancel any previous smooth scroll request"

	(smoothScroller isNotNil and: [
		smoothScroller ~= aSmoothScroller and: [
			smoothScroller isRunning ] ])
		ifTrue: [ smoothScroller stop ].
	
	smoothScroller := aSmoothScroller.
	smoothScroller startOn: infiniteElement
]

{ #category : #accessing }
BlInfiniteLayout >> state [
	^ infiniteElement state
]

{ #category : #'children - state' }
BlInfiniteLayout >> stopIgnoringChild: anElement [
	"Element can be scrapped and recycled again.
	Note that I remove all information in the element holder"
	| anElementHolder |

	anElementHolder := self elementHolderOf: anElement.
	anElementHolder stopIgnoring.
	anElementHolder reset.
	anElementHolder flags addInvalid
]

{ #category : #scrolling }
BlInfiniteLayout >> stopSmoothScroller [
	"Ask current smooth scroller to stop scrolling"

	smoothScroller ifNotNil: [ :aScroller | aScroller stop ]
]

{ #category : #testing }
BlInfiniteLayout >> supportsPredictiveItemAnimations [
	<return: #Boolean>

	^ false
]

{ #category : #'children - geometry' }
BlInfiniteLayout >> topDecorationHeight: anElement [
	"Returns the total width of item decorations applied to child's top"
	<return: #Number>
	| anInsets |

	anInsets := anElement constraints infinite decorationInsets.
	^ anInsets top
]

{ #category : #'event management' }
BlInfiniteLayout >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"
	self announcer unsubscribe: anObject
]

{ #category : #'event management' }
BlInfiniteLayout >> when: anAnnouncementClass do: aValuable [
	self announcer when: anAnnouncementClass do: aValuable
]

{ #category : #'event management' }
BlInfiniteLayout >> when: anAnnouncementClass send: aSelector to: anObject [
	self announcer weak when: anAnnouncementClass send: aSelector to: anObject
]

{ #category : #geometry }
BlInfiniteLayout >> width [
	"Returns the width that is currently relevant to the layout.

	This value is usually equal to the laid out width of the InfiniteElement
	but may reflect the current MeasurementSpec width if the InfiniteLayout
	is using AutoMeasure and the InfiniteElement is in the process of measuring.
	
	The InfiniteLayout must always use this method to retrieve the width relevant to it at any given time."
	<return: #Number>

	^ width
]

{ #category : #geometry }
BlInfiniteLayout >> widthSpec [
	"Return the width measurement spec of the infinite element"
	<return: #BlMeasurementSpec>

	^ widthSpec
]
