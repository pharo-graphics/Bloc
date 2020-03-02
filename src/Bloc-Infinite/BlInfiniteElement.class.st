"
I'm an element which is supposed to contain huge amount of children and layout only those of them that are visible inside my viewport.
I work with DataSources to fetch data from and can present data within different Infinite Layouts.

I fire the following events:
   - BlInfiniteChildDetachedEvent when a child element is detached

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
		'childrenManager',
		'state',
		'recycler',
		'itemAnimator',
		'hasFixedSize',
		'layoutOrScrollCounter',
		'dispatchScrollCounter',
		'layoutFrozen',
		'layoutRequestEaten',
		'itemAnimationRunner',
		'itemDecorations',
		'dataSourceChangedAfterLayout',
		'firstLayoutComplete',
		'itemsAddedOrRemoved',
		'itemsChanged',
		'infoStore',
		'preserveFocusAfterLayout',
		'layoutPositionsRange',
		'infoStoreProcessor',
		'eatRequestLayoutCounter',
		'childrenUpdateRunnable',
		'dataSourceChangeDuringMeasure',
		'dataSourceObserver',
		'scrollFlinger',
		'scrollState',
		'overScrollMode'
	],
	#pools : [
		'BlInfiniteConstants'
	],
	#category : #'Bloc-Infinite-! Core'
}

{ #category : #'children - add/remove' }
BlInfiniteElement >> addAnimatingChild: anElementHolder [
	"Adds a element to the animatingElements list.
	animatingElements holds the child elements that are currently being kept around
	purely for the purpose of being animated out of view. They are drawn as a regular
	part of the child list of the InfiniteElement, but they are invisible to the Layout
	as they are managed separately from the regular child elements"
	| anElement alreadyParented |
	
	anElement := anElementHolder itemElement.
	alreadyParented := anElement parent == self.
	
	recycler unscrapHolder: (self childHolderOf: anElement).
	anElementHolder isTmpDetached
		"re-attach"
		ifTrue: [ childrenManager attachChild: anElement at: 0 hidden: true ]
		ifFalse: [ alreadyParented
			ifFalse: [ childrenManager addChild: anElement hidden: true ]
			ifTrue: [ childrenManager hide: anElement ] ]
]

{ #category : #animations }
BlInfiniteElement >> animateAppearance: anElementHolder preInfo: aPreInfoHolder postInfo: aPostInfoHolder [
	
	anElementHolder isRecyclable: false.

	(itemAnimator
		animateAppearance: anElementHolder
		preLayoutInfo: aPreInfoHolder
		postLayoutInfo: aPostInfoHolder)
			ifTrue: [ self postAnimationRunner ]
]

{ #category : #animations }
BlInfiniteElement >> animateChangeFrom: anOldElementHolder to: aNewElementHolder preInfo: aPreInfoHolder postInfo: aPostInfoHolder oldHolderDisappearing: oldHolderDisappearing newHolderDisappearing: newHolderDisappearing [

	anOldElementHolder isRecyclable: false.
	oldHolderDisappearing
		ifTrue: [ self addAnimatingChild: anOldElementHolder ].
	
	(anOldElementHolder ~~ aNewElementHolder)
		ifTrue: [ 
			newHolderDisappearing
				ifTrue: [ self addAnimatingChild: aNewElementHolder ].
			anOldElementHolder shadowedHolder: aNewElementHolder.
			"old holder should disappear after animation ends"
			self addAnimatingChild: anOldElementHolder.
			recycler unscrapHolder: anOldElementHolder.
			aNewElementHolder isRecyclable: false.
			aNewElementHolder shadowingHolder: anOldElementHolder ].
	
	(itemAnimator
		animateChange: aNewElementHolder
		previousHolder: anOldElementHolder
		preLayoutInfo: aPreInfoHolder
		postLayoutInfo: aPostInfoHolder)
			ifTrue: [ self postAnimationRunner ]
]

{ #category : #animations }
BlInfiniteElement >> animateDisappearance: anElementHolder preInfo: aPreInfoHolder postInfo: aPostInfoHolder [

	self addAnimatingChild: anElementHolder.
	anElementHolder isRecyclable: false.
	
	(itemAnimator
		animateDisappearance: anElementHolder
		preLayoutInfo: aPreInfoHolder
		postLayoutInfo: aPostInfoHolder)
			ifTrue: [ self postAnimationRunner ]
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

{ #category : #'api - scrolling testing' }
BlInfiniteElement >> canScrollHorizontally [
	"Return true if I can scroll the current contents horizontally, false otherwise"
	<return: #Boolean>

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
	"Return the datasource position of the given child element as of the latest completed layout pass.
	This position may not be equal to Item's datasource position if there are pending changes
	in the datasource which have not been reflected to the layout yet"
	<return: #Number>

	^ (self elementHolderOf: anElement) layoutPosition

]

{ #category : #accessing }
BlInfiniteElement >> childrenManager [
	^ childrenManager
]

{ #category : #'private - positions' }
BlInfiniteElement >> clearOldPositions [

	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore
			ifFalse: [ anElementHolder clearOldPosition ] ].
		
	recycler clearOldPositions
]

{ #category : #'private - commands' }
BlInfiniteElement >> consumePendingDataSourceCommands [
	"I help to reflect data changes to the state.
	DataSource changes during a scroll may trigger a crash because scroll assumes no data change but data actually changed.
	I consume all deferred changes to avoid that case."

	(firstLayoutComplete not or: [ dataSourceChangedAfterLayout ])
		ifTrue: [ ^ self dispatchLayout ].
	
	dataSourceManager hasPendingCommands
		ifFalse: [ ^ self ].

	"if it is only an item change (no add-remove-move) we can check
	if any of the visible items is affected and if not, just ignore the change."
	dataSourceManager hasOnlyUpdateCommand
		ifTrue: [ 
			self eatRequestLayout.
			dataSourceManager preProcessCommands.
			layoutRequestEaten ifFalse: [ 
				self hasUpdatedChild
					ifTrue: [ self dispatchLayout ]
					"no need to layout, clean state"
					ifFalse: [ dataSourceManager consumePostponedCommands ] ].
			self resumeRequestLayout: true ]
		ifFalse: [
			 dataSourceManager hasPendingCommands
				ifTrue: [ self dispatchLayout ] ]
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

{ #category : #'as yet unclassified' }
BlInfiniteElement >> dataSourcePositionOf: anElementHolder [
	<return: #Number>
	
	(anElementHolder flags hasInvalid or: [
		anElementHolder flags hasRemoved or: [ 
			anElementHolder flags hasDataSourcePositionUnknown or: [
				anElementHolder isBound not ] ] ])
		ifTrue: [ ^ NoPosition ].
		
	^ self dataSourceManager applyPendingCommandsOnPosition: anElementHolder position
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

{ #category : #'children - geometry' }
BlInfiniteElement >> decorationInsets: anElement [
	"Return decoration insets for the given element"
	<return: #Rectangle>
	| anInfiniteConstraints |

	anInfiniteConstraints := anElement constraints infinite.
	anInfiniteConstraints insetsDirty
		ifTrue: [ ^ anInfiniteConstraints decorationInsets ].
	
	(self state isPreLayout and: [
		anInfiniteConstraints isItemChanged or: [
			anInfiniteConstraints isElementInvalid ] ])
				"changed/invalid items should not be updated until they are rebound"
				ifTrue: [ ^ anInfiniteConstraints decorationInsets ].
	
	self flag: 'Implement decorations'.
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
BlInfiniteElement >> defaultChildrenController [
	^ BlInfiniteDefaultChildrenController new
]

{ #category : #initialization }
BlInfiniteElement >> defaultChildrenManager [
	^ BlInfiniteChildrenManager new
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
BlInfiniteElement >> defaultDataSourceController [
	^ BlInfiniteDefaultDataSourceController new
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
BlInfiniteElement >> defaultInfoStore [
	^ BlInfiniteElementInfoStore new
]

{ #category : #initialization }
BlInfiniteElement >> defaultInfoStoreProcessor [
	"Return class, actuall instantiation happens in initialize"
	^ BlInfiniteElementInfoStoreDefaultProcessor
]

{ #category : #initialization }
BlInfiniteElement >> defaultItemAnimator [
	^ BlInfiniteItemAnimator new
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
BlInfiniteElement >> defaultOverScrollMode [
	^ BlOverScrollMode never
]

{ #category : #initialization }
BlInfiniteElement >> defaultRecycler [
	^ BlInfiniteRecycler new
]

{ #category : #initialization }
BlInfiniteElement >> defaultRecyclerController [
	^ BlInfiniteRecyclerController new
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

{ #category : #'private - positions' }
BlInfiniteElement >> didChildPositionsRangeChange: anInterval [

	<return: #Boolean>

	^ self findMinMaxChildLayoutPositions ~= anInterval
]

{ #category : #dispatching }
BlInfiniteElement >> dispatchChildAttached: anElement [
	"I am used by
		- ChildrenController's addChild:at:"
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

	self state isMeasuring: false.
	self state isStartStep
		ifTrue: [
			self dispatchLayoutFirstStep.
			self layout exactMeasurementSpecFrom: self.
			self dispatchLayoutSecondStep ]
		ifFalse: [ 
			(dataSourceManager hasCommands or: [
				layout width ~= self width or: [ 
					layout height ~= self height ] ])
				ifTrue: [
					self layout exactMeasurementSpecFrom: self.
					self dispatchLayoutSecondStep ]
				ifFalse: [ self layout exactMeasurementSpecFrom: self ] ].
	self dispatchLayoutThirdStep
]

{ #category : #layout }
BlInfiniteElement >> dispatchLayoutFirstStep [
	"The first step of a layout where we
  		- process data source updates
		- decide which animation should run
		- save information about current child elements
		- If necessary, run predictive layout and save its information"

	self state assertLayoutStep: BlInfiniteLayoutStepFlags Start.
	self state isMeasuring: false.
	self eatRequestLayout.
	infoStore clear.
	self onEnterLayoutOrScroll.
	self processDataSourceCommandsAndSetAnimationFlags.
	self saveFocusInfo.
	self state trackOldChangeHolders: (self state willRunSimpleAnimations and: [ itemsChanged ]).
	itemsAddedOrRemoved := false.
	itemsChanged := false.
	self state isPreLayout: self state willRunPredictiveAnimations.
	self state itemCount: self dataSource itemCount.
	layoutPositionsRange := self findMinMaxChildLayoutPositions.
	
	self state willRunSimpleAnimations
		ifTrue: [ self dispatchLayoutFirstStepSimpleAnimations ].
		
	self state willRunPredictiveAnimations
		ifTrue: [ self dispatchLayoutFirstStepPredictiveAnimations ].
	
	self clearOldPositions.
	self onExitLayoutOrScroll.
	self resumeRequestLayout: false.
	self state beStepLayout
]

{ #category : #layout }
BlInfiniteElement >> dispatchLayoutFirstStepPredictiveAnimations [
	"Perform prelayout. I will use the old positions of items.
	The infinite layout is expected to layout everything,
	even removed items (though not to add removed items back to the container).
	This gives the pre-layout position of APPEARING views which come into existence as part of the real layout"
	| didStructureChange |
	
	"Save old positions so that InfiniteLayout can run its mapping logic."
	self saveOldPositions.
	
	"temporarily disable flag because we are asking for previous layout"
	didStructureChange := self state didStructureChange.
	self state structureChanged: false.
	layout layoutChildrenIn: self recycler state: self state.
	self state structureChanged: didStructureChange.
	
	childrenManager childrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder shouldIgnore or: [
			infoStore isInPreLayout: anElementHolder ])
				ifFalse: [ 
					| theFlags wasHidden anAnimationInfo |
					theFlags := itemAnimator buildDataSourceChangeFlagsForAnimations: anElementHolder.
					wasHidden := anElementHolder flags hasBouncedFromHiddenList.
					wasHidden
						ifFalse: [ theFlags addAppearedInPreLayout ].
					anAnimationInfo := itemAnimator
						recordPreLayoutInformation: self state
						holder: anElementHolder
						flags: theFlags
						payloads: anElementHolder payloads.
					wasHidden
						ifTrue: [ self recordAnimationInfoIfBouncedHidden: anElementHolder itemHolder: anAnimationInfo ]
						ifFalse: [ infoStore addToAppearedInPreLayout: anElementHolder itemHolder: anAnimationInfo ] ] ]
]

{ #category : #layout }
BlInfiniteElement >> dispatchLayoutFirstStepSimpleAnimations [
	"Find out where all non-removed items are, pre-layout"
	
	self
		assert: [ self state willRunSimpleAnimations ]
		description: [ 'My state must be running simple animations!' ].

	childrenManager childrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder shouldIgnore or: [
			anElementHolder isInvalid and: [
				dataSource hasStableIds not ] ])
			ifFalse: [ 
				| animationInfo |
				animationInfo := itemAnimator
					recordPreLayoutInformation: self state
					holder: anElementHolder
					flags: (itemAnimator buildDataSourceChangeFlagsForAnimations: anElementHolder)
					payloads: anElementHolder payloads.
				
				infoStore addToPreLayout: anElementHolder itemHolder: animationInfo.
				
				(self state trackOldChangeHolders and: [
					anElementHolder isUpdated and: [
						anElementHolder isRemoved not and: [ 
							anElementHolder shouldIgnore not and: [ 
								anElementHolder isInvalid not ] ] ] ])
					ifTrue: [ 
						| aKey |
						aKey := self changedHolderKeyOf: anElementHolder.
						infoStore addToOldChangeHolders: anElementHolder at: aKey ] ] ]
]

{ #category : #layout }
BlInfiniteElement >> dispatchLayoutSecondStep [
	"The second layout step where we do the actual layout of the element for the final state.
	This step might be run multiple times if necessary (e.g. measure)."
	
	self eatRequestLayout.
	self onEnterLayoutOrScroll.
	
	self state
		assertLayoutStep: BlInfiniteLayoutStepFlags Layout
		or: BlInfiniteLayoutStepFlags Animations.
	
	dataSourceManager consumeCommandsInOnePass.
	self state itemCount: dataSource itemCount.
	self state deletedInvisibleItemCountSincePreviousLayout: 0.
	
	"Run layout"
	self state isPreLayout: false.
	layout layoutChildrenIn: self recycler state: self state.
	self state structureChanged: false.
	
	"layoutChildren may have caused user code to disable item animations; re-check"
	self state runSimpleAnimations: (self state willRunSimpleAnimations and: [ itemAnimator supportsAnimations ]).
	self state beStepAnimations.
	self onExitLayoutOrScroll.
	self resumeRequestLayout: false
]

{ #category : #layout }
BlInfiniteElement >> dispatchLayoutThirdStep [
	"The final step of the layout where we save the information about elements for animations,
	trigger animations and do any necessary cleanup."
	
	self state assertLayoutStep: BlInfiniteLayoutStepFlags Animations.
	self eatRequestLayout.
	self onEnterLayoutOrScroll.
	self state beStepStart.
	
	self state willRunSimpleAnimations
		ifTrue: [ self dispatchLayoutThirdStepSimpleAnimations ].
	
	layout removeAndRecycleScrap.
	self state previousLayoutItemCount: self state itemCount.
	dataSourceChangedAfterLayout := false.
	self state runSimpleAnimations: false.
	self state runPredictiveAnimations: false.
	self layout requestedSimpleAnimations: false.

	self recycler removeChangedScrap.
	layout layoutCompleted.
	self onExitLayoutOrScroll.
	self resumeRequestLayout: false.
	infoStore clear.
	
	(self didChildPositionsRangeChange: layoutPositionsRange)
		ifTrue: [ self dispatchOnScrolled: 0@0 ].
	self recoverFocusFromState.
	self resetFocusInfo
]

{ #category : #layout }
BlInfiniteElement >> dispatchLayoutThirdStepSimpleAnimations [
	"Find out where things are now, and process change animations.
	Traverse list in reverse because we may call animateChange in the loop which may
	remove the target element holder"	
	
	childrenManager childrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore ifFalse: [ 
			| aKey anAnimationInfo oldChangeHolder |
			aKey := self changedHolderKeyOf: anElementHolder.
			anAnimationInfo := itemAnimator recordPostLayoutInformation: self state holder: anElementHolder.
			oldChangeHolder := infoStore oldChangedHolderAt: aKey.
			(oldChangeHolder isNotNil and: [ oldChangeHolder shouldIgnore not ])
				ifTrue: [ 
					| oldDisappearing newDisappearing |
					"run a change animation"
					oldDisappearing := infoStore isDisappearing: oldChangeHolder.
					newDisappearing := infoStore isDisappearing: anElementHolder.
					(oldDisappearing and: [ oldChangeHolder == anElementHolder ])
						"run disappear animation instead of change"
						ifTrue: [ infoStore addToPostLayout: anElementHolder itemHolder: anAnimationInfo ]
						ifFalse: [ 
							| aPreInfo aPostInfo |
							aPreInfo := infoStore popFromPreLayout: oldChangeHolder.
							"we add and remove so that any post info is merged"
							infoStore addToPostLayout: anElementHolder itemHolder: anAnimationInfo.
							aPostInfo := infoStore popFromPostLayout: anElementHolder.
							aPreInfo
								ifNil: [ self handleMissingPreInfoForChange: anElementHolder oldChangeHolder: oldChangeHolder at: aKey ]
								ifNotNil: [ self flag: 'animateChange(oldChangeViewHolder, holder, preInfo, postInfo, oldDisappearing, newDisappearing)' ] ] ]
				ifFalse: [ 
					infoStore addToPostLayout: anElementHolder itemHolder: anAnimationInfo ] ] ].
	
	"Process element info lists and trigger animations"
	infoStore processOn: infoStoreProcessor
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

{ #category : #layout }
BlInfiniteElement >> eatRequestLayout [

	eatRequestLayoutCounter := eatRequestLayoutCounter + 1.
	(eatRequestLayoutCounter = 1 and: [ layoutFrozen not ])
		ifTrue: [ layoutRequestEaten := false ]
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
BlInfiniteElement >> elementRangeUpdate: aPositionStart itemCount: anItemCount payload: anObject [
	"Rebind existing elements for the given range, or create new as needed"
	| aPositionEnd |

	aPositionEnd := aPositionStart + anItemCount.
	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore
			ifFalse: [ 
				(anElementHolder position >= aPositionStart and: [ anElementHolder position < aPositionEnd ])
					ifTrue: [ 
						"We re-bind these elements holders after pre-processing is complete so that
						ElementHolders have their final positions assigned."
						anElementHolder flags addUpdate.
						anElementHolder addPayload: anObject.
						anElement constraints infinite insetsDirty: true ] ] ].
	
	recycler elementRangeUpdate: aPositionStart itemCount: anItemCount
]

{ #category : #'children - accessing' }
BlInfiniteElement >> findElementHolderForDataSourcePosition: aPosition [
	"Return the ViewHolder for the item in the given position of the data set"
	<return: #BlInfiniteHolder or: nil>

	| aHiddenHolder |
	dataSourceChangedAfterLayout
		ifTrue: [ ^ nil ].

	aHiddenHolder := nil.

	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder isRemoved not and: [ (self dataSourcePositionOf: anElementHolder) = aPosition ])
			ifTrue: [
				(childrenManager isHidden: anElementHolder itemElement)
					ifTrue: [ aHiddenHolder := anElementHolder ]
					ifFalse: [ ^ anElementHolder ] ] ].

	^ aHiddenHolder
]

{ #category : #'children - accessing' }
BlInfiniteElement >> findElementHolderForItemId: anId [
	self shouldBeImplemented
]

{ #category : #'children - accessing' }
BlInfiniteElement >> findElementHolderForPosition: aPosition checkNew: shouldCheckNewPosition [
	<return: #BlInfiniteHolder or: nil>
	| aHiddenElement |
	
	aHiddenElement := nil.
	
	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder isRemoved
			ifFalse: [ 
				| shouldSkip |
				shouldSkip := shouldCheckNewPosition
					ifTrue: [ anElementHolder position ~= aPosition ]
					ifFalse: [ anElementHolder layoutPosition ~= aPosition ].
				shouldSkip
					ifFalse: [ 
						(childrenManager isHidden: anElementHolder itemElement)
							ifTrue: [ aHiddenElement := anElementHolder ]
							ifFalse: [ ^ anElementHolder ] ]	] ].
	
	"We should not query cached element. It creates a problem during data source updates
	when we are dealing with already laid out elements. Also, for the public use, it is more
	reasonable to return null if position is not laid out"
	^ aHiddenElement
]

{ #category : #'private - positions' }
BlInfiniteElement >> findMinMaxChildLayoutPositions [
	<return: #Interval>
	
	| minPositionPreLayout maxPositionPreLayout |
	
	childrenManager hasChildren
		ifFalse: [ ^ NoPosition to: NoPosition ].

	minPositionPreLayout := Float infinity.
	maxPositionPreLayout := Float negativeInfinity.
	
	childrenManager childrenDo: [ :anElement | 
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore ifFalse: [ 
			| aPosition |
			aPosition := anElementHolder layoutPosition.
			minPositionPreLayout := minPositionPreLayout min: aPosition.
			maxPositionPreLayout := maxPositionPreLayout max: aPosition ] ].
	^ minPositionPreLayout to: maxPositionPreLayout
]

{ #category : #scrolling }
BlInfiniteElement >> fling: aVelocity [
	| aVelocityX aVelocityY canScrollHorizontal canScrollVertical |
	
	layoutFrozen
		ifTrue: [ ^ false ].
	
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

{ #category : #'private - animations' }
BlInfiniteElement >> handleMissingPreInfoForChange: anActualElementHolder oldChangeHolder: anOldChangeElementHolder at: anActualKey [

	childrenManager childrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder == anActualElementHolder ifFalse: [ 
			| aKey |
			aKey := self changedHolderKeyOf: anElementHolder.
			aKey = anActualKey ifTrue: [
				dataSource hasStableIds
					ifTrue: [ self error: 'Two different ElementHolders have the same stable ID. Stable IDs in your data source MUST BE unique and SHOULD NOT change.' ]
					ifFalse: [ self error: 'Two different ElementHolders have the same change ID. This might happen due to inconsistent DataSource update events or if the InfinieElement lays out the same Element multiple times.' ] ] ] ]
]

{ #category : #'accessing - properties' }
BlInfiniteElement >> hasFixedSize [
	"Return true if changes in datasource content cannot change the size of the InfiniteElement itself"
	<return: #Boolean>

	^ hasFixedSize
]

{ #category : #'accessing - properties' }
BlInfiniteElement >> hasFixedSize: aBoolean [
	"InfiniteElement can perform several optimizations if it can know in advance that InfiniteElement's
	size is not affected by the datasource contents. InfiniteElement can still change its size based
	on other factors (e.g. its parent's size) but this size calculation cannot depend on the
	size of its children or contents of its datasource (except the number of items in the datasource).
	If your use of InfiniteElement falls into this category, set this to true. It will allow
	InfiniteElement to avoid invalidating the whole layout when its datasource contents change"

	hasFixedSize := aBoolean
]

{ #category : #'item decorations - testing' }
BlInfiniteElement >> hasItemDecorations [
	^ itemDecorations isNotEmpty
]

{ #category : #'private - testing' }
BlInfiniteElement >> hasUpdatedChild [
	"Return true if any of existing elemnts holder needs to be updated"
	<return: #Boolean>

	childrenManager childrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder shouldIgnore not and:[
			anElementHolder isUpdated ])
				ifTrue: [ ^ true ] ].
	^ false 
]

{ #category : #accessing }
BlInfiniteElement >> infoStore [
	^ infoStore
]

{ #category : #initialization }
BlInfiniteElement >> initialize [
	super initialize.
	
	hasFixedSize := false.
	firstLayoutComplete := false.
	layoutOrScrollCounter := 0.
	dispatchScrollCounter := 0.
	eatRequestLayoutCounter := 0.
	layoutFrozen := false.
	layoutRequestEaten := false.
	dataSourceChangedAfterLayout := false.
	dataSourceChangeDuringMeasure := false.
	itemsAddedOrRemoved := false.
	itemsChanged := false.
	preserveFocusAfterLayout := true.
	
	itemDecorations := OrderedCollection new.
	itemAnimator := self defaultItemAnimator.
	infoStore := self defaultInfoStore.
	infoStoreProcessor := self defaultInfoStoreProcessor on: self.
	state := self defaultState.
	childrenUpdateRunnable := self defaultChildrenUpdateRunnable on: self.
	overScrollMode := self defaultOverScrollMode.
	scrollFlinger := self defaultScrollFlinger on: self.
	self initializeChildrenManager.
	self initializeDataSource.
	self initializeRecycler.
	
	"Should be initialized last"
	layout infiniteElement: self.
	
	self initializeEventHandlers
]

{ #category : #initialization }
BlInfiniteElement >> initializeChildrenManager [
	childrenManager := self defaultChildrenManager.
	self defaultChildrenController
		infiniteElement: self;
		childrenManager: childrenManager
]

{ #category : #initialization }
BlInfiniteElement >> initializeDataSource [
	dataSource := self defaultDataSource.
	dataSourceObserver := self defaultDataSourceObserver on: self.
	dataSource addEventHandler: dataSourceObserver.
	
	dataSourceManager := self defaultDataSourceManager.
	self defaultDataSourceController
		element: self;
		dataSourceManager: dataSourceManager
]

{ #category : #initialization }
BlInfiniteElement >> initializeEventHandlers [

	self addEventHandler: self defaultMouseScrollEventHandler
]

{ #category : #initialization }
BlInfiniteElement >> initializeRecycler [
	recycler := self defaultRecycler.
	self defaultRecyclerController
		infiniteElement: self
]

{ #category : #'private - invalidation' }
BlInfiniteElement >> invalidateItemDecorations [
	"Invalidate all ItemDecorations.
	If I have item decorations, a layout update will be requested"

	self hasItemDecorations
		ifFalse: [ ^ self ].

	self assertNotInLayoutOrScroll.
	self markItemDecorInsetsDirty.
	self requestLayout
]

{ #category : #testing }
BlInfiniteElement >> isAnimating [
	"Return true if InfiniteElement is currently running some animations, false otherwise"
	<return: #Boolean>

	^ itemAnimator supportsAnimations
		and: [ itemAnimator isRunning ]
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

{ #category : #testing }
BlInfiniteElement >> isLayoutFrozen [
	"Returns true if layout and scroll are frozen, false otherwise"
	<return: #Boolean>

	^ layoutFrozen
]

{ #category : #accessing }
BlInfiniteElement >> itemAnimator [
	<return: #BlInfiniteItemAnimator>
	^ itemAnimator
]

{ #category : #'item decorations - accessing' }
BlInfiniteElement >> itemDecoration [
	^ itemDecorations
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

	aBoolean = layoutFrozen
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
			self stopScroll ]
]

{ #category : #layout }
BlInfiniteElement >> markDataSourceChangeDuringMeasure [
	dataSourceChangeDuringMeasure := true
]

{ #category : #'private - invalidation' }
BlInfiniteElement >> markItemDecorInsetsDirty [
	
	childrenManager unfilteredChildrenDo: [ :anElement |
		anElement constraints infinite insetsDirty: true ].

	self recycler markItemDecorInsetsDirty
]

{ #category : #layout }
BlInfiniteElement >> markItemsAddedOrRemoved [
	itemsAddedOrRemoved := true
]

{ #category : #layout }
BlInfiniteElement >> markItemsChanged [
	itemsChanged := true
]

{ #category : #'private - invalidation' }
BlInfiniteElement >> markKnownElementsInvalid [
	"Mark all known elements as invalid. Used in response to a, the whole world might have changed data change event"

	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore ifFalse: [ 
			anElementHolder flags addUpdate.
			anElementHolder flags addInvalid ] ].
	
	self markItemDecorInsetsDirty.
	recycler markKnownElementsInvalid
]

{ #category : #layout }
BlInfiniteElement >> markLayoutRequestEaten [
	layoutRequestEaten := true
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

	self fireEvent: (BlInfiniteElementAttachedEvent element: anElement)
]

{ #category : #notifying }
BlInfiniteElement >> notifyChildDetached: anElement [
	"Notify all event handlers that element is detached from InfiniteElement"

	self fireEvent: (BlInfiniteElementDetachedEvent element: anElement)
]

{ #category : #notifying }
BlInfiniteElement >> notifyScrollStateChanged: aScrollState [
	"Notify all event handlers that scroll state of InfiniteElement has been changed"

	self fireEvent: (BlInfiniteScrollChangedEvent scrollState: aScrollState)
]

{ #category : #'api - scrolling notifying' }
BlInfiniteElement >> notifyScrolled: aPoint [
	"Notify all event handlers that InfiniteElemnet scrolled by a delta point"

	self eventDispatcher dispatchScrolled: aPoint
]

{ #category : #'children - geometry' }
BlInfiniteElement >> offsetChildrenHorizontallyBy: aNumber [
	
	childrenManager childrenDo: [ :anElement |
		| previousPosition newPosition |
		previousPosition := anElement position.
		newPosition := (previousPosition x + aNumber) @ previousPosition y.
		
		self flag: 'Implement BlElement>>#moveTo:'.
		anElement measuredBounds position: newPosition.
		anElement position: newPosition extent: anElement extent.
		anElement commitChanges.
		
		self
			assert: [ newPosition closeTo: anElement position ]
			description: [ 'Position didn''t change as expected! It is super important for scrolling, since we assume that I DO offset children by a number regardless of anything' ] ]
]

{ #category : #'children - geometry' }
BlInfiniteElement >> offsetChildrenVerticallyBy: aNumber [
	
	childrenManager childrenDo: [ :anElement |
		| previousPosition newPosition |
		previousPosition := anElement position.
		newPosition := previousPosition x @ (previousPosition y + aNumber).

		self flag: 'Implement BlElement>>#moveTo:'.
		anElement measuredBounds position: newPosition.
		anElement position: newPosition extent: anElement extent.
		anElement commitChanges.

		self
			assert: [ newPosition closeTo: anElement position ]
			description: [ 'Position didn''t change as expected! It is super important for scrolling, since we assume that I DO offset children by a number regardless of anything' ] ]
]

{ #category : #'private - commands' }
BlInfiniteElement >> offsetPositionRecordsForInsert: aStartPosition itemCount: anItemCount [

	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder shouldIgnore not and: [ anElementHolder position >= aStartPosition ])
			ifTrue: [ 
				anElementHolder offsetPositionBy: anItemCount applyToPreLayout: false.
				state structureChanged: true ] ].
	
	recycler offsetPositionRecordsForInsert: aStartPosition itemCount: anItemCount.
	self requestLayout
]

{ #category : #'private - commands' }
BlInfiniteElement >> offsetPositionRecordsForMove: aFromPosition to: aToPosition [
	| aStart anEnd anInBetweenOffset|
	
	aFromPosition < aToPosition
		ifTrue: [
			aStart := aFromPosition.
			anEnd := aToPosition.
			anInBetweenOffset := -1 ]
		ifFalse: [ 
			aStart := aToPosition.
			anEnd := aFromPosition.
			anInBetweenOffset := 1 ].
	
	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder position between: aStart and: anEnd)
			ifTrue: [ 
				anElementHolder position = aFromPosition
					ifTrue: [ anElementHolder offsetPositionBy: aToPosition - aFromPosition applyToPreLayout: false ]
					ifFalse: [ anElementHolder offsetPositionBy: anInBetweenOffset applyToPreLayout: false ].
				state structureChanged: true ] ].
	
	recycler offsetPositionRecordsForMove: aFromPosition to: aToPosition.
	self requestLayout
]

{ #category : #'private - commands' }
BlInfiniteElement >> offsetPositionRecordsForRemove: aPositionStart itemCount: anItemCount applyToPreLayout: applyToPreLayout [
	| aPositionEnd |

	aPositionEnd := aPositionStart + anItemCount.
	
	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore
			ifFalse: [ 
				anElementHolder position >= aPositionEnd
					ifTrue: [	anElementHolder
							offsetPositionBy: anItemCount negated
							applyToPreLayout: applyToPreLayout ]
					ifFalse: [ anElementHolder
						flagRemovedAndOffsetPosition: aPositionStart - 1
						by: anItemCount negated
						applyToPreLayout: applyToPreLayout ].
				state structureChanged: true ] ].

	recycler
		offsetPositionRecordsForRemove: aPositionStart
		itemCount: anItemCount
		applyToPreLayout: applyToPreLayout.
	
	self requestLayout
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

{ #category : #'hooks - state' }
BlInfiniteElement >> onEnteredHiddenState: aChildElement [
]

{ #category : #'hooks - layout' }
BlInfiniteElement >> onExitLayoutOrScroll [
	
	layoutOrScrollCounter := layoutOrScrollCounter - 1.

	layoutOrScrollCounter < 0
		ifTrue: [
			self error: 'layout or scroll counter cannot go below zero'.
			"it is important anyway to set counter to 0"
			layoutOrScrollCounter := 0 ]
]

{ #category : #layout }
BlInfiniteElement >> onLayout: aBounds [
	self dispatchLayout.
	firstLayoutComplete := true.
	
	self layout layoutIgnored: self
]

{ #category : #'hooks - state' }
BlInfiniteElement >> onLeftHiddenState: aChildElement [
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
	skipMeasure
		ifTrue: [ ^ self ].

	self state isStartStep
		ifTrue: [ self dispatchLayoutFirstStep ].
	
	"set dimensions in 2nd step. Pre-layout should happen with old dimensions for consistency"
	layout measurementSpec: anExtentMeasurementSpec.
	self state isMeasuring: true.
	self dispatchLayoutSecondStep.
	
	"now we can get the width and height from the children"
	layout measureBasedOnChildren: anExtentMeasurementSpec.
	
	"if InfiniteElement has non-exact width and height and if there is at least one child
	which also has non-exact width & height, we have to re-measure."
	layout shouldMeasureTwice
		ifTrue: [ 
			layout measurementSpec: (BlExtentMeasurementSpec exact: self measuredExtent).
			self state isMeasuring: true.
			self dispatchLayoutSecondStep.
			"now we can get the width and height from the children."
			layout measureBasedOnChildren: anExtentMeasurementSpec ]
]

{ #category : #measurement }
BlInfiniteElement >> onMeasureCustom: anExtentMeasurementSpec [
		
	hasFixedSize
		ifTrue: [ ^ layout measure: self with: anExtentMeasurementSpec ].
	
	"custom onMeasure"
	
	dataSourceChangeDuringMeasure ifTrue: [ 
		self eatRequestLayout.
		self processDataSourceCommandsAndSetAnimationFlags.
		
		self state willRunPredictiveAnimations
			ifTrue: [ self state isPreLayout: true ]
			ifFalse: [ 
				dataSourceManager consumeCommandsInOnePass.
				self state isPreLayout: false ].
		dataSourceChangeDuringMeasure := false.
		self resumeRequestLayout: false ].
	
	self state itemCount: dataSource itemCount.
	self eatRequestLayout.
	
	layout measure: self with: anExtentMeasurementSpec.
	self resumeRequestLayout: false.
	self state isPreLayout: false
]

{ #category : #'hooks - scrolling' }
BlInfiniteElement >> onScrollStateChanged: aScrollingState [
	"Called when the scroll state of InfiniteElement changes.
	Subclasses should use this method to respond to state changes instead of an explicit listener.
	This method will always be invoked before firing events, but after the Layout responds to the scroll state change"
]

{ #category : #'api - scrolling accessing' }
BlInfiniteElement >> overScrollMode [
	^ overScrollMode
]

{ #category : #'api - scrolling accessing' }
BlInfiniteElement >> overScrollMode: aBlOverScrollMode [
	overScrollMode := aBlOverScrollMode
]

{ #category : #'deferred actions' }
BlInfiniteElement >> postAnimationRunner [
	"It is up to animation runner to decide if it needs to be poster or not"
	itemAnimationRunner postOn: self
]

{ #category : #'deferred actions' }
BlInfiniteElement >> postChildrenUpdater [
	"Post children update runnable to consume update operations"
	self postOnAnimation: childrenUpdateRunnable
]

{ #category : #'deferred actions' }
BlInfiniteElement >> postOnAnimation: aRunnableAction [
	self enqueueTask: aRunnableAction
]

{ #category : #'deferred actions' }
BlInfiniteElement >> postSmoothScroller [
	scrollFlinger postOnAnimation
]

{ #category : #'private - testing' }
BlInfiniteElement >> predictiveItemAnimationsEnabled [
	<return: #Boolean>
	^ itemAnimator supportsAnimations
		and: [ layout supportsPredictiveItemAnimations ]
]

{ #category : #'accessing - properties' }
BlInfiniteElement >> prefetchingAllowed [
	^ false
]

{ #category : #'private - commands' }
BlInfiniteElement >> processDataSourceCommandsAndSetAnimationFlags [
	"Consumes data source commands and calculates which type of animations we want to run.
	Is sent in onMeasure and dispatchLayout.
	This method may process only the pre-layout state of updates or all of them."
	| animationTypeSupported |
	
	dataSourceChangedAfterLayout ifTrue: [
		dataSourceManager resetCommands.
		self markKnownElementsInvalid.
		layout onItemsChanged ].
	
	"Simple animations are a subset of advanced animations (which will cause a pre-layout step)
	If layout supports predictive animations, pre-process to decide if we want to run them"
	self predictiveItemAnimationsEnabled
		ifTrue: [ dataSourceManager preProcessCommands ]
		ifFalse: [ dataSourceManager consumeCommandsInOnePass ].

	animationTypeSupported := itemsAddedOrRemoved or: [ itemsChanged ].
	self state runSimpleAnimations: (firstLayoutComplete and: [
		itemAnimator supportsAnimations and: [ 
			(dataSourceChangedAfterLayout or: [ animationTypeSupported or: [ layout requestedSimpleAnimations ] ])
				and: [ dataSourceChangedAfterLayout not or: [ dataSource hasStableIds ] ] ] ]).
	
	self state runPredictiveAnimations: (self state willRunSimpleAnimations and: [
		animationTypeSupported and: [ dataSourceChangedAfterLayout not and: [ self predictiveItemAnimationsEnabled ] ] ])
]

{ #category : #'private - scrolling' }
BlInfiniteElement >> pullGlows: anEventPoint overscroll: anOverScrollPoint [
]

{ #category : #'private - animations' }
BlInfiniteElement >> recordAnimationInfoIfBouncedHidden: anElementHolder itemHolder: anItemHolder [
	"Record the animation information for an element holder that was bounced from hidden list.
	It also clears the bounce back flag."

	"looks like this view bounced back from hidden list!"
	anElementHolder flags clearBouncedFromHiddenList.
	
	(self state trackOldChangeHolders and: [
		anElementHolder isUpdated and: [ 
			anElementHolder isRemoved not and: [
				anElementHolder shouldIgnore not ] ] ])
		ifTrue: [ 
			| aKey |
			aKey := self changedHolderKeyOf: anElementHolder.
			infoStore addToOldChangeHolders: anElementHolder at: aKey ].
	
	infoStore addToPreLayout: anElementHolder itemHolder: anItemHolder
]

{ #category : #'private - focus' }
BlInfiniteElement >> recoverFocusFromState [
	| aFocusTarget |

	(preserveFocusAfterLayout and: [ self hasFocus ])
		ifFalse: [ ^ self ].

	"only recover focus if InfiniteElement itself has the focus or the focused element is hidden"
	self isFocused
		ifFalse: [ 
			| aFocusedChild |
			aFocusedChild := self focusedChild.
			(aFocusedChild isNotNil and: [ childrenManager isHidden: aFocusedChild ])
				ifFalse: [ ^ self ] ].
	
	aFocusTarget := nil.
	
	(self state focusedItemPosition ~= NoPosition)
		ifTrue: [ aFocusTarget := self findElementHolderForDataSourcePosition: self state focusedItemPosition ].
	
	(aFocusTarget isNil and: [
		self state focusedItemId ~= NoId and: [
			dataSource hasStableIds ] ])
				ifTrue: [ aFocusTarget := self findElementHolderForItemId: self state focusedItemId ].
				
	(aFocusTarget isNil or: [
		aFocusTarget itemElement hasFocus or: [
			aFocusTarget itemElement hasFocusable not ] ])
				ifTrue: [ ^ self ].
	
	"could not find element to give focus to"
]

{ #category : #accessing }
BlInfiniteElement >> recycler [
	^ recycler
]

{ #category : #'children - add/remove' }
BlInfiniteElement >> removeAnimatingChild: anElement [
	"Removes an element from the animatingElements list.
	Return true if an animating element is removed, false otherwise"
	<return: #Boolean>
	| isRemoved |
	
	self eatRequestLayout.
	isRemoved := childrenManager removeChildIfHidden: anElement.
	isRemoved
		ifTrue: [ 
			| anElementHolder |
			anElementHolder := self elementHolderOf: anElement.
			recycler unscrapHolder: anElementHolder.
			recycler recycleElementHolder: anElementHolder ].
	
	"only clear request eaten flag if we removed the element"
	self resumeRequestLayout: isRemoved not.
	^ isRemoved
]

{ #category : #'children - add/remove' }
BlInfiniteElement >> removeDetachedChild: anElement animate: shouldAnimate [
	| anElementHolder |
	
	anElementHolder := self elementHolderOf: anElement.
	
	anElementHolder isTmpDetached
		ifTrue: [ anElementHolder clearTmpDetached ]
		ifFalse: [ anElementHolder shouldIgnore
			ifFalse: [ self error: 'Trying to removeDetachedChild: which is not flagged as temporary detached!' ] ].
	
	self dispatchChildDetached: anElement.
	self removeDetachedChild: anElement
]

{ #category : #'children - add/remove' }
BlInfiniteElement >> repositionShadowingElements [
	"self shouldBeImplemented"
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

	self state focusedItemId: NoId.
	self state focusedItemPosition: NoPosition.
	self state focusedSubChild: nil
]

{ #category : #layout }
BlInfiniteElement >> resumeRequestLayout: shouldPerformLayout [
	
	eatRequestLayoutCounter < 1
		ifTrue: [ self error: 'Invalid eat request layout count' ].

	shouldPerformLayout
		ifFalse: [ layoutRequestEaten := false ].
	
	eatRequestLayoutCounter = 1 ifTrue: [ 
		(shouldPerformLayout and: [
			layoutRequestEaten and: [ 
				layoutFrozen not ] ])
			ifTrue: [ self dispatchLayout ].
		layoutFrozen
			ifFalse: [ layoutRequestEaten := false ] ].
		
	eatRequestLayoutCounter := eatRequestLayoutCounter - 1
]

{ #category : #'private - focus' }
BlInfiniteElement >> saveFocusInfo [
	"I save information of currently focused element in the state.
	In order to restore foces later we need to save item's position
	in data source, its stable it if any and store reference
	to the focused sub child of item's element to give it focus directly"
	| aFocusedElement aFocusedElementHolder |
	
	aFocusedElement := nil.
	
	(preserveFocusAfterLayout and: [ self hasFocus ])
		ifTrue: [ aFocusedElement := self focusedChild ].
	
	aFocusedElementHolder := aFocusedElement
		ifNotNil: [ :anElement | self childHolderContainingItemElement: anElement ].
		
	aFocusedElementHolder
		ifNil: [ self resetFocusInfo ]
		ifNotNil: [ 
			self state focusedItemId: (dataSource hasStableIds
				ifTrue: [ aFocusedElementHolder itemId ]
				ifFalse: [ NoId ]).
			self state focusedItemPosition: (dataSourceChangedAfterLayout
				ifTrue: [ NoPosition ]
				ifFalse: [ aFocusedElementHolder dataSourcePosition ]).
			self state focusedSubChild: (self deepestFocusedChildIn: aFocusedElementHolder itemElement) ]
]

{ #category : #'private - positions' }
BlInfiniteElement >> saveOldPositions [

	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		(anElementHolder position = NoPosition and: [ anElementHolder isRemoved not ])
			ifTrue: [ self error: 'Element holder can not have undefined position unless it is removed' ].
		anElementHolder shouldIgnore
			ifFalse: [ anElementHolder saveOldPosition ] ]
]

{ #category : #scrolling }
BlInfiniteElement >> scrollBy: aPoint [ 
	| canScrollHorizontal canScrollVertical |

	layoutFrozen
		ifTrue: [ ^ self ].
		
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
	self eatRequestLayout.
	self onEnterLayoutOrScroll.
	
	aDeltaPoint x isZero
		ifFalse: [ 
			consumedX := self layout scrollHorizontallyBy: aDeltaPoint x.
			unconsumedX := aDeltaPoint x - consumedX ].
	aDeltaPoint y isZero
		ifFalse: [ 
			consumedY := self layout scrollVerticallyBy: aDeltaPoint y.
			unconsumedY := aDeltaPoint y - consumedY ].
	
	self repositionShadowingElements.
	self onExitLayoutOrScroll.
	self resumeRequestLayout: false.
	
	self hasItemDecorations
		ifTrue: [ self invalidate ].
	
	self overScrollMode ~= BlOverScrollMode never
		ifTrue: [ 
			anEventPoint ifNotNil: [ 
				self pullGlows: anEventPoint overscroll: unconsumedX @ unconsumedY ].
			self considerReleasingGlowsOnScroll: aDeltaPoint ].
	
	(consumedX isZero and: [ consumedY isZero ])
		ifFalse: [ self dispatchOnScrolled: consumedX @ consumedY ].
		
	self awakenScrollBars
		ifFalse: [ self invalidate ].
	
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

	layoutFrozen
		ifTrue: [ ^ self ].

	self stopScroll.
	self layout scrollToPosition: aPosition.
	self awakenScrollBars
]

{ #category : #'api - scrolling' }
BlInfiniteElement >> scrollVerticallyBy: aNumber [
	"Scroll vertically by aNumber and return the distance traveled.
	The default implementation does nothing and returns 0."
	<return: #Number>

	^ self layout scrollVerticallyBy: aNumber
]

{ #category : #'private - invalidation' }
BlInfiniteElement >> setDataSourceChangedAfterLayout [
	
	"We already set that data source is changed"
	dataSourceChangedAfterLayout
		ifTrue: [ ^ self ].
		
	dataSourceChangedAfterLayout := true.
	childrenManager unfilteredChildrenDo: [ :anElement |
		| anElementHolder |
		anElementHolder := self elementHolderOf: anElement.
		anElementHolder shouldIgnore
			ifFalse: [ anElementHolder flags addDataSourcePositionUnknown ] ].
	
	recycler setDataSourcePositionsAsUnknown.
	"immediately mark all elements as invalid, so prefetched ones can be
	differentiated from elements bound to previous data set - both in children, and cache"
	self markKnownElementsInvalid
]

{ #category : #scrolling }
BlInfiniteElement >> smoothScrollBy: aPoint [
	"Animate a scroll by the given amount of pixels along either axis"
	| dX dY |
	
	layoutFrozen
		ifTrue: [ ^ self ].
	
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
	
	layoutFrozen
		ifTrue: [ ^ self ].
	
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

{ #category : #accessing }
BlInfiniteElement >> userCache: aUserCache [
	recycler userCache: aUserCache
]
