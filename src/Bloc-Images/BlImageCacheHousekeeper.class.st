"
BlImageCacheHousekeeper keeps track of the size of its BlLocalImageCache and prunes the oldest files from the cache when it grows too large.



!!Public API and Key Messages

There are only really three operations performed by the housekeeper:

- add: Add the size of the supplied ${class:name=FileReference}$ to the receiver.
- schedulePruneCache Initiate deleting files to get the cache size down to targetSize
- scheduleUpdateCurrentSize Initiate walking over the cache and adding up the total cache size.
!!Internal Representation and Key Implementation Points.

!!!Instance Variables
	cache:		<BlLocalImageCache>
	currentSize:		<Integer>
	emergencySize:		<Integer>
	entryCount:		<Integer>
	targetSize:		<Integer>


!!Implementation Points

To ensure that UI responsiveness is not impacted all long lasting operations (updating the cache size and pruning the cache) are performed in a low priority queue without any access mutexes.  This means that the currentSize may not be accurate and the cache may grow beyond the specified maximums.

Running the pruning operation in a low priority background process also means that in a (very) busy system it is possible that the pruning never catches up with files being added to the cache.  If the currentSize ever reaches the emergencySize the next file to be added will prune the cache in the calling process.
"
Class {
	#name : #BlImageCacheHousekeeper,
	#superclass : #Object,
	#instVars : [
		'cache',
		'currentSize',
		'entryCount',
		'emergencySize',
		'processing',
		'targetSize'
	],
	#category : #'Bloc-Images-Cache'
}

{ #category : #'instance creation' }
BlImageCacheHousekeeper class >> for: aBlImageCache [

	^self new initializeWith: aBlImageCache
]

{ #category : #accessing }
BlImageCacheHousekeeper >> add: aFileReference [
	"aFileReference has been added to the cache, update the internal size counter"

	currentSize := currentSize + aFileReference size.
	BlImageCacheSignal emitEvent: #addedFile value: aFileReference currentSize: currentSize.
	"If the cache has grown larger than the emergency size, prune immediately
	(on the assumption that the low priority process isn't getting a chance to run"
	currentSize >= emergencySize ifTrue:
		[ self pruneCache ]
	ifFalse: [ currentSize > self maxCacheSize ifTrue:
		[ self schedulePruneCache ] ]
]

{ #category : #accessing }
BlImageCacheHousekeeper >> cacheRoot [ 

	^cache cacheRoot
]

{ #category : #accessing }
BlImageCacheHousekeeper >> currentSize [

	^currentSize
]

{ #category : #accessing }
BlImageCacheHousekeeper >> emergencySize [
	"Answer the size in bytes at which the calling process will be used to prune the cache"

	^emergencySize 
]

{ #category : #initialization }
BlImageCacheHousekeeper >> initialize [ 

	super initialize.
	processing := false.
	currentSize := 0.
]

{ #category : #initialization }
BlImageCacheHousekeeper >> initializeWith: aBlImageCache [

	cache := aBlImageCache.
	targetSize := (cache maxCacheSize * 0.80) rounded.
	emergencySize := cache maxCacheSize * 2.

]

{ #category : #accessing }
BlImageCacheHousekeeper >> maxCacheSize [ 

	^cache maxCacheSize
]

{ #category : #private }
BlImageCacheHousekeeper >> pruneCache [
	"Walk over the receiver's cache and remove enough old items to reduce the cache size to targetSize"

	BlImageCacheSignal emitEvent: #pruneStarting value: nil currentSize: currentSize.
	(BlCachePruningVisitor on: self) delete.
	self updateCurrentSize.
	BlImageCacheSignal emitEvent: #pruneCompleted value: nil currentSize: currentSize.

]

{ #category : #private }
BlImageCacheHousekeeper >> schedulePruneCache [
	"Prune the receiver's cache in the housekeeping process"

	BlUseAsyncFeatures 
		ifEnabledDo: [ 
			BlTktWorkerProvider nonUISinglePool schedule: [ self pruneCache ] ]
		otherwise: [ 
			self pruneCache ]
]

{ #category : #private }
BlImageCacheHousekeeper >> scheduleUpdateCurrentSize [
	"Update the size of the receiver's cache in the housekeeping process"

	BlUseAsyncFeatures 
		ifEnabledDo: [ 
			cache taskitRunner schedule: [ self updateCurrentSize ] ]
		 otherwise: [ 
			self updateCurrentSize ]
]

{ #category : #private }
BlImageCacheHousekeeper >> targetSize [

	^targetSize
]

{ #category : #private }
BlImageCacheHousekeeper >> updateCurrentSize [
	"Update the current size of the receiver's cache"

	| usageVisitor |

	usageVisitor := BlDiskUsageVisitor on: cache cacheRoot.
	entryCount := usageVisitor entryCount.
	^currentSize := usageVisitor total.
]
