Class {
	#name : #BlInfiniteLinearLayout,
	#superclass : #BlInfiniteLayout,
	#traits : 'TBlOrientableLayout',
	#classTraits : 'TBlOrientableLayout classTrait',
	#instVars : [
		'layoutState',
		'orientation',
		'lastStackFromEnd',
		'reverseLayout',
		'shouldReverseLayout',
		'stackFromEnd',
		'smoothScrollbarEnabled',
		'pendingScrollPosition',
		'pendingScrollPositionOffset',
		'anchorInfo'
	],
	#category : #'Bloc-Infinite-Layout-Linear'
}

{ #category : #factory }
BlInfiniteLinearLayout class >> horizontal [
	^ self new beHorizontal
]

{ #category : #accessing }
BlInfiniteLinearLayout class >> invalidOffset [
	^ Float negativeInfinity
]

{ #category : #factory }
BlInfiniteLinearLayout class >> vertical [
	^ self new beVertical
]

{ #category : #orientation }
BlInfiniteLinearLayout >> beHorizontal [

	self orientation: BlInfiniteHorizontalOrientation new
]

{ #category : #orientation }
BlInfiniteLinearLayout >> beVertical [

	self orientation: BlInfiniteVerticalOrientation new
]

{ #category : #scrolling }
BlInfiniteLinearLayout >> boundsUpdaterHasChanges [

	^ layoutState boundsUpdaterHasChanges
]

{ #category : #'scrolling - testing' }
BlInfiniteLinearLayout >> canScrollHorizontally [
	"@see BlInfiniteLayout>>canScrollHorizontally"

	^ orientation isHorizontal
]

{ #category : #'scrolling - testing' }
BlInfiniteLinearLayout >> canScrollVertically [
	"@see BlInfiniteLayout>>canScrollVertically"

	^ orientation isVertical
]

{ #category : #'children - accessing' }
BlInfiniteLinearLayout >> childAtPosition: aPosition [
	"See `OBlInfiniteLayout>>#childAtPosition:`"
	<return: #BlElement or: nil>

	| aFirstChildPosition anElementPosition |
	self hasChildren ifFalse: [ ^ nil ].

	aFirstChildPosition := self childPositionOf: (self childAt: 1).
	anElementPosition := aPosition - aFirstChildPosition.
	(anElementPosition between: 1 and: self childrenCount)
		ifTrue: [ 
			| anElement |
			anElement := self childAt: anElementPosition.
			(self childPositionOf: anElement) = aPosition
				"in pre-layout, this may not match"
				ifTrue: [ ^ anElement ] ].
	
	"fallback to traversal. This might be necessary in pre-layout."
	^ super childAtPosition: aPosition
]

{ #category : #'children - accessing' }
BlInfiniteLinearLayout >> childClosestToEnd [
	"Return the child closes to end.
	Sender should check if there is enough children"

	^ self childAt: (shouldReverseLayout
		ifTrue: [ 1 ]
		ifFalse: [ self childrenCount ])
]

{ #category : #'children - accessing' }
BlInfiniteLinearLayout >> childClosestToStart [
	"Return the child closes to start.
	Sender should check if there is enough children"

	^ self childAt: (shouldReverseLayout
		ifTrue: [ self childrenCount ]
		ifFalse: [ 1 ])
]

{ #category : #layout }
BlInfiniteLinearLayout >> computeExtraLayoutSpace [
	"I am a first step in layout algorithm; by checking children and other variables,
	I find an anchor coordinate and an anchor item position"

	| anExtraSpace anExtraForStart anExtraForEnd |
	anExtraForStart := anExtraForEnd := 0.

	"Linear layout may decide to layout items for 'extra' pixels to account for scrolling target,
	caching or predictive animations."
	anExtraSpace := self extraLayoutSpace.

	" If the previous scroll delta was less than zero, the extra space should be laid out
		at the start. Otherwise, it should be at the end"

	layoutState lastScrolledDelta >= 0
		ifTrue: [
			anExtraForStart := 0.
			anExtraForEnd := anExtraSpace ]
		ifFalse: [
			anExtraForStart := anExtraSpace.
			anExtraForEnd := 0 ].
	
	anExtraForStart := anExtraForStart + self orientation startWithPadding.
	anExtraForEnd := anExtraForEnd + self orientation paddingEnd.

	^ anExtraForStart @ anExtraForEnd
]

{ #category : #'scrolling - thumb' }
BlInfiniteLinearLayout >> computeHorizontalScrollExtent [

	^ self computeScrollExtent
]

{ #category : #'scrolling - thumb' }
BlInfiniteLinearLayout >> computeHorizontalScrollOffset [

	^ self computeScrollOffset
]

{ #category : #'scrolling - thumb' }
BlInfiniteLinearLayout >> computeHorizontalScrollRange [

	^ self computeScrollRange
]

{ #category : #'private - scrolling' }
BlInfiniteLinearLayout >> computeScrollExtent [
	
	self hasChildren ifFalse: [ ^ 0 ].
	
	^ self newScrollbarHelper computeScrollExtent
]

{ #category : #'private - scrolling' }
BlInfiniteLinearLayout >> computeScrollOffset [
	
	self hasChildren ifFalse: [ ^ 0 ].
	
	^ self newScrollbarHelper computeScrollOffset
]

{ #category : #'private - scrolling' }
BlInfiniteLinearLayout >> computeScrollRange [
	
	self hasChildren ifFalse: [ ^ 0 ].
	
	^ self newScrollbarHelper computeScrollRange
]

{ #category : #'scrolling - thumb' }
BlInfiniteLinearLayout >> computeVerticalScrollExtent [

	^ self computeScrollExtent
]

{ #category : #'scrolling - thumb' }
BlInfiniteLinearLayout >> computeVerticalScrollOffset [

	^ self computeScrollOffset
]

{ #category : #'scrolling - thumb' }
BlInfiniteLinearLayout >> computeVerticalScrollRange [

	^ self computeScrollRange
]

{ #category : #initialization }
BlInfiniteLinearLayout >> defaultAnchorInfo [

	^ BlInfiniteLinearLayoutAnchorInfo new
]

{ #category : #initialization }
BlInfiniteLinearLayout >> defaultAutoMeasure [

	^ true
]

{ #category : #initialization }
BlInfiniteLinearLayout >> defaultLayoutState [
	"Create an instance of layout state to track layout related information
	furing measurement and layout passes"

	^ BlInfiniteLinearLayoutState new
]

{ #category : #initialization }
BlInfiniteLinearLayout >> defaultOrientation [

	^ BlInfiniteVerticalOrientation new
]

{ #category : #initialization }
BlInfiniteLinearLayout >> defaultReverseLayout [

	^ false
]

{ #category : #initialization }
BlInfiniteLinearLayout >> defaultSmoothScrollbarEnabled [

	^ true
]

{ #category : #initialization }
BlInfiniteLinearLayout >> defaultSmoothScroller [

	^ BlInfiniteLinearSmoothScroller new
]

{ #category : #initialization }
BlInfiniteLinearLayout >> defaultStackFromEnd [

	^ false
]

{ #category : #'layout - geometry' }
BlInfiniteLinearLayout >> extraLayoutSpace [
	"Return the amount of extra space that should be laid out by InfiniteLayout.
	By default, I lay out 1 extra page of items while smooth scrolling and 0 otherwise.
	You can override this method to implement your custom layout pre-cache logic.
	Laying out invisible elements will eventually come with performance cost. On the other
	hand, in places like smooth scrolling to an unknown location, this extra content helps
	InfiniteLayout to calculate a much smoother scrolling; which improves user experience.
	You can also use this if you are trying to pre-layout your upcoming elements"

	" should be at least 1"

	"^ self orientation totalSpace"
	^ 1
]

{ #category : #layout }
BlInfiniteLinearLayout >> fillLayout: shouldStopOnFocusable [
	<return: #Number>

	| aStart aRemainingSpace aBreak aBoundsUpdater |
	aBoundsUpdater := BlElementBoundsUpdater new.

	aStart := layoutState availableSpace.
	"We can only recycle if scrolling offset is set"
	layoutState hasScrollingOffset
		ifTrue: [
			layoutState availableSpace < 0
				ifTrue: [ 
					layoutState scrollingOffset: layoutState scrollingOffset + layoutState availableSpace ]. 
			self recycleChildren ].

	aRemainingSpace := layoutState availableSpace + layoutState extraSpace.
	aBreak := false.
	[ aBreak not and: [
		| isInfinite |
		isInfinite := layoutState isInfinite and: [ self orientation maximumSpace isInfinite ].
		(isInfinite or: [ aRemainingSpace > 0 ]) and: [
			layoutState hasMoreItems: self state ] ] ]
		whileTrue: [ 
			| aResult |
			aResult := self layoutChunkContext: aBoundsUpdater.
			aResult finished
				ifTrue: [ aBreak := true ]
				ifFalse: [ 
					aRemainingSpace := aRemainingSpace + (self fillLayoutChunkResult: aResult).
					"Break if we found focusable element and if we should stop on it"
					aBreak := shouldStopOnFocusable and: [ aResult focusable ] ] ].
	
	"Make sure that class invariant is fulfilled"
	self validateChildrenOrder.
	
	aBoundsUpdater commitChanges.
	aBoundsUpdater hasChanges 
		ifTrue: [ layoutState boundsUpdaterHasChanges: true ].
	^ aStart - layoutState availableSpace
]

{ #category : #layout }
BlInfiniteLinearLayout >> fillLayoutChunkResult: aResult [

	| aRemainingSpaceDelta |
	layoutState offset: layoutState offset + (aResult consumedSpace * layoutState layoutDirection multiplier).
	aRemainingSpaceDelta := self fillLayoutConsumeSpace: aResult.
	self fillLayoutResultScroll: aResult.
	
	^ aRemainingSpaceDelta
]

{ #category : #layout }
BlInfiniteLinearLayout >> fillLayoutConsumeSpace: aResult [
	"Consume the available space if:
		layoutChunk did not request to be ignored
		OR we are laying out scrap children
		OR we are not doing pre-layout"

	^ aResult ignoreConsumed
		  ifFalse: [
			  layoutState
				  availableSpace:
				  layoutState availableSpace - aResult consumedSpace
				  in: self.
			  "we keep a separate remaining space because availableSpace is important for recycling"
			  aResult consumedSpace negated ]
		  ifTrue: [ 0 ]
]

{ #category : #layout }
BlInfiniteLinearLayout >> fillLayoutResultScroll: aResult [
	
	layoutState hasScrollingOffset
		ifFalse: [ ^ self ].

	layoutState scrollingOffset: layoutState scrollingOffset + aResult consumedSpace.
	layoutState availableSpace < 0
		ifTrue: [ layoutState scrollingOffset: layoutState scrollingOffset + layoutState availableSpace ].
	self recycleChildren
]

{ #category : #'private - children' }
BlInfiniteLinearLayout >> firstReferenceChildIn: aBlInfiniteRecycler state: aBlInfiniteState [
	<return: #BlElement or: nil>

	^ self
		referenceChildWithin: (1 to: self childrenCount)
		between: (1 to: self state itemCount)
		recycler: aBlInfiniteRecycler
		state: aBlInfiniteState
]

{ #category : #'private - children' }
BlInfiniteLinearLayout >> firstVisibleChildClosestToEnd [
	"Answer the visible child closest to end. Sender should check if it has enough children."
	<return: #BlElement or: nil>
	
	^ shouldReverseLayout
		ifTrue: [
			self
				firstVisibleChildFrom: 1
				to: self childrenCount ]
		ifFalse: [
			self
				firstVisibleChildFrom: self childrenCount
				to: 1 ]
]

{ #category : #'private - children' }
BlInfiniteLinearLayout >> firstVisibleChildClosestToStart [
	"Answer the visible child closest to start. Sender should check if it has enough children."
	<return: #BlElement or: nil>
	
	^ shouldReverseLayout
		ifTrue: [
			self
				firstVisibleChildFrom: self childrenCount
				to: 1 ]
		ifFalse: [
			self
				firstVisibleChildFrom: 1
				to: self childrenCount ]
]

{ #category : #'private - children' }
BlInfiniteLinearLayout >> firstVisibleChildFrom: aFromIndex to: aToIndex [
	"Returns the first child that is visible in the provided index range, i.e. either partially or
	fully visible depending on the arguments provided. Completely invisible children are not acceptable by this method."
	<return: #BlElement or: nil>

	| preferredConstraints acceptableConstraints |
	preferredConstraints := BlBoundsMatcherConstraints new.
	acceptableConstraints := BlBoundsMatcherConstraints new.
	
	smoothScrollbarEnabled
		ifTrue: [
			preferredConstraints
				addChildStartLessThanParentEnd;
				addChildEndGreaterThanParentStart ]
		ifFalse: [
			preferredConstraints
				addChildStartGreaterThanParentStart;
				addChildStartEqualParentStart;
				addChildEndLessThanParentEnd;
				addChildEndEqualParentEnd ].
	
	acceptableConstraints
		addChildStartLessThanParentEnd;
		addChildEndGreaterThanParentStart.
	
	^ orientation isHorizontal
		ifTrue: [
			horizontalChildFinder
				preferredConstraints: preferredConstraints;
				acceptableConstraints: acceptableConstraints;
				fromIndex: aFromIndex;
				toIndex: aToIndex;
				detect ]
		ifFalse: [
			verticalChildFinder
				preferredConstraints: preferredConstraints;
				acceptableConstraints: acceptableConstraints;
				fromIndex: aFromIndex;
				toIndex: aToIndex;
				detect ]
]

{ #category : #layout }
BlInfiniteLinearLayout >> fixLayoutEndGap: anOffset offsetChildren: canOffsetChildren [

	| anEndOffset aGap aFixOffset |
	anEndOffset := anOffset.
	aGap := self orientation endWithPadding - anEndOffset.
	aFixOffset := 0.
	
	aGap > 0
		"check if we should fix this gap."
		ifTrue: [ aFixOffset := (self scrollBy: aGap negated) negated ]
		"nothing to fix, return"
		ifFalse: [ ^ 0 ].
	
	"move offset according to scroll amount"
	anEndOffset := anEndOffset + aFixOffset.
	
	canOffsetChildren
		ifTrue: [ 
			"re-calculate gap, see if we could fix it"
			aGap := self orientation endWithPadding - anEndOffset.
			aGap > 0
				ifTrue: [
					self orientation moveChildrenBy: aGap.
					^ aFixOffset + aGap ] ].
	
	^ aFixOffset
]

{ #category : #layout }
BlInfiniteLinearLayout >> fixLayoutStartGap: anOffset offsetChildren: canOffsetChildren [

	| aStartOffset aGap aFixOffset |
	aStartOffset := anOffset.
	aGap := aStartOffset - self orientation startWithPadding.
	aFixOffset := 0.
	
	aGap > 0
		"check if we should fix this gap."
		ifTrue: [ aFixOffset := (self scrollBy: aGap) negated ]
		"nothing to fix, return"
		ifFalse: [ ^ 0 ].
	
	aStartOffset := aStartOffset + aFixOffset.
	
	canOffsetChildren
		ifTrue: [ 
			"re-calculate gap, see if we could fix it"
			aGap := aStartOffset - self orientation startWithPadding.
			aGap > 0
				ifTrue: [
					self orientation moveChildrenBy: aGap negated.
					^ aFixOffset - aGap ] ].
	
	^ aFixOffset
]

{ #category : #testing }
BlInfiniteLinearLayout >> hasPendingScrollPosition [
	
	^ pendingScrollPosition ~= NoPosition
]

{ #category : #testing }
BlInfiniteLinearLayout >> hasPendingScrollPositionOffset [
	
	^ pendingScrollPositionOffset ~= self class invalidOffset
]

{ #category : #initialization }
BlInfiniteLinearLayout >> initialize [

	super initialize.
	
	self orientation: self defaultOrientation.
	self reverseLayout: self defaultReverseLayout.
	self stackFromEnd: self defaultStackFromEnd.
	layoutState := self defaultLayoutState.
	anchorInfo := self defaultAnchorInfo.
	smoothScrollbarEnabled := self defaultSmoothScrollbarEnabled.
	
	"Initialize cache inst.vars"
	lastStackFromEnd := false.
	shouldReverseLayout := false.
	pendingScrollPosition := NoPosition.
	pendingScrollPositionOffset := self class invalidOffset
]

{ #category : #testing }
BlInfiniteLinearLayout >> isLayoutRTL [

	^ self direction isRightToLeft
]

{ #category : #'private - children' }
BlInfiniteLinearLayout >> lastReferenceChildIn: aBlInfiniteRecycler state: aBlInfiniteState [
	<return: #BlElement or: nil>

	^ self
		referenceChildWithin: (self childrenCount to: 1)
		between: (1 to: self state itemCount)
		recycler: aBlInfiniteRecycler
		state: aBlInfiniteState
]

{ #category : #layout }
BlInfiniteLinearLayout >> layoutChildrenFill: anExtraSpace [
	"fill towards start, stacking from bottom
	fill towards end, stacking from top"
	<return: #Point>

	^ anchorInfo layoutFromEnd
		ifTrue: [ self layoutChildrenFillFromEnd: anExtraSpace ]
		ifFalse: [ self layoutChildrenFillFromStart: anExtraSpace ]
]

{ #category : #layout }
BlInfiniteLinearLayout >> layoutChildrenFillFromEnd: anExtraSpace [
	<return: #Point>

	| anExtraForStart anExtraForEnd aStartOffset anEndOffset aFirstElementPosition |
	anExtraForStart := anExtraSpace x.
	anExtraForEnd := anExtraSpace y.
	
	"fill towards start"
	self updateLayoutStateToFillStart: anchorInfo.
	layoutState extraSpace: anExtraForStart.
	self fillLayout: false.
	aStartOffset := layoutState offset.
	aFirstElementPosition := layoutState currentPosition.
	layoutState availableSpace > 0
		ifTrue: [ anExtraForEnd := anExtraForEnd + layoutState availableSpace ].
		
	"fill towards end"
	self updateLayoutStateToFillEnd: anchorInfo.
	layoutState extraSpace: anExtraForEnd.
	layoutState currentPosition: layoutState currentPosition + layoutState itemDirection multiplier.
	self fillLayout: false.
	anEndOffset := layoutState offset.
	layoutState availableSpace > 0
		ifTrue: [ 
			"end could not consume all. add more items towards start"
			anExtraForStart := layoutState availableSpace.
			self updateLayoutStateToFillStart: aFirstElementPosition offset: aStartOffset.
			layoutState extraSpace: anExtraForStart.
			self fillLayout: false.
			aStartOffset := layoutState offset	].
			
	^ aStartOffset @ anEndOffset
]

{ #category : #layout }
BlInfiniteLinearLayout >> layoutChildrenFillFromStart: anExtraSpace [
	<return: #Point>

	| anExtraForStart anExtraForEnd aStartOffset anEndOffset aLastElementPosition |
	anExtraForStart := anExtraSpace x.
	anExtraForEnd := anExtraSpace y.

	"fill towards end"
	self updateLayoutStateToFillEnd: anchorInfo.
	layoutState extraSpace: anExtraForEnd.
	self fillLayout: false.
	anEndOffset := layoutState offset.
	aLastElementPosition := layoutState currentPosition.
	layoutState availableSpace > 0
		ifTrue: [ anExtraForStart := anExtraForStart + layoutState availableSpace ].

	"fill towards start"
	self updateLayoutStateToFillStart: anchorInfo.
	layoutState extraSpace: anExtraForStart.
	layoutState currentPosition: layoutState currentPosition + layoutState itemDirection multiplier.
	self fillLayout: false.
	aStartOffset := layoutState offset.
	layoutState availableSpace > 0
		ifTrue: [
			"end could not consume all. add more items towards start"
			anExtraForEnd := layoutState availableSpace.
			self updateLayoutStateToFillEnd: aLastElementPosition offset: anEndOffset.
			layoutState extraSpace: anExtraForEnd.
			self fillLayout: false.
			anEndOffset := layoutState offset	].

	^ aStartOffset @ anEndOffset
]

{ #category : #layout }
BlInfiniteLinearLayout >> layoutChildrenFixGaps: anOffsetSpace [
	"changes may cause gaps on the UI, try to fix them."
	<return: #Point>

	| aStartOffset anEndOffset |
	self hasChildren ifFalse: [ ^ anOffsetSpace ].

	aStartOffset := anOffsetSpace x.
	anEndOffset := anOffsetSpace y.
	
	"because layout from end may be changed by scroll to position
	we re-calculate it.
	ind which side we should check for gaps."
	
	shouldReverseLayout ~= stackFromEnd
		ifTrue: [ 
			| aFixOffset |
			aFixOffset := self fixLayoutEndGap: anEndOffset offsetChildren: true.
			aStartOffset := aStartOffset + aFixOffset.
			anEndOffset := anEndOffset + aFixOffset.
			aFixOffset := self fixLayoutStartGap: aStartOffset offsetChildren: false.
			aStartOffset := aStartOffset + aFixOffset.
			anEndOffset := anEndOffset + aFixOffset ]
		ifFalse: [ 
			| aFixOffset |
			aFixOffset := self fixLayoutStartGap: aStartOffset offsetChildren: true.
			aStartOffset := aStartOffset + aFixOffset.
			anEndOffset := anEndOffset + aFixOffset.
			aFixOffset := self fixLayoutEndGap: anEndOffset offsetChildren: false.
			aStartOffset := aStartOffset + aFixOffset.
			anEndOffset := anEndOffset + aFixOffset ].
	
	^ aStartOffset @ anEndOffset
]

{ #category : #'api - layout' }
BlInfiniteLinearLayout >> layoutChildrenIn: aBlInfiniteRecycler state: aBlInfiniteState [
	"layout algorithm:
  			1) by checking children and other variables, find an anchor coordinate and an anchor item position.
			2) fill towards start, stacking from bottom
			3) fill towards end, stacking from top
			4) scroll to fulfill requirements like stack from bottom.
				create layout state"
	| anExtraSpace anOffsetSpace |
	
	(self hasPendingScrollPosition
		and: [ aBlInfiniteState itemCount isZero ])
			ifTrue: [^ self removeAndRecycleAllChildrenIn: aBlInfiniteRecycler ].

	layoutState allowRecycling: false.
	"resolve layout direction"
	self resolveShouldLayoutReverse.
	
	"prepare and update anchor"
	self prepareAnchorInfo: anchorInfo recycler: aBlInfiniteRecycler state: aBlInfiniteState.
	
	"Initialize anchor and compute position + coordinate"
	anExtraSpace := self computeExtraLayoutSpace.
	
	self detachAndScrapAttachedChildren.
	layoutState isInfinite: self resolveIsInfinite.

	layoutState boundsUpdaterHasChanges: false.
	anOffsetSpace := self layoutChildrenFill: anExtraSpace.
	anOffsetSpace := self layoutChildrenFixGaps: anOffsetSpace.
	
	self orientation layoutCompleted.
		
	lastStackFromEnd := stackFromEnd.
	self validateChildrenOrder
]

{ #category : #layout }
BlInfiniteLinearLayout >> layoutChunkAdd [

	<return: #BlElement>
	| anElement |
	anElement := layoutState
		             nextElement: self recycler
		             in: infiniteElement.

	shouldReverseLayout = layoutState isLayoutStartDirection
		ifTrue: [ "add child as first" self addChild: anElement ]
		ifFalse: [ "add child as last" self addChild: anElement at: 1 ].

	^ anElement
]

{ #category : #layout }
BlInfiniteLinearLayout >> layoutChunkContext: aBlElementBoundsUpdateContext [

	| aResult anElement anElementBounds anInfiniteConstraints |
	aResult := BlInfiniteLinearLayoutChunkResult new.

	(layoutState hasMoreItems: self state)
		ifFalse: [ ^ aResult finished: true ].

	anElement := self layoutChunkAdd.

	anElementBounds := self layoutChunkMeasure: anElement result: aResult.
	
	"We calculate everything with Element's bounding box (which includes decor and margins)
	To calculate correct layout position, we subtract margins."
	self layoutDecoratedWithMargins: anElement in: anElementBounds context: aBlElementBoundsUpdateContext.
	
	anInfiniteConstraints := anElement constraints infinite.
	"Consume the available space if the element is not removed OR changed"
	(anInfiniteConstraints isItemRemoved or: [ anInfiniteConstraints isItemUpdated ])
		ifTrue: [ aResult ignoreConsumed: true ].

	aResult focusable: anElement isFocusable.
	^ aResult
]

{ #category : #layout }
BlInfiniteLinearLayout >> layoutChunkMeasure: anElement result: aResult [
	<return: #Rectangle>

	self measureChildWithMargins: anElement widthUsed: 0 heightUsed: 0.
	aResult consumedSpace: (self orientation decoratedMeasurement: anElement).
	
	^ orientation isVertical
		ifTrue: [ self layoutChunkMeasureVertical: anElement result: aResult ]
		ifFalse: [ self layoutChunkMeasureHorizontal: anElement result: aResult ]
]

{ #category : #layout }
BlInfiniteLinearLayout >> layoutChunkMeasureHorizontal: anElement result: aResult [
	<return: #Rectangle>

	| aLeft aTop aRight aBottom |
	aTop := self paddingTop.
	aBottom := aTop + (self orientation decoratedMeasurementInOther: anElement).
	
	layoutState isLayoutStartDirection
		ifTrue: [ 
			aRight := layoutState offset.
			aLeft := layoutState offset - aResult consumedSpace ]
		ifFalse: [
			aLeft := layoutState offset.
			aRight := layoutState offset + aResult consumedSpace].

	^ (aLeft @ aTop) corner: (aRight @ aBottom)
]

{ #category : #layout }
BlInfiniteLinearLayout >> layoutChunkMeasureVertical: anElement result: aResult [
	<return: #Rectangle>

	| aLeft aTop aRight aBottom |
	self isLayoutRTL
		ifTrue: [ 
			aRight := self width - self paddingRight.
			aLeft := aRight - (self orientation decoratedMeasurementInOther: anElement) ]
		ifFalse: [ 
			aLeft := self paddingLeft.
			aRight := aLeft + (self orientation decoratedMeasurementInOther: anElement) ].
	
	layoutState isLayoutStartDirection
		ifTrue: [ 
			aBottom := layoutState offset.
			aTop := aBottom - aResult consumedSpace ]
		ifFalse: [ 
			aTop := layoutState offset.
			aBottom := aTop + aResult consumedSpace ].

	^ (aLeft @ aTop) corner: (aRight @ aBottom)
]

{ #category : #layout }
BlInfiniteLinearLayout >> layoutCompleted [

	super layoutCompleted.

	(infiniteElement notNil
		and: [ infiniteElement bounds extent > (0 @ 0) ])
		ifTrue: [
			pendingScrollPosition := NoPosition.
			pendingScrollPositionOffset := self class invalidOffset ].

	anchorInfo reset
]

{ #category : #orientation }
BlInfiniteLinearLayout >> mouseWheelEvent: anEvent [
	"${method:BlInfiniteMouseScrollOrientationLimitedListener>>#mouseWheelEvent:}$
	dispatches mouse wheel event processing to layouts. Layouts decides whether and how to scroll items."

	orientation mouseWheelEvent: anEvent
]

{ #category : #'private - scrolling' }
BlInfiniteLinearLayout >> newScrollbarHelper [

	^ BlInfiniteScrollbarHelper new
		state: infiniteElement state;
		orientation: orientation;
		startElement: self firstVisibleChildClosestToStart;
		endElement: self firstVisibleChildClosestToEnd;
		layout: self;
		smoothScrollbarEnabled: smoothScrollbarEnabled;
		isReversedLayout: shouldReverseLayout;
		yourself
]

{ #category : #'layout - hooks' }
BlInfiniteLinearLayout >> onAnchorReady: anAnchorInfo firstLayoutItemDirection: aBlInfiniteLinearLayoutItemDirection [
	"Is called when Anchor position is decided.
	Extending class can setup accordingly or even update anchor info if necessary."
]

{ #category : #accessing }
BlInfiniteLinearLayout >> orientation [

	^ orientation
]

{ #category : #accessing }
BlInfiniteLinearLayout >> orientation: anInfiniteLayoutOrientation [
	"Sets the orientation of the layout. 
	I will do my best to keep scroll position."

	self
		assert: [ anInfiniteLayoutOrientation isNotNil ]
		description: [ 'Orientation must not be nil' ].
	
	self assertNotInLayoutOrScroll.
	
	"Clean state of previous orientation"
	orientation ifNotNil: #reset.
	
	orientation := anInfiniteLayoutOrientation.
	orientation reset.
	orientation layout: self.

	self requestLayout
]

{ #category : #'private - layout anchor' }
BlInfiniteLinearLayout >> prepareAnchorInfo: anAnchorInfo recycler: aBlInfiniteRecycler state: aBlInfiniteState [
	"I update anchor position and coordinate if this information is not valid"
	| aFirstLayoutItemDirection |

	(anAnchorInfo isValid not or: [ self hasPendingScrollPosition ])
		ifTrue: [ 
			anAnchorInfo reset.
			anAnchorInfo layoutFromEnd: shouldReverseLayout ~= stackFromEnd.
			"calculate anchor position and coordinate"
			self updateAnchorInfo: anAnchorInfo recycler: aBlInfiniteRecycler state: aBlInfiniteState.
			anAnchorInfo isValid: true	].

	aFirstLayoutItemDirection := (anAnchorInfo layoutFromEnd
		ifTrue: [ shouldReverseLayout
			ifTrue: [ BlInfiniteLinearLayoutItemDirection tail ]
			ifFalse: [ BlInfiniteLinearLayoutItemDirection head ] ]
		ifFalse: [ shouldReverseLayout
			ifTrue: [ BlInfiniteLinearLayoutItemDirection head ]
			ifFalse: [ BlInfiniteLinearLayoutItemDirection tail ] ]).
	
	self onAnchorReady: anAnchorInfo firstLayoutItemDirection: aFirstLayoutItemDirection
]

{ #category : #'private - recycling' }
BlInfiniteLinearLayout >> recycleChildren [
	"Recycle children depending on current layout direction"
		
	(layoutState allowRecycling not or: [
		layoutState isInfinite ])
			ifTrue: [ ^ self ].

	layoutState isLayoutStartDirection
		ifTrue: [ self recycleChildrenFromEnd: layoutState scrollingOffset ]
		ifFalse: [ self recycleChildrenFromStart: layoutState scrollingOffset ]
]

{ #category : #'private - recycling' }
BlInfiniteLinearLayout >> recycleChildrenFromEnd: anOffset [
	"Recycle elements that went out of bounds after scrolling towards the start of the layout.
	Checks both layout position and visible position to guarantee that the element is not visible"
	| aLimit aChildCount aStep aStart anEnd |

		
	
	anOffset < 0
		ifTrue: [ ^ self ].

	aLimit := self orientation end - anOffset.
	aChildCount := self childrenCount.
	aChildCount isZero
		ifTrue: [ ^ self ].

	aStep := shouldReverseLayout
		ifTrue: [ 1 ]
		ifFalse: [ -1 ].
	
	aStart := shouldReverseLayout
		ifTrue: [ 1 ]
		ifFalse: [ aChildCount ].
	
	anEnd := shouldReverseLayout
		ifTrue: [ aChildCount ]
		ifFalse: [ 1 ].
	
	aStart to: anEnd by: aStep do: [ :anIndex |
		| anElement |
		anElement := self childAt: anIndex.
		((self orientation decoratedStart: anElement) < aLimit
			or: [ (self orientation decoratedStartInParent: anElement) < aLimit ])
				"stop here"
				ifTrue: [
					^ self recycleChildrenWithin: (aStart to: anIndex + 1) inversed ] ]
]

{ #category : #'private - recycling' }
BlInfiniteLinearLayout >> recycleChildrenFromStart: anOffset [
	"Recycle elements that went out of bounds after scrolling towards the end of the layout.
	Checks both layout position and visible position to guarantee that the element is not visible"
	| aLimit aChildCount aStep aStart anEnd |
	
	anOffset < 0
		ifTrue: [ ^ self ].
	
	aLimit := anOffset.
	aChildCount := self childrenCount.
	aChildCount isZero
		ifTrue: [ ^ self ].
	
	aStep := shouldReverseLayout
		ifTrue: [ -1 ]
		ifFalse: [ 1 ].
	
	aStart := shouldReverseLayout
		ifTrue: [ aChildCount ]
		ifFalse: [ 1 ].
	
	anEnd := shouldReverseLayout
		ifTrue: [ 1 ]
		ifFalse: [ aChildCount ].
	
	aStart to: anEnd by: aStep do: [ :anIndex |
		| anElement |
		anElement := self childAt: anIndex.
		((self orientation decoratedEnd: anElement) > aLimit
			or: [ (self orientation decoratedEndInParent: anElement) > aLimit ])
				"stop here"
				ifTrue: [ ^ self recycleChildrenWithin: (anIndex - 1 to: aStart) inversed ] ]
]

{ #category : #'private - recycling' }
BlInfiniteLinearLayout >> recycleChildrenWithin: anInterval [
	"Recycle all children within given interval"
	
	anInterval reverseDo: [ :anIndex |
		self removeAndRecycleChildAt: anIndex ]
]

{ #category : #'private - children' }
BlInfiniteLinearLayout >> referenceChildClosestToEndIn: aBlInfiniteRecycler state: aBlInfiniteState [
	"Among the children that are suitable to be considered as an anchor child,
	return the one closest to the end of the layout"
	<return: #BlElement or: nil>

	^ shouldReverseLayout
		ifTrue: [	self firstReferenceChildIn: aBlInfiniteRecycler state: aBlInfiniteState ]
		ifFalse: [ self lastReferenceChildIn: aBlInfiniteRecycler state: aBlInfiniteState ]
]

{ #category : #'private - children' }
BlInfiniteLinearLayout >> referenceChildClosestToStartIn: aBlInfiniteRecycler state: aBlInfiniteState [
	"Among the children that are suitable to be considered as an anchor child,
	return the one closest to the start of the layout"
	<return: #BlElement or: nil>

	^ shouldReverseLayout
		ifTrue: [	self lastReferenceChildIn: aBlInfiniteRecycler state: aBlInfiniteState ]
		ifFalse: [ self firstReferenceChildIn: aBlInfiniteRecycler state: aBlInfiniteState ]
]

{ #category : #'children - accessing' }
BlInfiniteLinearLayout >> referenceChildWithin: anIndexInterval between: aPositionInterval recycler: aBlInfiniteRecycler state: aBlInfiniteState [
	"Return a child that is suitable to be considered as an anchor child.
	Due to ambiguous data source updates or children being removed, some children's positions may be invalid.
	I am a best effort to find a position within data source bounds if possible.
	I also prioritize children that are within the visible bounds"
	<return: #BlElement or: nil>
	| anInvalidElement anOutOfBoundsElement aStart anEnd aStep |

	anInvalidElement := nil.
	anOutOfBoundsElement := nil.
	aStart := self orientation startWithPadding.
	anEnd := self orientation endWithPadding.
	aStep := (anIndexInterval last > anIndexInterval first)
		ifTrue: [ 1 ]
		ifFalse: [ -1 ].
	
	anIndexInterval first to: anIndexInterval last by: aStep do: [ :anIndex |
		| anElement aPosition |
		anElement := self childAt: anIndex.
		aPosition := self childPositionOf: anElement.
		(aPosition between: aPositionInterval first and: aPositionInterval last)
			ifTrue: [ 
				anElement constraints infinite isItemRemoved
					"removed item, least preferred"
					ifTrue: [ anInvalidElement ifNil: [ anInvalidElement := anElement ] ]
					ifFalse: [
						((self orientation decoratedStart: anElement) >= anEnd or: [ 
							(self orientation decoratedEnd: anElement) < aStart ])
								"item is not visible, less preferred"
								ifTrue: [ anOutOfBoundsElement ifNil: [ anOutOfBoundsElement := anElement ] ]
								"exactly what we want"
								ifFalse: [ ^ anElement ] ] ] ].
	
	^ anOutOfBoundsElement ifNil: [ anInvalidElement ]
]

{ #category : #'private - computations' }
BlInfiniteLinearLayout >> resolveIsInfinite [
	"Return true if we should add children infinitely until we run out of items in data source or hit maxHeight/ maxWidth"
	<return: #Boolean>

	^ self orientation measurementSpec isUnspecified
		and: [ self orientation end isZero ]
]

{ #category : #'private - computations' }
BlInfiniteLinearLayout >> resolveShouldLayoutReverse [
	"Calculates the element layout order. (e.g. from end to start or start to end)
	RTL layout support is applied automatically.
	So if layout is RTL and #shouldReverseLayout is true, elements will be laid out starting from left."
	<return: #Boolean>

	shouldReverseLayout := (self orientation isVertical or: [ self isLayoutRTL not ])
		ifTrue: [ reverseLayout ]
		ifFalse: [ reverseLayout not ].

	^ shouldReverseLayout
]

{ #category : #accessing }
BlInfiniteLinearLayout >> reverseLayout: aBoolean [
	"Used to reverse item traversal and layout order.
	This behaves similar to the layout change for RTL elements. When set to true, first item is
	laid out at the end of the UI, second item is laid out before it etc"

	self assertNotInLayoutOrScroll.
	
	reverseLayout = aBoolean
		ifTrue: [ ^ self ].
		
	reverseLayout := aBoolean.
	self requestLayout
]

{ #category : #scrolling }
BlInfiniteLinearLayout >> scrollBy: aNumber [
	<return: #Number>
	| aLayoutDirection anAbsoluteDelta aConsumedSpace aScrolledDistance |

	(self hasChildren not or: [ aNumber isZero ])
		ifTrue: [ ^ 0 ].

	layoutState allowRecycling: true.
	aLayoutDirection := aNumber > 0
		ifTrue: [ BlInfiniteLinearLayoutDirection end ]
		ifFalse: [ BlInfiniteLinearLayoutDirection start ].
	anAbsoluteDelta := aNumber abs.

	self
		updateLayoutState: aLayoutDirection
		requiredSpace: anAbsoluteDelta
		canUseExistingSpace: true.
	
	aConsumedSpace := layoutState scrollingOffset + (self fillLayout: false).
	aConsumedSpace < 0
		"Don't have any more elements to scroll"
		ifTrue: [ ^ 0 ].

	aScrolledDistance := anAbsoluteDelta > aConsumedSpace
		ifTrue: [ aLayoutDirection multiplier * aConsumedSpace ]
		ifFalse: [ aNumber ].
	
	self orientation moveChildrenBy: aScrolledDistance negated.
	layoutState lastScrolledDelta: aScrolledDistance.

	^ aScrolledDistance
]

{ #category : #scrolling }
BlInfiniteLinearLayout >> scrollHorizontallyBy: aNumber [
	"@see BlInfiniteLayout>>#scrollHorizontallyBy:"
	<return: #Number>
	
	self orientation isVertical
		ifTrue: [ ^ 0 ].
		
	^ self scrollBy: aNumber
]

{ #category : #scrolling }
BlInfiniteLinearLayout >> scrollToPosition: aPositionInDataSource [
	"Scroll the InfiniteELement to make the datasource position visible.
	Note: scroll position change will not be reflected until the next layout cycle (space pulse)"
	
	pendingScrollPosition := aPositionInDataSource.
	pendingScrollPositionOffset := self class invalidOffset.

	self requestLayout
]

{ #category : #scrolling }
BlInfiniteLinearLayout >> scrollToPosition: aPositionInDataSource offset: anOffset [
	"Scroll the InfiniteELement to make the datasource position visible with the given offset from resolved layout start.
	For example, if layout is ===vertical=== and ===stackFromEnd=== is true,
	sending ===scrollToPosition: 10 offset: 20=== will layout such that 10th item's
	bottom is 20 pixels above the InfiniteElement's bottom.
	Note: scroll position change will not be reflected until the next layout cycle (space pulse)"
	
	pendingScrollPosition := aPositionInDataSource.
	pendingScrollPositionOffset := anOffset.

	self requestLayout
]

{ #category : #scrolling }
BlInfiniteLinearLayout >> scrollVectorForPosition: aPosition [

	| aFirstChildPos aDirection |
	self hasChildren ifFalse: [ ^ nil ].
	
	aFirstChildPos := self childPositionOf: (self childAt: 1).
	aDirection := (aPosition < aFirstChildPos) ~= shouldReverseLayout
		ifTrue: [ -1 ]
		ifFalse: [ 1 ].
	
	^ orientation isHorizontal
		ifTrue: [ aDirection @ 0 ]
		ifFalse: [ 0 @ aDirection ]
]

{ #category : #scrolling }
BlInfiniteLinearLayout >> scrollVerticallyBy: aNumber [
	"@see BlInfiniteLayout>>#scrollVerticallyBy:"

	self orientation isHorizontal
		ifTrue: [ ^ 0 ].

	^ self scrollBy: aNumber
]

{ #category : #testing }
BlInfiniteLinearLayout >> shouldMeasureTwice [

	^ self heightSpec isExact not and: [
		self widthSpec isExact not and: [
			self hasFlexibleChildInBothOrientations ] ]
]

{ #category : #testing }
BlInfiniteLinearLayout >> shouldReverseLayout [
	"Return true if elements are laid out from the opposite direction of the layout,
	false otherwise"

	^ reverseLayout
]

{ #category : #testing }
BlInfiniteLinearLayout >> shouldStackFromEnd [
	"Return if the list should fill its content starting from the bottom of the infinite element, false otherwise"

	^ stackFromEnd
]

{ #category : #scrolling }
BlInfiniteLinearLayout >> smoothScrollToPosition: aPosition [

	| aSmoothScroller |
	aSmoothScroller := self defaultSmoothScroller.
	aSmoothScroller targetPosition: aPosition.
	self startSmoothScroll: aSmoothScroller
]

{ #category : #accessing }
BlInfiniteLinearLayout >> stackFromEnd: aBoolean [
	"When stack from bottom is set to true, the list fills its content starting from the bottom of the infinite element"

	self assertNotInLayoutOrScroll.

	stackFromEnd = aBoolean
		ifTrue: [ ^ self ].
	
	stackFromEnd := aBoolean.
	self requestLayout
]

{ #category : #'layout - anchor' }
BlInfiniteLinearLayout >> updateAnchor: anAnchorInfo fromChild: anElement [

	| anElementSize aStartGap anEndGap |
	self
		assert: [ anElement isNotNil ]
		description: [ 'Can not update anchor info from nil element' ].

	anElementSize := self orientation decoratedMeasurement: anElement.
	anElementSize > self orientation totalSpace
		ifTrue: [ 
			"item does not fit. fix depending on layout direction"
			anAnchorInfo assignCoordinateFromPaddingIn: self.
			^ self ].
	
	aStartGap := (self orientation decoratedStart: anElement) - self orientation startWithPadding.
	aStartGap < 0
		ifTrue: [ 
			anAnchorInfo coordinate: self orientation startWithPadding.
			anAnchorInfo layoutFromEnd: false.
			^ self ].
		
	anEndGap := self orientation endWithPadding - (self orientation decoratedEnd: anElement).
	anEndGap < 0
		ifTrue: [ 
			anAnchorInfo coordinate: self orientation endWithPadding.
			anAnchorInfo layoutFromEnd: true.
			^ self ].
	
	anAnchorInfo coordinate: (anAnchorInfo layoutFromEnd
		ifTrue: [ (self orientation decoratedEnd: anElement) + self orientation totalSpaceChange ]
		ifFalse: [ self orientation decoratedStart: anElement ])
]

{ #category : #'layout - anchor' }
BlInfiniteLinearLayout >> updateAnchor: anAnchorInfo fromReferenceChild: anElement [

	anAnchorInfo assignFromElement: anElement in: self
]

{ #category : #'private - layout anchor' }
BlInfiniteLinearLayout >> updateAnchorFromChildren: anAnchorInfo recycler: aBlInfiniteRecycler state: aBlInfiniteState [
	"
	Rerturn a boolean indicating of the an anchor child from existing children was found.
	Most of the time, this is the element closest to start or end that has a valid position (e.g. not removed).
	If a child has focus, it is given priority"

	| aFocusedElement aReferenceElement |
	self hasChildren ifFalse: [ ^ false ].

	aFocusedElement := self focusedChild.
	(aFocusedElement isNotNil and: [
		anAnchorInfo isElementValidAsAnchor: aFocusedElement state: aBlInfiniteState ])
			ifTrue: [
				anAnchorInfo assignFromElementAndKeepVisible: aFocusedElement in: self.
				^ true ].

	lastStackFromEnd ~= stackFromEnd
		ifTrue: [ ^ false ].

	aReferenceElement := (anAnchorInfo layoutFromEnd
		ifTrue: [ self referenceChildClosestToEndIn: aBlInfiniteRecycler state: aBlInfiniteState ]
		ifFalse: [ self referenceChildClosestToStartIn: aBlInfiniteRecycler state: aBlInfiniteState ] ).

	aReferenceElement
		ifNotNil: [
			self updateAnchor: anAnchorInfo fromReferenceChild: aReferenceElement.
			^ true ].

	^ false
]

{ #category : #'private - layout anchor' }
BlInfiniteLinearLayout >> updateAnchorFromPendingData: anAnchorInfo state: aBlInfiniteState [
	"If there is a pending scroll position, updates the anchor info from that data and returns true.
	false otherwise"

	<return: #Boolean>
	self hasPendingScrollPosition ifFalse: [ ^ false ].

	"validate scroll position"
	(pendingScrollPosition between: 1 and: aBlInfiniteState itemCount)
		ifFalse: [
			pendingScrollPosition := NoPosition.
			pendingScrollPositionOffset := self class invalidOffset.
			^ false ].
	"if child is visible, try to make it a reference child and ensure it is fully visible.
	if child is not visible, align it depending on its virtual position."
	anAnchorInfo position: pendingScrollPosition.
	pendingScrollPositionOffset = self class invalidOffset ifTrue: [
		self updateAnchorFromPendingDataInvalidOffset: anAnchorInfo.
		^ true ].
	"override layout from end values for consistency"
	anAnchorInfo layoutFromEnd: shouldReverseLayout.

	"if this changes, we should update prepareForDrop as well"
	anAnchorInfo coordinate: (shouldReverseLayout
			 ifTrue: [
			 self orientation endWithPadding - pendingScrollPositionOffset ]
			 ifFalse: [
			 self orientation startWithPadding + pendingScrollPositionOffset ]).

	^ true
]

{ #category : #'private - layout anchor' }
BlInfiniteLinearLayout >> updateAnchorFromPendingDataInvalidOffset: anAnchorInfo [

	| anElement |
	anElement := self childAtPosition: pendingScrollPosition.
	anElement
		"Item is not visible"
		ifNotNil: [self updateAnchor: anAnchorInfo fromChild: anElement ]
		"Item is visible"
		ifNil: [ 
			self hasChildren
				ifTrue: [ | aPosition |
					aPosition := self childPositionOf: (self childAt: 1).
					anAnchorInfo layoutFromEnd: pendingScrollPosition < aPosition = shouldReverseLayout ].
			anAnchorInfo assignCoordinateFromPaddingIn: self ]
]

{ #category : #'private - layout anchor' }
BlInfiniteLinearLayout >> updateAnchorInfo: anAnchorInfo recycler: aBlInfiniteRecycler state: aBlInfiniteState [

	(self updateAnchorFromPendingData: anAnchorInfo state: aBlInfiniteState)
		ifTrue: [ ^ self ].

	(self updateAnchorFromChildren: anAnchorInfo recycler: aBlInfiniteRecycler state: aBlInfiniteState)
		ifTrue: [ ^ self ].

	anAnchorInfo assignCoordinateFromPaddingIn: self.
	anAnchorInfo position: (stackFromEnd
		ifTrue: [ self state itemCount ]
		ifFalse: [ 1 ])
]

{ #category : #'layout - state' }
BlInfiniteLinearLayout >> updateLayoutState: aLayoutDirection requiredSpace: aRequiredSpace canUseExistingSpace: canUseExistingSpace [
	"I update a layout state during a scrolling process.
	The goal is to recompute available space, scrolling offset and some other state properties"

	| aScrollingOffset |
	layoutState isInfinite: self resolveIsInfinite.
	layoutState extraSpace: self extraLayoutSpace.
	layoutState layoutDirection: aLayoutDirection.
	
	aScrollingOffset := (aLayoutDirection isStart
		ifTrue: [ self updateLayoutStateStart ]
		ifFalse: [self updateLayoutStateEnd ]).
		
	layoutState availableSpace: aRequiredSpace in: self.
	canUseExistingSpace
		ifTrue: [ layoutState availableSpace: layoutState availableSpace - aScrollingOffset in: self ].
	layoutState scrollingOffset: aScrollingOffset
]

{ #category : #'layout - state' }
BlInfiniteLinearLayout >> updateLayoutStateEnd [
	"Return how much we can scroll without adding new children (independent of layout)"

	| anElement |
	layoutState extraSpace: layoutState extraSpace + self orientation paddingEnd.
	"get the first child in the direction we are going"
	anElement := self childClosestToEnd.

	"the direction in which we are traversing children"
	layoutState itemDirection: (shouldReverseLayout
		ifTrue: [ BlInfiniteLinearLayoutItemDirection head ]
		ifFalse: [ BlInfiniteLinearLayoutItemDirection tail ]).
	
	layoutState currentPosition: (self childPositionOf: anElement) + layoutState itemDirection multiplier.
	layoutState offset: (self orientation decoratedEnd: anElement).
	
	^ (self orientation decoratedEnd: anElement) - self orientation endWithPadding
]

{ #category : #'layout - state' }
BlInfiniteLinearLayout >> updateLayoutStateStart [
	"Return how much we can scroll without adding new children (independent of layout)"

	| anElement |
	"get the first child in the direction we are going"
	anElement := self childClosestToStart.

	"the direction in which we are traversing children"
	layoutState itemDirection: (shouldReverseLayout
		ifTrue: [ BlInfiniteLinearLayoutItemDirection tail ]
		ifFalse: [ BlInfiniteLinearLayoutItemDirection head ]).
	
	layoutState currentPosition: (self childPositionOf: anElement) + layoutState itemDirection multiplier.
	layoutState offset: (self orientation decoratedStart: anElement).
		
	^ self orientation startWithPadding - (self orientation decoratedStart: anElement)
]

{ #category : #'layout - state' }
BlInfiniteLinearLayout >> updateLayoutStateToFillEnd: anAnchorInfo [

	self
		updateLayoutStateToFillEnd: anAnchorInfo position
		offset: anAnchorInfo coordinate
]

{ #category : #'layout - state' }
BlInfiniteLinearLayout >> updateLayoutStateToFillEnd: aPosition offset: anOffset [

	| anAvailableSpace aLimitedSpace |
	anAvailableSpace := self orientation endWithPadding - anOffset.
	aLimitedSpace := self orientation maximumSpace - self orientation paddingEnd.
	(aLimitedSpace isInfinite not and: [ layoutState isInfinite ])
		ifTrue: [ anAvailableSpace := aLimitedSpace ].
	
	layoutState availableSpace: anAvailableSpace in: self.

	layoutState itemDirection: (shouldReverseLayout
		ifTrue: [ BlInfiniteLinearLayoutItemDirection head ]
		ifFalse: [ BlInfiniteLinearLayoutItemDirection tail ]).

	layoutState currentPosition: aPosition.
	layoutState layoutDirection: BlInfiniteLinearLayoutDirection end.
	layoutState offset: anOffset.
	layoutState clearScrollingOffset
]

{ #category : #'layout - state' }
BlInfiniteLinearLayout >> updateLayoutStateToFillStart: anAnchorInfo [

	self
		updateLayoutStateToFillStart: anAnchorInfo position
		offset: anAnchorInfo coordinate
]

{ #category : #'layout - state' }
BlInfiniteLinearLayout >> updateLayoutStateToFillStart: aPosition offset: anOffset [

	| anAvailableSpace |
	anAvailableSpace := anOffset - self orientation startWithPadding.

	layoutState availableSpace: anAvailableSpace in: self.
	layoutState itemDirection: (shouldReverseLayout
		ifTrue: [ BlInfiniteLinearLayoutItemDirection tail ]
		ifFalse: [ BlInfiniteLinearLayoutItemDirection head ]).

	layoutState currentPosition: aPosition.
	layoutState layoutDirection: BlInfiniteLinearLayoutDirection start.
	layoutState offset: anOffset.
	layoutState clearScrollingOffset
]

{ #category : #layout }
BlInfiniteLinearLayout >> validateChildrenOrder [

	"I am a class invariant"

	| aLastPosition aLastScreenLocation |
	
	Bloc debugModeEnabled ifFalse: [ ^self ].
	
	self hasChildren ifFalse: [ ^ self ].

	aLastPosition := self childPositionOf: (self childAt: 1).
	aLastScreenLocation := self orientation decoratedStart: (self childAt: 1).

	2 to: self childrenCount do: [ :anIndex | 
		| anElement aPosition aScreenLocation |
		anElement := self childAt: anIndex.
		aPosition := self childPositionOf: anElement.
		aScreenLocation := self orientation decoratedStart: anElement.
		aPosition < aLastPosition ifTrue: [ self error: 'Detected invalid position!' ].
		shouldReverseLayout
			ifTrue: [ aScreenLocation > aLastScreenLocation ifTrue: [ self error: 'Detected invalid location!' ] ]
			ifFalse: [ aScreenLocation < aLastScreenLocation ifTrue: [ self error: 'Detected invalid location!' ] ] ]
]
