"
I am an element recycler.

I keep track of items outside of current viewport. I use object pool in order to reuse already created objects.
I am used by infinite element.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	attachedScrap:		<Object>
	cachedScrap:		<Object>
	changedScrap:		<Object>
	context:		<Object>
	customCache:		<Object>
	fetcher:		<Object>
	recyclerPool:		<Object>


    Implementation Points
"
Class {
	#name : #BlInfiniteRecycler,
	#superclass : #Object,
	#traits : 'TBlEventTarget + TBlDebug',
	#classTraits : 'TBlEventTarget classTrait + TBlDebug classTrait',
	#instVars : [
		'recyclerPool',
		'controller',
		'changedScrap',
		'attachedScrap',
		'cachedScrap',
		'fetcher',
		'cacheSize',
		'requestedCacheSize',
		'userCache',
		'eventDispatcher'
	],
	#category : #'Bloc-Infinite-! Core'
}

{ #category : #private }
BlInfiniteRecycler >> addHolderToRecyclerPool: anElementHolder [

	self dispatchElementRecycled: anElementHolder.
	anElementHolder detachInfiniteElement.
	self pool put: anElementHolder
]

{ #category : #'accessing - cache' }
BlInfiniteRecycler >> attachedScrap [
	"Return a collection of attached scrapped elements"
	<return: #SequenceableCollection>
	
	^ attachedScrap
]

{ #category : #'accessing - properties' }
BlInfiniteRecycler >> cacheSize [
	"Return the maximum number of detached, valid elements we should retain for later use"
	<return: #Number>

	^ cacheSize
]

{ #category : #'accessing - properties' }
BlInfiniteRecycler >> cacheSize: aRequestedCacheSize [
	"Request change of the maximum number of detached, valid elements we should retain for later use.
	It is not guaranteed that new cache size will be equal to requested one!"

	requestedCacheSize = aRequestedCacheSize.
	self updateCacheSize
]

{ #category : #'accessing - cache' }
BlInfiniteRecycler >> cachedScrap [
	"Return a collection of cached scrapped elements"
	<return: #SequenceableCollection>

	^ cachedScrap
]

{ #category : #'accessing - cache' }
BlInfiniteRecycler >> changedScrap [
	"Return a collection of changed scrapped elements"
	<return: #SequenceableCollection>
	
	^ changedScrap
]

{ #category : #initialization }
BlInfiniteRecycler >> clear [
	self removeScrap
]

{ #category : #recycling }
BlInfiniteRecycler >> clearOldPositions [

	self cachedScrap do: [ :anElementHolder |
		anElementHolder clearOldPosition ].

	self attachedScrap do: [ :anElementHolder |
		anElementHolder clearOldPosition ].
	
	self changedScrap do: [ :anElementHolder |
		anElementHolder clearOldPosition ]
]

{ #category : #'accessing - cache' }
BlInfiniteRecycler >> clearScrap [
	"Removes all scrapped elements from corresponding pools"
	
	attachedScrap removeAll.
	changedScrap removeAll
]

{ #category : #accessing }
BlInfiniteRecycler >> controller [
	^ controller
]

{ #category : #accessing }
BlInfiniteRecycler >> controller: aBlInfiniteRecyclerController [
	controller := aBlInfiniteRecyclerController
]

{ #category : #hooks }
BlInfiniteRecycler >> dataSourceChangedFrom: anOldDataSource to: aNewDataSource isCompatible: aBoolean [
	
	self clear.
	self pool dataSourceChangedFrom: anOldDataSource to: aNewDataSource isCompatible: aBoolean
]

{ #category : #initialization }
BlInfiniteRecycler >> defaultCacheSize [
	^ 2
]

{ #category : #initialization }
BlInfiniteRecycler >> defaultEventDispatcher [
	"Return class of event dispatcher.
	Instantiation happens in initialize"
	^ BlDirectEventDispatcher
]

{ #category : #initialization }
BlInfiniteRecycler >> defaultFetcher [
	^ BlInfiniteRecyclerChangedScrapFetcher instance
]

{ #category : #initialization }
BlInfiniteRecycler >> defaultRecyclerPool [
	^ BlInfiniteRecyclerPool new
]

{ #category : #'event dispatching' }
BlInfiniteRecycler >> dispatchElementRecycled: anElementHolder [

	self notifyElementRecycled: anElementHolder.
	self controller onElementHolderRecycled: anElementHolder
]

{ #category : #'accessing - element' }
BlInfiniteRecycler >> elementFor: aPosition [
	"Returns an element representing the data at a position from data source.
	I should be used by InfiniteLayout implementations to obtain elements to represent data from a DataSource.

	Recycler may reuse a scrap or detached element from a shared pool if one is
	available for the correct element type. If the data source has not indicated that the
	data at the given position has changed, the Recycler will attempt to hand back
	a scrap element that was previously initialized for that data without rebinding."
	<return: #BlElement>

	^ self elementFor: aPosition dryRun: false
]

{ #category : #private }
BlInfiniteRecycler >> elementFor: aPosition dryRun: dryRun [
	"I do a hard work obtaining element for the data at a position in data source.
	@see elementFor: for more information"
	<return: #BlElement>

	| holder fromScrap fetchedResult bound itemElement anInfiniteConstraints |
	
	(aPosition < 1 and: [ aPosition > self controller dataSourceItemCount ])
		ifTrue: [ Error signal: 'Position is out of bounds!' ].

	fetchedResult := fetcher elementFor: aPosition dryRun: dryRun controller: self controller.
	holder := fetchedResult key.
	fromScrap := fetchedResult value.

	self assert: holder isNotNil.
	self assert: fromScrap isNotNil.

	bound := false.
	(self controller isPreLayout and: [ holder isBound ])
		ifTrue: [ holder preLayoutPosition: aPosition ]
		ifFalse: [
			(holder isBound not or: [ holder needsUpdate or: [ holder isInvalid ] ]) ifTrue: [
				| offsetPosition |
				holder isRemoved ifTrue: [ Error signal: 'Removed holder should come here only in pre-layout!' ].
				offsetPosition := self controller computePositionOffset: aPosition.
				holder infiniteElement: self controller infiniteElement.
				self controller bindHolder: holder at: offsetPosition.
				bound := true.
				self controller isPreLayout
					ifTrue: [ holder preLayoutPosition: aPosition ] ] ].
	
	itemElement := holder itemElement.
	anInfiniteConstraints := itemElement constraints infinite.
	anInfiniteConstraints holder: holder.
	anInfiniteConstraints pendingInvalidate: (fromScrap and: [ bound ]).
	^ itemElement
]

{ #category : #invalidation }
BlInfiniteRecycler >> elementRangeUpdate: aPosition itemCount: anItemCount [
	| aPositionEnd |
	
	aPositionEnd := aPosition + anItemCount.
	self cachedScrap reverseWithIndexDo: [ :anElementHolder :anIndex |
		| aLayoutPosition |
		aLayoutPosition := anElementHolder layoutPosition.
		(aLayoutPosition >= aPosition and: [ aLayoutPosition < aPositionEnd ])
			ifTrue: [ 
				anElementHolder flags addUpdate.
				self recycleCachedAt: anIndex.
				"cached elements should not be flagged as changed because this will cause them
				to animate when they are returned from cache." ] ]
]

{ #category : #'event management accessing' }
BlInfiniteRecycler >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #initialization }
BlInfiniteRecycler >> initialize [
	super initialize.
	
	changedScrap := OrderedCollection new.
	attachedScrap := OrderedCollection new.
	cachedScrap := OrderedCollection new.
	fetcher := self defaultFetcher.
	
	cacheSize := self defaultCacheSize.
	requestedCacheSize := self defaultCacheSize.
	recyclerPool := self defaultRecyclerPool.

	eventDispatcher := self defaultEventDispatcher on: self
]

{ #category : #invalidation }
BlInfiniteRecycler >> markItemDecorInsetsDirty [

	self cachedScrap do: [ :anElementHolder |
		anElementHolder itemElement constraints infinite insetsDirty: true ]
]

{ #category : #invalidation }
BlInfiniteRecycler >> markKnownElementsInvalid [

	self controller hasStableIds
		ifTrue: [ 
			self cachedScrap do: [ :anElementHolder |
				anElementHolder flags addUpdate; addInvalid.
				anElementHolder addEmptyPayload ] ]
		"we cannot re-use cached elements in this case. Recycle them all"
		ifFalse: [ self recycleAndRemoveCachedElements ]
]

{ #category : #'event firing' }
BlInfiniteRecycler >> notifyElementRecycled: anElementHolder [
	"BlInfiniteElementRecycledEvent is sent whenever the view in the ViewHolder is recycled.
   Recycler sends me right before clearing ElementHolder's internal data and sending it to RecyclerPool.
	This way, if ElementHolder was holding valid information before being recycled,
	you can use ===#dataSourcePosition=== to get its datasource position"

	self fireEvent: (BlInfiniteElementRecycledEvent holder: anElementHolder)
]

{ #category : #'accessing - position' }
BlInfiniteRecycler >> offsetPositionRecordsForInsert: aStartPosition itemCount: anItemCount [

	cachedScrap
		select: [ :aHolder | aHolder position >= aStartPosition ]
		thenDo: [ :aHolder | aHolder offsetPositionBy: anItemCount applyToPreLayout: true ]
]

{ #category : #'accessing - position' }
BlInfiniteRecycler >> offsetPositionRecordsForMove: aStartPosition to: anEndPosition [
	| start end inBetweenOffset |

	aStartPosition < anEndPosition
		ifTrue: [ 
			start := aStartPosition.
			end := anEndPosition.
			inBetweenOffset := -1 ]
		ifFalse: [ 
			start := anEndPosition.
			end := aStartPosition.
			inBetweenOffset := 1 ].
	
	cachedScrap
		select: [ :aHolder | (aHolder position < start or: [ aHolder position > end ]) ]
		thenDo: [ :aHolder |
			aHolder position = aStartPosition
				ifTrue: [ aHolder offsetPositionBy: anEndPosition - aStartPosition applyToPreLayout: false ]
				ifFalse: [ aHolder offsetPositionBy: inBetweenOffset applyToPreLayout: false ] ]
]

{ #category : #'accessing - position' }
BlInfiniteRecycler >> offsetPositionRecordsForRemove: aStartPosition itemCount: anItemCount applyToPreLayout: shouldApplyToPreLayout [
	| removedEnd |
	
	removedEnd := aStartPosition + anItemCount.
	cachedScrap reverseWithIndexDo: [ :anElementHolder :anIndex |
		anElementHolder position >= removedEnd
			ifTrue: [ anElementHolder
				offsetPositionBy: anItemCount negated
				applyToPreLayout: shouldApplyToPreLayout ]
			ifFalse: [ (anElementHolder position >= aStartPosition)
					ifTrue: [
						"Item for this element was removed. Dump it from the cache."
						anElementHolder flags addRemoved.
						self recycleCachedAt: anIndex ] ] ]
]

{ #category : #accessing }
BlInfiniteRecycler >> pool [
	"Return an object pool used to recycle element holders.
	recyclerPool can not be nil"
	<return: #BlInfiniteRecyclerPool>

	^ recyclerPool
]

{ #category : #accessing }
BlInfiniteRecycler >> pool: aBlInfiniteRecyclerPool [
	recyclerPool detach.
	recyclerPool := aBlInfiniteRecyclerPool.
	recyclerPool attach
]

{ #category : #'accessing - position' }
BlInfiniteRecycler >> preLayoutPositionToPostLayout: aPosition [
	"Infinite element provides artificial position range (item count) in pre-layout state and 
	automatically maps these positions to DataSource positions when #elementFor: is sent.

	Usually, Layout does not need to worry about this. However, in some cases, your
	Layout may need to call some custom component with item positions in which
	case you need the actual data source position instead of the pre layout position. You
	can use me to convert a pre-layout position to data source (post layout) position.

	Note that if the provided position belongs to a deleted ElementHolder, this method will return 0.
	Using me in post-layout state returns the same value back.

	aPosition must be greater or equal to 1 and less than BlInfiniteElementState>>#itemCount"
	
	(aPosition < 1 or: [ aPosition > self controller stateItemCount ])
		ifTrue: [
			SubscriptOutOfBounds
				signalFor: aPosition
				lowerBound: 1
				upperBound: self controller stateItemCount ].
	
	^ self controller isPreLayout
		ifTrue: [ self controller computePositionOffset: aPosition ]
		ifFalse: [ aPosition ]
]

{ #category : #recycling }
BlInfiniteRecycler >> quickRecycleScrap: anElement [
	"Used as a fast path for unscrapping and recycling a an element during a bulk operation.
	The sender must send #clearScrap when it's done to update the recycler's internal bookkeeping.
	anElement must not be nil"
	| anElementHolder |
	self
		assert: [ anElement isNotNil ]
		description: [ 'Can not recycle nil element' ].

	anElementHolder := self controller elementHolderOf: anElement.
	anElementHolder detachRecycler.
	self recycleElementHolder: anElementHolder
]

{ #category : #recycling }
BlInfiniteRecycler >> recycleAndRemoveCachedElements [
	"Recycle and remove all cached elements"
	
	"iterate in reversed order since we delete cached elements from collection by index"
	cachedScrap reverseWithIndexDo: [ :anElementHolder :anIndex |
		self recycleCachedAt: anIndex ].
	
	"post-condition to make sure recycling worked well"
	self
		assert: [ cachedScrap isEmpty ]
		description: [ 'Cached scrap collection must be empty after recycling of all element!' ]
]

{ #category : #recycling }
BlInfiniteRecycler >> recycleCachedAt: anIndex [
	"Recycles a cached element and removes it from the list. Elements are added to cache
	if and only if they are recyclable, I do not check it again."
	| anElementHolder |
	
	anElementHolder := cachedScrap at: anIndex.

	self addHolderToRecyclerPool: anElementHolder.
	cachedScrap removeAt: anIndex
]

{ #category : #recycling }
BlInfiniteRecycler >> recycleElement: anElement [
	"Recycle a detached element.
	The specified element will be added to a pool of elements for later rebinding and reuse.
	An element must be fully detached (removed from parent) before it may be recycled.
	If the element is scrapped, it will be removed from scrap list

	Notice: I try to make element recycle-able since layout intended to recycle this element (e.g. even if it is in scrap or change cache)"
	| anElementHolder |
	
	anElementHolder := self controller elementHolderOf: anElement.
	anElementHolder isTmpDetached
		ifTrue: [ self controller removeDetachedChild: anElement ].
	
	anElementHolder isScrap
		ifTrue: [ anElementHolder unscrap ]
		ifFalse: [ anElementHolder wasReturnedFromScrap
			ifTrue: [ anElementHolder clearReturnedFromScrap ] ].
	
	self recycleElementHolder: anElementHolder
]

{ #category : #recycling }
BlInfiniteRecycler >> recycleElementHolder: anElementHolder [
	| cached recycled |

	(anElementHolder isScrap or: [ anElementHolder itemElement hasParent ])
		ifTrue: [ self error: 'Scrapped or attached elements can not be recycled' ].

	anElementHolder isTmpDetached
		ifTrue: [ self error: 'Detached element must be removed from infinite element before it can be recycled' ].	

	anElementHolder shouldIgnore
		ifTrue: [ self error: 'Can not recycle an ignored element holder' ].

	cached := false.
	recycled := false.

	(cachedScrap includes: anElementHolder)
		ifTrue: [ self error: 'Trying to recycle already cached element' ].

	anElementHolder isRecyclable ifTrue: [ 
		(cacheSize > 0 and: [ anElementHolder isInvalid not
			and: [ anElementHolder isRemoved not
				and: [ anElementHolder needsUpdate not ] ] ])
			ifTrue: [ 
				| cachedScrapSize targetCacheIndex |
				cachedScrapSize := cachedScrap size.
				"recycle the oldest cached scrapped element"
				(cachedScrapSize >= cacheSize and: [ cachedScrapSize > 0 ])
					ifTrue: [ 
						self recycleCachedAt: 1.
						cachedScrapSize := cachedScrapSize - 1 ].
				targetCacheIndex := cachedScrapSize.
				(self controller isItemPrefetchEnabled
					and: [ cachedScrapSize > 0
						and: [ (self controller lastPrefetchIncludedPosition: anElementHolder position) not ] ])
					ifTrue: [ 
						| cacheIndex break |
						cacheIndex := cachedScrapSize.
						break := false.
						[ break not and: [ cacheIndex >= 1 ] ] whileTrue: [ 
							| cachedPosition |
							cachedPosition := (cachedScrap at: cacheIndex) position.
							(self controller lastPrefetchIncludedPosition: cachedPosition)
								ifTrue: [ cacheIndex := cacheIndex - 1 ]
								ifFalse: [ break := true ] ].
						targetCacheIndex := cacheIndex + 1 ].
				cachedScrap add: anElementHolder afterIndex: targetCacheIndex.
				cached := true ].
			cached ifFalse: [ 
				self addHolderToRecyclerPool: anElementHolder.
				recycled := true ] ].
	
	self controller removeHolderFromInfoStore: anElementHolder
]

{ #category : #recycling }
BlInfiniteRecycler >> removeChangedScrap [

	changedScrap removeAll
]

{ #category : #recycling }
BlInfiniteRecycler >> removeScrap [
	"Remove all scrap elements out of this recycler.
	Detached elements contained within a recycler pool will remain"

	attachedScrap removeAll.
	self recycleAndRemoveCachedElements
]

{ #category : #'accessing - cache' }
BlInfiniteRecycler >> reverseScrapDo: aBlock [
	| aScrapCount |
	
	aScrapCount := self scrapCount.
	aScrapCount isZero
		ifTrue: [ ^ self ].

	aScrapCount to: 1 by: -1 do: [ :anIndex |
		| anElement |
		anElement := self scrappedElementAt: anIndex.
		anElement ifNotNil: [ aBlock cull: anElement cull: anIndex ] ]
]

{ #category : #'accessing - cache' }
BlInfiniteRecycler >> scrapCount [
	"Return amount of scrapped elements"
	<return: #Number>

	^ attachedScrap size
]

{ #category : #recycling }
BlInfiniteRecycler >> scrapElement: anElement [
	"Mark an attached element as scrap. Scrap element are still attached
	to their parent infinite element but are eligible for rebinding and reuse.
	Requests for an element at a given position may return a reused or rebound scrap element instance.
	anElement must not be nil"
	| anElementHolder |
	
	anElementHolder := self controller elementHolderOf: anElement.

	(anElementHolder isRemoved or: [
		anElementHolder isInvalid or: [ 
			anElementHolder isUpdated not or: [ 
				self controller canReuseUpdatedElementHolder: anElementHolder ] ] ])
		ifTrue: [ 
			(anElementHolder isInvalid and: [
				anElementHolder isRemoved not and: [ 
					self controller hasStableIds not ] ])
				ifTrue: [ self error: 'Can not scrap invalid elements, because they can not be reused from scrap and should be rebound from recycler pool instead' ].
			
			anElementHolder recycler: self inChangeScrap: false.
			attachedScrap add: anElementHolder ]
		ifFalse: [ 
			anElementHolder recycler: self inChangeScrap: true.
			changedScrap add: anElementHolder ]
]

{ #category : #'accessing - cache' }
BlInfiniteRecycler >> scrappedElementAt: anIndex [
	"Return scrapped element at anIndex"
	<return: #BlElement>

	^ (attachedScrap at: anIndex) itemElement
]

{ #category : #invalidation }
BlInfiniteRecycler >> setDataSourcePositionsAsUnknown [
	
	self cachedScrap do: [ :anElementHolder |
		anElementHolder flags addDataSourcePositionUnknown ]
]

{ #category : #recycling }
BlInfiniteRecycler >> unscrapHolder: anElementHolder [
	"Remove a previously scrapped element holder from the pool of eligible scrap.
	An element will no longer be eligible for reuse until re-scrapped or until
	it is explicitly removed and recycled"

	anElementHolder isInChangeScrap
		ifTrue: [ changedScrap remove: anElementHolder ]
		ifFalse: [ attachedScrap remove: anElementHolder ].
		
	anElementHolder detachRecycler
]

{ #category : #'accessing - properties' }
BlInfiniteRecycler >> updateCacheSize [
	"Update cache size based on requested cache size and various
	additional properties such as item prefetching.
	Return true if cached size value changed, false otherwise"
	<return: #Boolean>
	| extraCache index oldCachedSize |
	
	oldCachedSize := cacheSize.
	
	extraCache := self controller isItemPrefetchEnabled
		ifTrue: [ self controller itemPrefetchCount ]
		ifFalse: [ 0 ].

	cacheSize := requestedCacheSize + extraCache.

	index := cachedScrap size.
	
	[ index >= 1 and: [ cachedScrap size >= cacheSize ] ] whileTrue: [ 
		self recycleCachedAt: index.
		index := index - 1 ].
	
	^ oldCachedSize ~= cacheSize
]

{ #category : #'accessing - cache' }
BlInfiniteRecycler >> userCache [
	"Return custom cache defined by user. Custom cache should
	implement BlInfiniteAbstractCache api in order to be used with recycler"
	<return: #BlInfiniteAbstractCache>

	^ userCache
]

{ #category : #'accessing - cache' }
BlInfiniteRecycler >> userCache: aUserCache [
	"Set user cache to be used with this recycler.
	aUserCache must not be nil"
	self assert: aUserCache isNotNil.
	
	userCache := aUserCache
]

{ #category : #'private - testing' }
BlInfiniteRecycler >> validateElementHolderForOffsetPosition: anElementHolder [
	"Checks whether a given element holder can be used for the provided position.
	Position is taken from element holder itself.
	Return true if anElementHolder matches the provided position, false otherwise.
	anElementHolder must not be nil"
	<return: #Boolean>
	self assert: anElementHolder isNotNil.
	
	anElementHolder isRemoved ifTrue: [ 
		^ anElementHolder isPreLayout
			ifTrue: [ true ]
			ifFalse: [ 
				self error: 'Can not validate removed element holder unless it is in pre layout mode!'.
				^ false ] ].
	
	(anElementHolder position < 1
		or: [ anElementHolder position > self controller dataSourceItemCount ])
			ifTrue: [
				SubscriptOutOfBounds
					signalFor: anElementHolder position
					lowerBound: 1
					upperBound: self controller dataSourceItemCount ].
	
	"we don't need to check type if it is pre-layout"
	self controller isPreLayout ifFalse: [
		| type |
		type := self controller itemTypeAt: anElementHolder position.
		type ~= anElementHolder itemType
			ifFalse: [ ^ false ] ].
	
	self controller hasStableIds
		ifTrue: [ ^ anElementHolder itemId = self controller itemIdAt: anElementHolder position ].
	
	^ true
]
