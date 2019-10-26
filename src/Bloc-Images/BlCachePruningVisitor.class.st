"
BlCachePruningVisitor is responsible for deleting enough files in the cache to get the size back down to the targetSize.

The basic approach is to keep a sorted collection by date of the files to be deleted, i.e. enough of the oldest files to reduce the cache by reductionSize.

Public API and Key Messages

- on: aBlImageCacheHousekeeper
- delete: actually remove the files chosen during the scan
 
!!Internal Representation and Key Implementation Points.

!!!Instance Variables
	count:							<Integer> The number of files visited - statistic only
	housekeeper:		<BlImageCacheHousekeeper>
	newestOldestTime:		<DateAndTime> The timestamp of the newest file in the oldest collection.  Files that are older than this will be added to the oldest collection.
	oldest:		<SortedCollection> The list of files to be deleted.
	oldestSize:		<Integer> The sum of the size of files in oldest
	reductionSize:		<Integer> The number of bytes to reduce the cache size by.
	targetSize:		<Integer>  The target size of the cache in bytes.


!!!Implementation Points
"
Class {
	#name : #BlCachePruningVisitor,
	#superclass : #FileSystemVisitor,
	#instVars : [
		'housekeeper',
		'oldest',
		'oldestSize',
		'targetSize',
		'reductionSize',
		'count',
		'newestOldestTime'
	],
	#category : #'Bloc-Images-Cache'
}

{ #category : #'instance creation' }
BlCachePruningVisitor class >> on: aBlImageCacheHousekeeper [

	^self new 
		on: aBlImageCacheHousekeeper;
		yourself
]

{ #category : #actions }
BlCachePruningVisitor >> delete [ 

	| entries |

	entries := oldest collect: [ :each | each reference parent ] as: Set.
	entries do: [ :each | each ensureDeleteAll ].
	BlImageCacheSignal emitEvent: #pruneDeleted value: entries size currentSize: housekeeper currentSize

]

{ #category : #initialization }
BlCachePruningVisitor >> initialize [ 

	super initialize.
	oldest := SortedCollection sortBlock: #modificationTime ascending.
	oldestSize := 0.
]

{ #category : #'instance creation' }
BlCachePruningVisitor >> on: aBlImageCacheHousekeeper [

	housekeeper := aBlImageCacheHousekeeper.
	reductionSize := housekeeper currentSize - housekeeper targetSize.
	count := 0.
	newestOldestTime := DateAndTime now.
	(PreorderGuide for: self) show: housekeeper cacheRoot.
	BlImageCacheSignal emitEvent: #pruneCount value: count currentSize: housekeeper currentSize

]

{ #category : #visiting }
BlCachePruningVisitor >> visitFile: anEntry [

	count := count + 1.
	(anEntry modificationTime < newestOldestTime or: [ oldestSize < reductionSize ]) ifTrue: [ 
		oldest add: anEntry.
		oldestSize := oldestSize + anEntry size ].
	[ oldestSize > reductionSize ] whileTrue: 
		[ oldestSize := oldestSize - (oldest removeLast size) ].
	oldest ifNotEmpty: 
		[ newestOldestTime := oldest last modificationTime ]
	
]
