"
I am responsible for communication between recycler and other parts of the system, for instance layout, state or infinite element
"
Class {
	#name : #BlInfiniteRecyclerController,
	#superclass : #Object,
	#instVars : [
		'infiniteElement'
	],
	#category : 'Bloc-Infinite-Recycler'
}

{ #category : #'scrap fetcher -> recycler' }
BlInfiniteRecyclerController >> attachedScrap [
	^ self recycler attachedScrap
]

{ #category : #'recycler -> data source' }
BlInfiniteRecyclerController >> bindHolder: aHolder at: aPosition [
	self dataSource bindHolder: aHolder at: aPosition
]

{ #category : #'scrap fetcher -> recycler' }
BlInfiniteRecyclerController >> cachedScrap [
	^ self recycler cachedScrap
]

{ #category : #'recycler -> animator' }
BlInfiniteRecyclerController >> canReuseUpdatedElementHolder: anElementHolder [
	"Return true if changed element holder can be reused"
	<return: #Boolean>
	
	^ infiniteElement itemAnimator supportsAnimations not or: [ 
			infiniteElement itemAnimator
				canReuseUpdatedElementHolder: anElementHolder
				payloads: anElementHolder payloads ]
]

{ #category : #'scrap fetcher -> recycler' }
BlInfiniteRecyclerController >> changedScrap [
	^ self recycler changedScrap
]

{ #category : #'recycler -> element' }
BlInfiniteRecyclerController >> childRemoved: anElement [
	self flag: 'todo'.
]

{ #category : #accessing }
BlInfiniteRecyclerController >> childrenManager [
	^ infiniteElement childrenManager
]

{ #category : #'recycler -> data source' }
BlInfiniteRecyclerController >> computePositionOffset: aPosition [
	^ self dataSourceManager computePositionOffset: aPosition
]

{ #category : #'recycler -> data source' }
BlInfiniteRecyclerController >> createElementHolderOfType: anItemType [
	<return: #BlInfiniteHolder>

	^ self dataSource createHolder: infiniteElement type: anItemType
]

{ #category : #accessing }
BlInfiniteRecyclerController >> dataSource [
	^ infiniteElement dataSource
]

{ #category : #'recycler -> data source' }
BlInfiniteRecyclerController >> dataSourceItemCount [
	^ self dataSource itemCount
]

{ #category : #accessing }
BlInfiniteRecyclerController >> dataSourceManager [
	^ infiniteElement dataSourceManager
]

{ #category : #'recycler -> element' }
BlInfiniteRecyclerController >> elementHolderOf: anElement [
	^ infiniteElement elementHolderOf: anElement
]

{ #category : #'recycler -> animator' }
BlInfiniteRecyclerController >> endAnimation: aChildHolder [
	^ self shouldBeImplemented
]

{ #category : #'recycler -> children' }
BlInfiniteRecyclerController >> findHiddenNonRemovedChildAt: aPosition type: anItemType [
	^ self childrenManager findHiddenNonRemovedChildAt: aPosition type: anItemType
]

{ #category : #'scrap fetcher -> recycler' }
BlInfiniteRecyclerController >> hasChangedScrap [
	^ self shouldBeImplemented
]

{ #category : #'recycler -> data source' }
BlInfiniteRecyclerController >> hasStableIds [
	^ self dataSource hasStableIds
]

{ #category : #accessing }
BlInfiniteRecyclerController >> infiniteElement [
	^ infiniteElement
]

{ #category : #accessing }
BlInfiniteRecyclerController >> infiniteElement: anInfiniteElement [

	infiniteElement := anInfiniteElement.
	infiniteElement recycler controller: self.
]

{ #category : #accessing }
BlInfiniteRecyclerController >> infoStore [
	^ infiniteElement infoStore
]

{ #category : #'recycler -> element' }
BlInfiniteRecyclerController >> isItemPrefetchEnabled [
	^ infiniteElement layout isItemPrefetchEnabled
]

{ #category : #'recycler -> state' }
BlInfiniteRecyclerController >> isPreLayout [
	^ self state isPreLayout
]

{ #category : #'recycler -> data source' }
BlInfiniteRecyclerController >> itemIdAt: aPosition [
	^ self dataSource itemIdAt: aPosition
]

{ #category : #'recycler -> element' }
BlInfiniteRecyclerController >> itemPrefetchCount [
	^ self shouldBeImplemented
]

{ #category : #'recycler -> data source' }
BlInfiniteRecyclerController >> itemTypeAt: aPosition [
	^ self dataSource itemTypeAt: aPosition
]

{ #category : #'recycler -> element' }
BlInfiniteRecyclerController >> lastPrefetchIncludedPosition: aPosition [
	^ self shouldBeImplemented
]

{ #category : #'recycler -> element' }
BlInfiniteRecyclerController >> onElementHolderRecycled: anElementHolder [

	self dataSource onElementRecycled: anElementHolder.
	self infoStore removeHolder: anElementHolder
]

{ #category : #'scrap fetcher -> recycler' }
BlInfiniteRecyclerController >> quickRecycleScrap: anElement [
	^ self shouldBeImplemented
]

{ #category : #'scrap fetcher -> recycler' }
BlInfiniteRecyclerController >> recycleCachedAt: anIndex [
	^ self shouldBeImplemented
]

{ #category : #'scrap fetcher -> recycler' }
BlInfiniteRecyclerController >> recycleElementHolder: anElementHolder [
	self flag: #todo
]

{ #category : #accessing }
BlInfiniteRecyclerController >> recycler [
	^ infiniteElement recycler
]

{ #category : #'scrap fetcher -> recycler' }
BlInfiniteRecyclerController >> recyclerPool [
	^ self recycler pool
]

{ #category : #'recycler -> element' }
BlInfiniteRecyclerController >> removeDetachedChild: anElement [
	^ self shouldBeImplemented
]

{ #category : #'recycler -> state' }
BlInfiniteRecyclerController >> removeHolderFromInfoStore: anElementHolder [
	self infoStore removeHolder: anElementHolder
]

{ #category : #accessing }
BlInfiniteRecyclerController >> state [
	^ infiniteElement state
]

{ #category : #'recycler -> state' }
BlInfiniteRecyclerController >> stateItemCount [
	^ self shouldBeImplemented
]

{ #category : #'scrap fetcher -> recycler' }
BlInfiniteRecyclerController >> userCache [
	^ self recycler userCache
]
