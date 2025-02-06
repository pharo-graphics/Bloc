"
I'm an element which is supposed to contain huge amount of children and layout only those of them that are visible inside my viewport.
I work with DataSources to fetch data from and can present data within different Infinite Layouts.

I fire the following events:
   - BlInfiniteElementDetachedEvent when a child element is detached

My main collaborators are:
 - BlInfiniteHolder
 - BlInfiniteLayout
 - BlInfiniteRecycler
 - BlInfiniteState

"
Class {
	#name : #BlInfiniteElement,
	#superclass : #BlElement,
	#traits : 'TBlScrollable',
	#classTraits : 'TBlScrollable classTrait',
	#instVars : [
		'dataSource',
		'dataSourceManager',
		'state',
		'recycler',
		'layoutOrScrollCounter',
		'dispatchScrollCounter',
		'itemDecorations',
		'dataSourceChangedAfterLayout',
		'firstLayoutComplete',
		'layoutPositionsRange',
		'childrenUpdateRunnable',
		'dataSourceChangeDuringMeasure',
		'dataSourceObserver',
		'scrollFlinger',
		'scrollState'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : #'Bloc-Infinite-Core'
}

{ #category : #'children add/remove' }
BlInfiniteElement >> addChild: aChildElement at: anIndex [ 

	"Adds a child at an index.
	If an Index is less or equal 0 child will be appended to the end"

	| anOffset |
	anOffset := (anIndex <= 0
		             ifTrue: [ self childrenCount + 1 ]
		             ifFalse: [ anIndex ]) max: 1.
	super addChild: aChildElement at: anOffset.
	self dispatchChildAttached: aChildElement.

]

{ #category : #'private - assertions' }
BlInfiniteElement >> assertInLayoutOrScroll [
	"Checks if InfiniteElement is in the middle of a layout or scroll
	and throws an assertion error if it is not"
	
	self
		assert: [ self isComputingLayout ]
		description: [ 'InfiniteElement is not computing a layout or scrolling while it should' ].
]

{ #category : #'private - assertions' }
BlInfiniteElement >> assertNotInLayout [
	"Checks if InfiniteElement is in the middle of a layout 
	and throws an assertion error if it is"
	
	Bloc debugModeEnabled
		ifFalse: [ ^ self ].
	
	self
		assert: [ self isComputingLayout not ]
		description: [ 'InfiniteElement is computing a layout or scrolling while it should not' ]
]

{ #category : #'private - assertions' }
BlInfiniteElement >> assertNotInLayoutOrScroll [
	"Checks if InfiniteElement is in the middle of a layout or scroll
	and throws an assertion error if it is"
	
	Bloc debugModeEnabled
		ifFalse: [ ^ self ].
	
	self
		assert: [ self isComputingLayout not ]
		description: [ 'InfiniteElement is computing a layout or scrolling while it should not' ].
	
	self
		assert: [ dispatchScrollCounter isZero ]
		description: [ 'Can not change the structure of InfiniteElement during scrolling' ]
]

{ #category : #'children add/remove' }
BlInfiniteElement >> attachChild: aChildElement at: anIndex [

	"Attaches aChildElement to the infinite element"

	| anOffset anElementHolder |
	anOffset := (anIndex <= 0
		             ifTrue: [ self childrenCount + 1 ]
		             ifFalse: [ anIndex ]) max: 1.

	anElementHolder := self elementHolderOf: aChildElement.
	(anElementHolder isTmpDetached not and: [ anElementHolder shouldIgnore not ]) ifTrue: [ 
		self error: 'Can not attach a child which is not previously detached ' ].

	anElementHolder clearTmpDetached.
	super attachChild: aChildElement at: anOffset
]

{ #category : #layout }
BlInfiniteElement >> boundsUpdaterHasChanges [

	^ self layout boundsUpdaterHasChanges
]

{ #category : #'api - scrolling testing' }
BlInfiniteElement >> canScrollHorizontally [
	"Return true if I can scroll the current contents horizontally, false otherwise"

	^ self layout canScrollHorizontally
]

{ #category : #'api - scrolling testing' }
BlInfiniteElement >> canScrollVertically [
	"Return true if I can scroll the current contents vertically, false otherwise"
	<return: #Boolean>

	^ self layout canScrollVertically
]

{ #category : #'private - positions' }
BlInfiniteElement >> changedHolderKeyOf: anElementHolder [
	
	<return: #Number>
	
	^ dataSource hasStableIds
		ifTrue: [ anElementHolder itemId ]
		ifFalse: [ anElementHolder position ]
]

{ #category : #'children - accessing' }
BlInfiniteElement >> childContainingItemElement: anElement [
	"Traverses the ancestors of the given element and returns the item view that contains it and
	also my direct child. Returned element can be used to get the ElementHolder by sending #childHolderOf:
	Return nil if such element was not found"
	<return: #BlElement or: nil>
	| aParent aPreviousParent |

	aParent := anElement parent.
	[ aParent isNotNil and: [ aParent ~~ self ] ] whileTrue: [ 
		aPreviousParent := aParent.
		aParent := aPreviousParent parent ].
	
	^ aParent == self
		ifTrue: [ aPreviousParent ]
		ifFalse: [ nil ]
]

{ #category : #'children - accessing' }
BlInfiniteElement >> childHolderContainingItemElement: anElement [
	"Return the ElementHolder that contains the given element.
	Return nil if the provided element is not a my descendant"
	<return: #BlInfiniteHolder or: nil>
	| aChildElement |

	aChildElement := self childContainingItemElement: anElement.
	^ aChildElement ifNotNil: [ :anItemElement |
		self childHolderOf: anItemElement ]
]

{ #category : #'children - accessing' }
BlInfiniteElement >> childHolderOf: aChildElement [
	"Return an element holder assigned to my direct child.
	aChildElement must be my direct child.
	Element holder can not be nil"
	<return: #BlInfiniteHolder>

	self
		assert: [ aChildElement parent == self ]
		description: [ 'aChildElement must be my direct child!' ].

	^ self elementHolderOf: aChildElement
]

{ #category : #'children - accessing' }
BlInfiniteElement >> childLayoutPositionOf: anElement [
	"Return the datasource position (a number) of the given child element as of the latest completed layout pass.
	This position may not be equal to Item's datasource position if there are pending changes
	in the datasource which have not been reflected to the layout yet"

	^ (self elementHolderOf: anElement) position

]

{ #category : #'api - scrolling thumb' }
BlInfiniteElement >> computeHorizontalScrollExtent [
	"Compute the horizontal extent of the horizontal scrollbar's thumb within the horizontal range.
	This value is used to compute the length of the thumb within the scrollbar's track.
	The extent is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollRange and #computeHorizontalScrollOffset."
	<return: #Number>
	
	^ self layout canScrollHorizontally
		ifTrue: [ self layout computeHorizontalScrollExtent ]
		ifFalse: [ 0 ]
]

{ #category : #'api - scrolling thumb' }
BlInfiniteElement >> computeHorizontalScrollOffset [
	"Compute the horizontal offset of the horizontal scrollbar's thumb within the horizontal range.
	The offset is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollExtent and #computeHorizontalScrollRange."
	<return: #Number>
	
	^ self layout canScrollHorizontally
		ifTrue: [ self layout computeHorizontalScrollOffset ]
		ifFalse: [ 0 ]
]

{ #category : #'api - scrolling thumb' }
BlInfiniteElement >> computeHorizontalScrollRange [
	"Compute the horizontal range that the horizontal scrollbar represents.
	The range is expressed in arbitrary units that must be the same as the units used by
	#computeHorizontalScrollExtent and #computeHorizontalScrollOffset."
	<return: #Number>
	
	^ self layout canScrollHorizontally
		ifTrue: [ self layout computeHorizontalScrollRange ]
		ifFalse: [ 0 ]
]

{ #category : #'api - scrolling thumb' }
BlInfiniteElement >> computeVerticalScrollExtent [
	"Compute the vertical extent of the vertical scrollbar's thumb within the vertical range.
	This value is used to compute the length of the thumb within the scrollbar's track.
	The extent is expressed in arbitrary units that must be the same as the units used by
	#computeVerticalScrollRange and #computeVerticalScrollOffset"
	<return: #Number>
	
	^ self layout canScrollVertically
		ifTrue: [ self layout computeVerticalScrollExtent ]
		ifFalse: [ 0 ]
]

{ #category : #'api - scrolling thumb' }
BlInfiniteElement >> computeVerticalScrollOffset [
	"Compute the vertical offset of the vertical scrollbar's thumb within the vertical range.
	The offset is expressed in arbitrary units that must be the same as the units used by
	#computeVerticalScrollExtent and #computeVerticalScrollRange."
	<return: #Number>
	
	^ self layout canScrollVertically
		ifTrue: [ self layout computeVerticalScrollOffset ]
		ifFalse: [ 0 ]
]

{ #category : #'api - scrolling thumb' }
BlInfiniteElement >> computeVerticalScrollRange [
	"Compute the vertical range that the vertical scrollbar represents.
	The range is expressed in arbitrary units that must be the same as the units used by
	#computeVerticalScrollExtent and #computeVerticalScrollOffset."
	<return: #Number>
	
	^ self layout canScrollVertically
		ifTrue: [ self layout computeVerticalScrollRange ]
		ifFalse: [ 0 ]
]

{ #category : #'private - commands' }
BlInfiniteElement >> consumePendingDataSourceCommands [
	" I'm sent before scrolling or from the children update runnable task 
	(my instance of BlInfiniteChildrenUpdateRunnable).
	I help to reflect data changes to the state.
	DataSource changes during a scroll may trigger a crash because scroll assumes no data change but data actually changed.
	I consume all deferred changes to avoid that case."

	(firstLayoutComplete not or: [ dataSourceChangedAfterLayout ])
		ifTrue: [ ^ self dispatchLayout ].
	dataSourceManager hasPendingCommands ifFalse: [ ^ self ].
	self dispatchLayout
]

{ #category : #accessing }
BlInfiniteElement >> dataSource [
	^ dataSource
]

{ #category : #accessing }
BlInfiniteElement >> dataSource: aDataSource [
	dataSource
		ifNotNil: [
			dataSource removeEventHandler: dataSourceObserver.
			dataSource onDetached: self ].
	
	dataSource := aDataSource.
	dataSource addEventHandler: dataSourceObserver.
	dataSource onAttached: self
]

{ #category : #'private - accessing' }
BlInfiniteElement >> dataSource: aNewDataSource compatible: isCompatibleWithPrevious recycle: shouldRecycleElement [
]

{ #category : #accessing }
BlInfiniteElement >> dataSourceManager [
	^ dataSourceManager
]

{ #category : #accessing }
BlInfiniteElement >> dataSourcePositionOf: anElementHolder [
	<return: #Number>
	
	(anElementHolder flags hasInvalid or: [
		anElementHolder flags hasRemoved or: [ 
			anElementHolder flags hasDataSourcePositionUnknown or: [
				anElementHolder isBound not ] ] ])
		ifTrue: [ ^ NoPosition ].
		
	^ dataSourceManager applyPendingCommandsOnPosition: anElementHolder position
]

{ #category : #'children - geometry' }
BlInfiniteElement >> decoratedBoundsWithMargins: anElement [
	"Returns the bounds of the child element including its decoration and margins"
	<return: #Rectangle>
	| aMargin anInsets |

	anInsets := anElement constraints infinite decorationInsets.
	aMargin := anElement constraints margin.
	
	^ anInsets expand: (aMargin expand: anElement bounds inParent asRectangle)
]

{ #category : #'item decorations - accessing' }
BlInfiniteElement >> decorationsInsetsOfChildElement: anElement [

	"Return decoration insets for the given element"

	<return: #BlInsets>
	| anInfiniteConstraints |
	
	anInfiniteConstraints := anElement constraints infinite.
	anInfiniteConstraints insetsDirty ifTrue: [ 
		anInfiniteConstraints decorationInsets: 
			(self getDecorationsInsetsOfChildElement: anElement) ].
	^ anInfiniteConstraints decorationInsets
	"	

        final Rect insets = lp.mDecorInsets;
        insets.set(0, 0, 0, 0);
        final int decorCount = mItemDecorations.size();
        for (int i = 0; i < decorCount; i++) {
            mTempRect.set(0, 0, 0, 0);
            mItemDecorations.get(i).getItemOffsets(mTempRect, child, this, mState);
            insets.left += mTempRect.left;
            insets.top += mTempRect.top;
            insets.right += mTempRect.right;
            insets.bottom += mTempRect.bottom;
        }
        lp.mInsetsDirty = false;
        return insets;"
]

{ #category : #'private - focus' }
BlInfiniteElement >> deepestFocusedChildIn: anElement [
	self shouldBeImplemented
]

{ #category : #initialization }
BlInfiniteElement >> defaultChildrenUpdateRunnable [
	"Return class, actual instantiation happens in initialize"
	^ BlInfiniteChildrenUpdateRunnable
]

{ #category : #initialization }
BlInfiniteElement >> defaultDataSource [

	^ BlInfiniteBasicDataSource new
]

{ #category : #initialization }
BlInfiniteElement >> defaultDataSourceManager [
	^ BlInfiniteDataSourceManager new
]

{ #category : #initialization }
BlInfiniteElement >> defaultDataSourceObserver [
	"Return class, actuall instantiation happens in initialize"
	^ BlInfiniteElementDataSourceObserver
]

{ #category : #initialization }
BlInfiniteElement >> defaultLayout [
	^ BlInfiniteBasicLayout new
]

{ #category : #initialization }
BlInfiniteElement >> defaultMouseScrollEventHandler [

	^ BlInfiniteMouseScrollListener new
]

{ #category : #initialization }
BlInfiniteElement >> defaultRecycler [

	^ BlInfiniteRecycler new
]

{ #category : #initialization }
BlInfiniteElement >> defaultScrollFlinger [
	"Return class, actuall instantiation happens in initialize"
	^ BlInfiniteScrollFlinger
]

{ #category : #initialization }
BlInfiniteElement >> defaultState [

	^ BlInfiniteState new
]

{ #category : #'children add/remove' }
BlInfiniteElement >> detachChildAt: anIndex [
	"Detaches a child element at anIndex from infinite element"
	| anElement anElementHolder |
	anElement := self children 
		at: anIndex
		ifAbsent: [ ^ self ].
	
	anElementHolder := self elementHolderOf: anElement.
	
	(anElementHolder isTmpDetached and: [
		anElement shouldIgnore not ])
			ifTrue: [ self error: 'Can not detach already detached child!' ].
	
	anElementHolder flags addTmpDetached.
	self detachChild: anElement
]

{ #category : #'private - positions' }
BlInfiniteElement >> didChildPositionsRangeChange: anInterval [

	<return: #Boolean>

	^ self findMinMaxChildLayoutPositions ~= anInterval
]

{ #category : #dispatching }
BlInfiniteElement >> dispatchChildAttached: anElement [
	"I am used by
		- ChildrenManager's addChild:at:in:"
	| anElementHolder |
	
	anElementHolder := self elementHolderOf: anElement.
	self onChildAttached: anElement.
	self dataSource onElementAttached: anElementHolder.
	self notifyChildAttached: anElement
]

{ #category : #dispatching }
BlInfiniteElement >> dispatchChildDetached: anElement [
	"I am used by
		- ChildrenController's removeChildAt: and removeAllChildren
		- InfiniteElement's removeDetachedChild:animate:"
	| anElementHolder |

	anElementHolder := self elementHolderOf: anElement.
	self onChildDetached: anElementHolder.
	self dataSource onElementDetached: anElementHolder.
	self notifyChildDetached: anElement
]

{ #category : #layout }
BlInfiniteElement >> dispatchLayout [

	state isStartStep
		ifTrue: [
			self dispatchLayoutFirstStep.
			self layout exactMeasurementSpecFrom: self.
			self dispatchLayoutSecondStep ]
		ifFalse: [
			self layout exactMeasurementSpecFrom: self.
			(dataSourceManager hasCommands or: [
				 layout width ~= self width or: [ layout height ~= self height ] ])
				ifTrue: [ self dispatchLayoutSecondStep ] ].

	self dispatchLayoutFinalStep
]

{ #category : #layout }
BlInfiniteElement >> dispatchLayoutFinalStep [
	"The final step of the layout where we save the information about elements for animations,
	trigger animations and do any necessary cleanup."

	state assertLayoutStep: BlInfiniteLayoutStepFlags Final.

	self onEnterLayoutOrScroll.
	state beStepStart.
	layout removeAndRecycleScrap.
	dataSourceChangedAfterLayout := false.

	layout layoutCompleted.
	self onExitLayoutOrScroll.
	(self didChildPositionsRangeChange: layoutPositionsRange) ifTrue: [
		self dispatchOnScrolled: 0 @ 0.
		self boundsUpdaterHasChanges ifTrue: [
			self dispatchEvent: BlBoundsHasChangedDuringScrollingEvent new ] ].
	self recoverFocusFromState.
	self resetFocusInfo
]

{ #category : #layout }
BlInfiniteElement >> dispatchLayoutFirstStep [
	"The first step of a layout where we
  		- process data source updates
		- save information about current child elements
		- If necessary, run predictive layout and save its information"

	state assertLayoutStep: BlInfiniteLayoutStepFlags Start.
	self onEnterLayoutOrScroll.
	self processDataSourceCommands.
	self saveFocusInfo.
	state itemCount: self dataSource itemCount.
	self layoutPositionsRange: self findMinMaxChildLayoutPositions.
	
	"self clearOldPositions."
	self onExitLayoutOrScroll.
	state beStepLayout
]

{ #category : #layout }
BlInfiniteElement >> dispatchLayoutSecondStep [
	"The second layout step where we do the actual layout of the element for the final state.
	This step might be run multiple times if necessary (e.g. measure)."
	
	self onEnterLayoutOrScroll.
	
	state assertLayoutStep: BlInfiniteLayoutStepFlags Layout or: BlInfiniteLayoutStepFlags Final.
	
	dataSourceManager consumeCommandsIn: self.
	state itemCount: dataSource itemCount.
	state deletedInvisibleItemCountSincePreviousLayout: 0.
	
	"Run layout"
	layout layoutChildrenIn: self recycler state: state.

	state beStepFinal.
	self onExitLayoutOrScroll
]

{ #category : #'api - scrolling notifying' }
BlInfiniteElement >> dispatchOnScrolled: aPoint [

	dispatchScrollCounter := dispatchScrollCounter + 1.
	
	self onScrolled: aPoint.
	self notifyScrolled: aPoint.
	
	dispatchScrollCounter := dispatchScrollCounter - 1
]

{ #category : #dispatching }
BlInfiniteElement >> dispatchScrollStateChanged: aScrollState [

	"Let the Layout go first; this allows it to bring any properties into
	a consistent state before the InfiniteElement subclass responds"
	self layout onScrollStateChanged: aScrollState.
	
	"Let the InfiniteElement subclass handle this event next;
	any Layout property changes will be reflected by this time."
	self onScrollStateChanged: aScrollState.
	
	"Event handlers go last. All other internal state is consistent by this point"
	self notifyScrollStateChanged: aScrollState
]

{ #category : #'children - accessing' }
BlInfiniteElement >> elementHolderOf: anElement [
	"Return an element holder assigned to anElement.
	anElement should not be necessarily my direct child.
	Element holder can not be nil"
	<return: #BlInfiniteHolder>
	
	^ anElement constraints infinite holder
]

{ #category : #'private - commands' }
BlInfiniteElement >> elementRangeUpdate: aPositionStart itemCount: anItemCount [
	"Rebind existing elements for the given range, or create new as needed"

	| aPositionEnd |
	aPositionEnd := aPositionStart + anItemCount.
	self unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore ifFalse: [
			(anElementHolder position >= aPositionStart and: [
				 anElementHolder position < aPositionEnd ]) ifTrue: [ 
					"We re-bind these elements holders after pre-processing is complete so that
						ElementHolders have their final positions assigned."
				anElementHolder flags addUpdate.
				anElement constraints infinite insetsDirty: true ] ] ]
]

{ #category : #'children - accessing' }
BlInfiniteElement >> findElementHolderForDataSourcePosition: aPosition [

	"Return the ViewHolder for the item in the given position of the data set"

	<return: #BlInfiniteHolder or: nil>
	dataSourceChangedAfterLayout ifTrue: [ ^ nil ].

	self
		unfilteredChildrenDo: [ :anElement | 
			| anElementHolder |
			anElementHolder := self elementHolderOf: anElement.
			(anElementHolder isRemoved not and: [ 
				 (self dataSourcePositionOf: anElementHolder) = aPosition ]) 
				ifTrue: [ ^ anElementHolder ] ].

	^ nil
]

{ #category : #'children - accessing' }
BlInfiniteElement >> findElementHolderForItemId: anId [
	self shouldBeImplemented
]

{ #category : #'private - positions' }
BlInfiniteElement >> findMinMaxChildLayoutPositions [
	<return: #Interval>
	
	| minPositionPreLayout maxPositionPreLayout |
	
	self hasChildren
		ifFalse: [ ^ NoPosition to: NoPosition ].

	minPositionPreLayout := Float infinity.
	maxPositionPreLayout := Float negativeInfinity.
	
	self childrenDo: [ :anElement | 
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore ifFalse: [ 
			| aPosition |
			aPosition := anElementHolder position.
			minPositionPreLayout := minPositionPreLayout min: aPosition.
			maxPositionPreLayout := maxPositionPreLayout max: aPosition ] ].
	^ minPositionPreLayout to: maxPositionPreLayout
]

{ #category : #scrolling }
BlInfiniteElement >> fling: aVelocity [
	| aVelocityX aVelocityY canScrollHorizontal canScrollVertical |
	
	canScrollHorizontal := self layout canScrollHorizontally.
	canScrollVertical := self layout canScrollVertically.
	
	aVelocityX := aVelocity x.
	aVelocityY := aVelocity y.
	
	(canScrollHorizontal not or: [ aVelocityX abs < self minFlingVelocity ])
		ifTrue: [ aVelocityX := 0 ].
	
	(canScrollVertical not or: [ aVelocityY abs < self minFlingVelocity ])
		ifTrue: [ aVelocityY := 0 ].
	
	"If we don't have any velocity, return false"
	(aVelocityX isZero and: [ aVelocityY isZero ])
		ifTrue: [ ^ false ].
	
	(canScrollHorizontal or: [ canScrollVertical ])
		ifTrue: [ 
			aVelocityX := self maxFlingVelocity negated max: (aVelocityX min: self maxFlingVelocity).
			aVelocityY := self maxFlingVelocity negated max: (aVelocityY min: self maxFlingVelocity).
			scrollFlinger flingBy: aVelocityX @ aVelocityY.
			^ true ].
	^ false
]

{ #category : #'item decorations - accessing' }
BlInfiniteElement >> getDecorationsInsetsOfChildElement: anItemElement [

	| insets |
	insets := BlInsets empty.
	self itemDecorationsDo: [ :d | insets := (d getDecorationsInsetsOfChildElement: anItemElement in: self) + insets ].
	^ insets
	
]

{ #category : #'item decorations - testing' }
BlInfiniteElement >> hasItemDecorations [
	^ itemDecorations isNotEmpty
]

{ #category : #initialization }
BlInfiniteElement >> initialize [
	super initialize.
	
	firstLayoutComplete := false.
	layoutOrScrollCounter := 0.
	dispatchScrollCounter := 0.
	dataSourceChangedAfterLayout := false.
	dataSourceChangeDuringMeasure := false.
	
	itemDecorations := OrderedCollection new.
	state := self defaultState.
	childrenUpdateRunnable := self defaultChildrenUpdateRunnable on: self.
	scrollFlinger := self defaultScrollFlinger on: self.
	self initializeDataSource.
	self initializeRecycler.
	
	"Should be initialized last"
	layout infiniteElement: self.
	
	self initializeEventHandlers
]

{ #category : #initialization }
BlInfiniteElement >> initializeDataSource [

	dataSource := self defaultDataSource.
	dataSource onAttached: self.
	dataSourceObserver := self defaultDataSourceObserver on: self.
	dataSource addEventHandler: dataSourceObserver.
	dataSourceManager := self defaultDataSourceManager
]

{ #category : #initialization }
BlInfiniteElement >> initializeEventHandlers [

	self addEventHandler: self defaultMouseScrollEventHandler
]

{ #category : #initialization }
BlInfiniteElement >> initializeRecycler [

	recycler := self defaultRecycler
]

{ #category : #'private - invalidation' }
BlInfiniteElement >> invalidateItemDecorations [
	"Invalidate all ItemDecorations.
	If I have item decorations, a layout update will be requested"

	self hasItemDecorations
		ifFalse: [ ^ self ].

	self assertNotInLayoutOrScroll.
	self markItemDecorationsInsetsDirty.
	self requestLayout
]

{ #category : #testing }
BlInfiniteElement >> isAttached [
	"Return true if I am attached to window, false otherwise"
	<return: #Boolean>

	^ self space isNotNil
]

{ #category : #testing }
BlInfiniteElement >> isComputingLayout [
	"Returns whether InfiniteElement is currently computing a layout.
	If this method returns true, it means that InfiniteElement is in a lockdown state and any
	attempt to update datasource contents will result in an exception because datasource contents
	cannot be changed while InfiniteElement is trying to compute the layout."
	<return: #Boolean>

	^ layoutOrScrollCounter > 0
]

{ #category : #testing }
BlInfiniteElement >> isDataSourceChangedAfterLayout [

	^ dataSourceChangedAfterLayout
]

{ #category : #testing }
BlInfiniteElement >> isFirstLayoutComplete [
	"Return true if layout process is completed, false otherwise.
	Set to true after onLayout: is done"
	<return: #Boolean>
	
	^ firstLayoutComplete
]

{ #category : #'item decorations - accessing' }
BlInfiniteElement >> itemDecorations [
	^ itemDecorations
]

{ #category : #'item decorations - accessing' }
BlInfiniteElement >> itemDecorationsDo: aBlock [

	itemDecorations ifNotNil: [ (itemDecorations asSortedCollection: [ :a :b | a priority < b priority ]) do: aBlock ]
]

{ #category : #'private - scrolling' }
BlInfiniteElement >> jumpToPositionForSmoothScroller: aPosition [

	self layout scrollToPosition: aPosition.
	self awakenScrollBars
]

{ #category : #layout }
BlInfiniteElement >> layoutFrozen: aBoolean [
	"Enable or disable layout and scroll.  After layoutFrozen is set to true,
	Layout requests will be postponed until layoutFrozen is set to false.
	Child elements are not updated when InfiniteElement is frozen"

	"aBoolean = layoutFrozen
		ifTrue: [ ^ self ].
		
	self assertNotInLayoutOrScroll.

	aBoolean
		ifFalse: [ 
			layoutFrozen := false.
			layoutRequestEaten
				ifTrue: [ self requestLayout ].
			layoutRequestEaten := false ]
		ifTrue: [ 
			layoutFrozen := true.
			self stopScroll ]"
]

{ #category : #accessing }
BlInfiniteElement >> layoutPositionsRange [

	"layouted children interval"
	^ layoutPositionsRange 
]

{ #category : #accessing }
BlInfiniteElement >> layoutPositionsRange: anInterval [

	"layouted children interval"
	layoutPositionsRange := anInterval
]

{ #category : #layout }
BlInfiniteElement >> markDataSourceChangeDuringMeasure [

	dataSourceChangeDuringMeasure := true
]

{ #category : #'private - invalidation' }
BlInfiniteElement >> markItemDecorationsInsetsDirty [

	self
		unfilteredChildrenDo: [ :anElement | 
		anElement constraints infinite insetsDirty: true ]
]

{ #category : #'private - invalidation' }
BlInfiniteElement >> markKnownElementsInvalid [

	"Mark all known elements as invalid. Used in response to a, the whole world might have changed data change event"

	self
		unfilteredChildrenDo: [ :anElement | 
			| anElementHolder |
			anElementHolder := self elementHolderOf: anElement.
			anElementHolder shouldIgnore ifFalse: [ 
				anElementHolder flags addUpdate.
				anElementHolder flags addInvalid ] ].

	self markItemDecorationsInsetsDirty
]

{ #category : #'accessing - properties' }
BlInfiniteElement >> maxFlingVelocity [
	^ 8000
]

{ #category : #'accessing - properties' }
BlInfiniteElement >> minFlingVelocity [
	^ 50
]

{ #category : #notifying }
BlInfiniteElement >> notifyChildAttached: anElement [
	"Notify all event handlers that element is attached to InfiniteElement"

	self dispatchEvent: (BlInfiniteElementAttachedEvent element: anElement)
]

{ #category : #notifying }
BlInfiniteElement >> notifyChildDetached: anElement [
	"Notify all event handlers that element is detached from InfiniteElement"

	self dispatchEvent: (BlInfiniteElementDetachedEvent element: anElement)
]

{ #category : #notifying }
BlInfiniteElement >> notifyScrollStateChanged: aScrollState [
	"Notify all event handlers that scroll state of InfiniteElement has been changed"

	self dispatchEvent: (BlInfiniteScrollChangedEvent scrollState: aScrollState)
]

{ #category : #'api - scrolling notifying' }
BlInfiniteElement >> notifyScrolled: aPoint [
	"Notify all event handlers that InfiniteElemnet scrolled by a delta point"

	self eventDispatcher dispatchScrolled: aPoint
]

{ #category : #'children - geometry' }
BlInfiniteElement >> offsetChildrenHorizontallyBy: aNumber [
	self childrenDo: [ :anElement |
		| previousPosition newPosition aBlBoundsUpdater |
		previousPosition := anElement position.
		newPosition := (previousPosition x + aNumber) @ previousPosition y.
	
		aBlBoundsUpdater := BlElementBoundsUpdater new.
		
		self flag: 'Implement BlElement>>#moveTo:'.
		anElement measuredBounds position: newPosition.
		anElement position: newPosition extent: anElement extent context: aBlBoundsUpdater.
		aBlBoundsUpdater commitChanges.
		
		self
			assert: [ newPosition closeTo: anElement position epsilon: BlElement epsilon ]
			description: [ 'Position didn''t change as expected! It is super important for scrolling, since we assume that I DO offset children by a number regardless of anything' ] ]
]

{ #category : #'children - geometry' }
BlInfiniteElement >> offsetChildrenVerticallyBy: aNumber [
	
	self childrenDo: [ :anElement |
		| previousPosition newPosition aBlBoundsUpdater |

		previousPosition := anElement position.
		newPosition := previousPosition x @ (previousPosition y + aNumber).
		aBlBoundsUpdater := BlElementBoundsUpdater new.
		
		self flag: 'Implement BlElement>>#moveTo:'.
		anElement measuredBounds position: newPosition.
		anElement position: newPosition extent: anElement extent context: aBlBoundsUpdater.
		aBlBoundsUpdater commitChanges.

		self
			assert: [ newPosition closeTo: anElement position epsilon: BlElement epsilon ]
			description: [ 'Position didn''t change as expected! It is super important for scrolling, since we assume that I DO offset children by a number regardless of anything' ] ]
]

{ #category : #'private - commands' }
BlInfiniteElement >> offsetPositionRecordsForInsert: aStartPosition itemCount: anItemCount [

	self unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder shouldIgnore not and: [
			 anElementHolder position >= aStartPosition ]) ifTrue: [
			anElementHolder offsetPositionBy: anItemCount ] ].
	self requestLayout
]

{ #category : #'private - commands' }
BlInfiniteElement >> offsetPositionRecordsForRemove: aPositionStart itemCount: anItemCount [

	| aPositionEnd |
	aPositionEnd := aPositionStart + anItemCount.

	self
		unfilteredChildrenDo: [ :anElement |
			| anElementHolder |
			anElementHolder := self elementHolderOf: anElement.
			anElementHolder shouldIgnore ifFalse: [
				anElementHolder position >= aPositionEnd
					ifTrue: [
						anElementHolder
							offsetPositionBy: anItemCount negated ]
					ifFalse: [
						anElementHolder position >= aPositionStart ifTrue: [
							anElementHolder
								flagRemovedAndOffsetPosition: aPositionStart - 1
								by: anItemCount negated ] ] ] ]
]

{ #category : #'hooks - children' }
BlInfiniteElement >> onChildAttached: anElement [
	"Sent when an item element is attached to this InfiniteElement.
	My subclasses may want to perform extra bookkeeping or modifications of child elements
	as they become attached. This will be called before an InfiniteLayout measures or lays out
	the element and is a good time to perform these changes"
]

{ #category : #'hooks - children' }
BlInfiniteElement >> onChildDetached: anElement [
	"I sent when an item element is detached from this InfiniteElement.
	My subclasses may want to perform extra bookkeeping or modifications
	of child elements as they become detached. This will be sent as an
	InfiniteLayout fully detaches the child element from the parent"
]

{ #category : #'hooks - layout' }
BlInfiniteElement >> onEnterLayoutOrScroll [

	layoutOrScrollCounter := layoutOrScrollCounter + 1
]

{ #category : #'hooks - layout' }
BlInfiniteElement >> onExitLayoutOrScroll [

	layoutOrScrollCounter := layoutOrScrollCounter - 1.

	layoutOrScrollCounter < 0 ifFalse: [ ^ self ].
	self error: 'layout or scroll counter cannot go below zero'.
	"it is important anyway to set counter to 0"
	layoutOrScrollCounter := 0
]

{ #category : #layout }
BlInfiniteElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	self dispatchLayout.
	firstLayoutComplete := true.

	self layout
		layoutIgnored: self
		context: aBlElementBoundsUpdateContext
]

{ #category : #'hooks - layout' }
BlInfiniteElement >> onLayoutDone [
	"update decorations bounds after layout"

	| remainingBounds |
	remainingBounds := self bounds asRectangle.
	self itemDecorationsDo: [ :d |
		remainingBounds := d onLayoutDoneIn: self remaining: remainingBounds ].
	super onLayoutDone.


]

{ #category : #measurement }
BlInfiniteElement >> onMeasure: anExtentMeasurementSpec [

	layout shouldAutoMeasure
		ifTrue: [ self onMeasureAuto: anExtentMeasurementSpec ]
		ifFalse: [ self onMeasureCustom: anExtentMeasurementSpec ].
		
	self layout measureIgnored: self with: anExtentMeasurementSpec
]

{ #category : #measurement }
BlInfiniteElement >> onMeasureAuto: anExtentMeasurementSpec [

	| skipMeasure |
	skipMeasure := anExtentMeasurementSpec isExact.
	layout measure: self with: anExtentMeasurementSpec.
	skipMeasure ifTrue: [ ^ self ].
	state isStartStep ifTrue: [ self dispatchLayoutFirstStep ].
	layout measurementSpec: anExtentMeasurementSpec.
	self dispatchLayoutSecondStep.
	layout measureBasedOnChildren: anExtentMeasurementSpec.
	layout shouldMeasureTwice ifFalse: [ ^ self ].
	state beStepLayout.
	layout measurementSpec:
		(BlExtentMeasurementSpec exact: self measuredExtent).
	self dispatchLayoutSecondStep.
	layout measureBasedOnChildren: anExtentMeasurementSpec
]

{ #category : #measurement }
BlInfiniteElement >> onMeasureCustom: anExtentMeasurementSpec [
		
	"custom onMeasure"
	dataSourceChangeDuringMeasure ifTrue: [ 
		self processDataSourceCommands.
		dataSourceChangeDuringMeasure := false ].
	
	state itemCount: dataSource itemCount.
	layout measure: self with: anExtentMeasurementSpec
]

{ #category : #'hooks - scrolling' }
BlInfiniteElement >> onScrollStateChanged: aScrollingState [
	"Called when the scroll state of InfiniteElement changes.
	Subclasses should use this method to respond to state changes instead of an explicit listener.
	This method will always be invoked before firing events, but after the Layout responds to the scroll state change"
]

{ #category : #'hooks - scrolling' }
BlInfiniteElement >> onScrolled: aPoint [

	"Sent when the scroll position of this InfiniteElement changes. Subclasses should use
	this method to respond to scrolling within the datasource's data set instead of an explicit event handler.
	I will always be invoked before event handlers. If a subclass needs to perform any additional upkeep
	or bookkeeping after scrolling but before events fired, this is a good place to do so"

	"self itemDecorationsDo: [ :d | d onScrollDoneIn: self ]"
]

{ #category : #'deferred actions' }
BlInfiniteElement >> postChildrenUpdater [
	"Post children update runnable to consume update operations"
	
	childrenUpdateRunnable isQueued ifTrue: [ ^ self ].
	" Allow re-lauching of the same task"
	childrenUpdateRunnable setNew.
	" enqueue the children update task "
	self enqueueTask: childrenUpdateRunnable
]

{ #category : #'deferred actions' }
BlInfiniteElement >> postSmoothScroller [
	scrollFlinger postOnAnimation
]

{ #category : #'accessing - properties' }
BlInfiniteElement >> prefetchingAllowed [
	^ false
]

{ #category : #'private - commands' }
BlInfiniteElement >> processDataSourceCommands [

	"Consumes data source commands.
	Is sent in onMeasure and dispatchLayout.
	This method may process only the pre-layout state of updates or all of them."

	dataSourceChangedAfterLayout ifTrue: [ 
		dataSourceManager resetCommands.
		self markKnownElementsInvalid.
		layout onItemsChanged ].

	dataSourceManager consumeCommandsIn: self
]

{ #category : #'private - scrolling' }
BlInfiniteElement >> pullGlows: anEventPoint overscroll: anOverScrollPoint [
]

{ #category : #'private - focus' }
BlInfiniteElement >> recoverFocusFromState [

	| aFocusTarget |
	self hasFocus ifFalse: [ ^ self ].

	"only recover focus if InfiniteElement itself has the focus"
	self isFocused ifFalse: [ self focusedChild ifNil: [ ^ self ] ].

	aFocusTarget := nil.

	state focusedItemPosition ~= NoPosition ifTrue: [ 
		aFocusTarget := self findElementHolderForDataSourcePosition: state focusedItemPosition ].

	(aFocusTarget isNil and: [ state focusedItemId ~= NoId and: [ dataSource hasStableIds ] ]) ifTrue: [ 
		aFocusTarget := self findElementHolderForItemId: state focusedItemId ].

	(aFocusTarget isNil or: [ aFocusTarget itemElement hasFocus or: [ aFocusTarget itemElement hasFocusable not ] ]) 
		ifTrue: [ ^ self ]

	"could not find element to give focus to"
]

{ #category : #accessing }
BlInfiniteElement >> recycler [
	<return: #BlInfiniteRecycler>

	^ recycler
]

{ #category : #'children add/remove' }
BlInfiniteElement >> removeChild: aChildElement [
	"Remove aChildElement from infinite element
	and do not track it anymore (unhide and remove from bucket)"

	| index |
	index := self childIndexOf: aChildElement.
	index <= 0 ifTrue: [ ^ self ].

	self removeChildAt: index
]

{ #category : #'children add/remove' }
BlInfiniteElement >> removeChildAt: anIndex [ 

	"Remove a child at anIndex from infinite element
	and do not track it anymore."

	| anElement |	
	anElement := self children 
		at: anIndex
		ifAbsent: [ ^ self ].

	self dispatchChildDetached: anElement.
	super removeChildAt: anIndex
]

{ #category : #'children add/remove' }
BlInfiniteElement >> removeDetachedChild: anElement [
	| anElementHolder |
	
	anElementHolder := self elementHolderOf: anElement.
	
	anElementHolder isTmpDetached
		ifTrue: [ anElementHolder clearTmpDetached ]
		ifFalse: [ anElementHolder shouldIgnore
			ifFalse: [ self error: 'Trying to removeDetachedChild: which is not flagged as temporary detached!' ] ].
	
	self dispatchChildDetached: anElement.
	super removeDetachedChild: anElement
]

{ #category : #layout }
BlInfiniteElement >> requestLayout: anElement [
	
	"Layout may be requested by one of my children.
	If it is the case we should let layout request to pass further"
	self flag: 'Find a way to avoid unnecessary requests'.
	"anElement == self
		ifFalse: [ ^ super requestLayout: anElement ]."
	
	super requestLayout: anElement.

	"(eatRequestLayoutCounter isZero and: [ layoutFrozen not ])
		ifTrue: [ super requestLayout: anElement ]
		ifFalse: [ self markLayoutRequestEaten ]"
]

{ #category : #'private - focus' }
BlInfiniteElement >> resetFocusInfo [
	"Reset all stored focus information from my state"

	state focusedItemId: NoId.
	state focusedItemPosition: NoPosition.
	state focusedSubChild: nil
]

{ #category : #'private - focus' }
BlInfiniteElement >> saveFocusInfo [
	"I save information of currently focused element in the state.
	In order to restore foces later we need to save item's position
	in data source, its stable it if any and store reference
	to the focused sub child of item's element to give it focus directly"
	| aFocusedElement aFocusedElementHolder |
	
	aFocusedElement := nil.
	
	self hasFocus
		ifTrue: [ aFocusedElement := self focusedChild ].
	
	aFocusedElementHolder := aFocusedElement
		ifNotNil: [ :anElement | self childHolderContainingItemElement: anElement ].
		
	aFocusedElementHolder
		ifNil: [ self resetFocusInfo ]
		ifNotNil: [ 
			state focusedItemId: (dataSource hasStableIds
				ifTrue: [ aFocusedElementHolder itemId ]
				ifFalse: [ NoId ]).
			state focusedItemPosition: (dataSourceChangedAfterLayout
				ifTrue: [ NoPosition ]
				ifFalse: [ aFocusedElementHolder dataSourcePosition ]).
			state focusedSubChild: (self deepestFocusedChildIn: aFocusedElementHolder itemElement) ]
]

{ #category : #scrolling }
BlInfiniteElement >> scrollBy: aPoint [ 
	| canScrollHorizontal canScrollVertical |
		
	canScrollHorizontal := self layout canScrollHorizontally.
	canScrollVertical := self layout canScrollVertically.
	
	(canScrollHorizontal or: [ canScrollVertical ])
		ifTrue: [ 
			self scrollByInternal: (canScrollHorizontal
				ifTrue: [ aPoint x ]
				ifFalse: [ 0 ]) @ (canScrollVertical
					ifTrue: [ aPoint y ]
					ifFalse: [ 0 ])
			from: nil ]
]

{ #category : #'private - scrolling' }
BlInfiniteElement >> scrollByInternal: aDeltaPoint from: anEventPoint [
	<return: #Boolean>
	| unconsumedX unconsumedY consumedX consumedY |

	unconsumedX := unconsumedY := consumedX := consumedY := 0.
	self consumePendingDataSourceCommands.
	self onEnterLayoutOrScroll.
	
	aDeltaPoint x isZero
		ifFalse: [ 
			consumedX := self layout scrollHorizontallyBy: aDeltaPoint x.
			unconsumedX := aDeltaPoint x - consumedX ].
	aDeltaPoint y isZero
		ifFalse: [ 
			consumedY := self layout scrollVerticallyBy: aDeltaPoint y.
			unconsumedY := aDeltaPoint y - consumedY ].
	
	self onExitLayoutOrScroll.
	
	(consumedX isZero and: [ consumedY isZero ])
		ifFalse: [ self dispatchOnScrolled: consumedX @ consumedY ].
	
	^ consumedX isZero not or: [ consumedY isZero not ]
]

{ #category : #'api - scrolling accessing' }
BlInfiniteElement >> scrollFlinger [
	^ scrollFlinger
]

{ #category : #'api - scrolling' }
BlInfiniteElement >> scrollHorizontallyBy: aNumber [
	"Scroll horizontally by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."
	<return: #Number>

	^ self layout scrollHorizontallyBy: aNumber
]

{ #category : #'api - scrolling geometry' }
BlInfiniteElement >> scrollPosition [
	<return: #Point>
	
	^ 0@0
]

{ #category : #'private - scrolling accessing' }
BlInfiniteElement >> scrollState [
	"Return the current scrolling state"
	<return: #Symbol>
	
	^ scrollState
]

{ #category : #'private - scrolling accessing' }
BlInfiniteElement >> scrollState: aScrollState [
	"Internal! Never set me directly"

	 scrollState = aScrollState
		ifTrue: [ ^ self ].

	scrollState := aScrollState.
	scrollState ~= ScrollSettling
		ifTrue: [ self stopScrollersInternal ].

	self dispatchScrollStateChanged: aScrollState
]

{ #category : #scrolling }
BlInfiniteElement >> scrollToPosition: aPosition [
	"Convenience method to scroll to a certain datasource position.
	InfiniteElement does not implement scrolling logic, rather forwards the call to
   InfiniteElement>>#scrollToPosition:"

	self stopScroll.
	self layout scrollToPosition: aPosition.
	self awakenScrollBars
]

{ #category : #scrolling }
BlInfiniteElement >> scrollToPosition: aPosition offset: anOffset [
	"Scroll the InfiniteELement to make the datasource position visible with the given offset from resolved layout start.
	For example, if layout is ===vertical=== and ===stackFromEnd=== is true,
	sending ===scrollToPosition: 10 offset: 20=== will layout such that 10th item's
	bottom is 20 pixels above the InfiniteElement's bottom.
	Note: scroll position change will not be reflected until the next layout cycle (space pulse)"

	self stopScroll.
	self layout scrollToPosition: aPosition offset: anOffset.
	self awakenScrollBars
]

{ #category : #'api - scrolling' }
BlInfiniteElement >> scrollVerticallyBy: aNumber [
	"Scroll vertically by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."

	^ self layout scrollVerticallyBy: aNumber
]

{ #category : #'private - invalidation' }
BlInfiniteElement >> setDataSourceChangedAfterLayout [

	"We already set that data source is changed"

	dataSourceChangedAfterLayout ifTrue: [ ^ self ].

	dataSourceChangedAfterLayout := true.
	self
		unfilteredChildrenDo: [ :anElement | 
			| anElementHolder |
			anElementHolder := self elementHolderOf: anElement.
			anElementHolder shouldIgnore ifFalse: [ 
				anElementHolder flags addDataSourcePositionUnknown ] ].

	"immediately mark all elements as invalid, so prefetched ones can be
	differentiated from elements bound to previous data set - both in children, and cache"
	self markKnownElementsInvalid
]

{ #category : #scrolling }
BlInfiniteElement >> smoothScrollBy: aPoint [
	"Animate a scroll by the given amount of pixels along either axis"
	| dX dY |
	
	dX := aPoint x.
	dY := aPoint y.
	
	self canScrollHorizontally
		ifFalse: [ dX := 0 ].
	
	self canScrollVertically
		ifFalse: [ dY := 0 ].
	
	(dX isZero and: [ dY isZero ])
		ifFalse: [ scrollFlinger smoothScrollBy: dX @ dY ]
]

{ #category : #scrolling }
BlInfiniteElement >> smoothScrollToPosition: aPosition [
	"Starts a smooth scroll to a datasource position."
	
	self layout smoothScrollToPosition: aPosition
]

{ #category : #'api - scrolling accessing' }
BlInfiniteElement >> smoothScroller [
	"Return currently used smooth scroller or nil if I am not in a smooth scrolling state"
	<return: #BlSmoothScroller or: nil>

	^ self layout smoothScroller
]

{ #category : #accessing }
BlInfiniteElement >> state [
	^ state
]

{ #category : #scrolling }
BlInfiniteElement >> stopScroll [
	"Stop any current scroll in progress, such as one started by
		- #smoothScrollBy:
		- #fling:
		- or a touch-initiated fling"

	self scrollState: ScrollIdle.
	self stopScrollersInternal
]

{ #category : #'private - scrolling' }
BlInfiniteElement >> stopScrollersInternal [
	"Similar to #stopScroll but does not set the state"

	scrollFlinger stop.
	self layout stopSmoothScroller
]

{ #category : #'children - accessing' }
BlInfiniteElement >> unfilteredChildrenDo: aBlock [
	"Do not remove children in a Block!"

	| aChildCount |
	aChildCount := self childrenCount.
	1 to: aChildCount do: [ :anIndex |
	aBlock value: (self childAt: anIndex) ]
]

{ #category : #'children - accessing' }
BlInfiniteElement >> unfilteredChildrenReverseDo: aBlock [
	"Do not remove children in a Block!"

	| aChildCount |
	aChildCount := self childrenCount.
	aChildCount to: 1 by: -1 do: [ :anIndex |
	aBlock value: (self childAt: anIndex) ]
]

{ #category : #'accessing - decoration' }
BlInfiniteElement >> withDecoration: aDecorationClass [

	self itemDecorations
		detect: [ :d | d isKindOf: aDecorationClass ]
		ifNone: [ 
			self itemDecorations add: aDecorationClass new.
			self invalidateItemDecorations ]
]

{ #category : #'view - configuration' }
BlInfiniteElement >> withRowNumbers [

	self withDecoration: BlRowNumberDecoration
]

{ #category : #'accessing - decoration' }
BlInfiniteElement >> withoutDecoration: aDecorationClass [

	itemDecorations := self itemDecorations reject: [ :d | 
		                   (d isKindOf: aDecorationClass)
			                   ifTrue: [ 
				                   self invalidateItemDecorations.
				                   true ]
			                   ifFalse: [ false ] ]
]

{ #category : #'view - configuration' }
BlInfiniteElement >> withoutRowNumbers [

	self withoutDecoration: BlRowNumberDecoration
]
