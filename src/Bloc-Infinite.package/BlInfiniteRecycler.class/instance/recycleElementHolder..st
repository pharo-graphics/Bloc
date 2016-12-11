recycling
recycleElementHolder: anElementHolder
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