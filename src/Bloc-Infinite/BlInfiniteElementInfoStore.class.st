"
I abstract all tracking for Elements to run animations
"
Class {
	#name : #BlInfiniteElementInfoStore,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'layoutHolderMap',
		'oldChangedHolders'
	],
	#category : 'Bloc-Infinite-Basic'
}

{ #category : #'adding/removing' }
BlInfiniteElementInfoStore >> addToAppearedInPreLayout: anElementHolder itemHolder: anItemHolder [
	"Adds the given ElementHolder to the appeared in pre layout list. These are Elements added by the
	InfiniteLayout during a pre-layout pass. We distinguish them from other elements that were
	already in the pre-layout so that ItemAnimator can choose to run a different animation for them"
	| aRecord |
	
	aRecord := layoutHolderMap
		at: anElementHolder
		ifAbsentPut: [ BlInfiniteElementInfoStoreRecord obtain ].
	
	aRecord flags addAppear.
	aRecord preInfo: anItemHolder
]

{ #category : #'adding/removing' }
BlInfiniteElementInfoStore >> addToDisappearedInLayout: anElementHolder [
	"An ElementHolder might be added by the InfiniteLayout just to animate its disappearance.
	This list holds such items so that we can animate / recycle these ElementHolders properly."
	| aRecord |

	aRecord := layoutHolderMap
		at: anElementHolder
		ifAbsentPut: [ BlInfiniteElementInfoStoreRecord obtain ].

	aRecord flags addDisappeared
]

{ #category : #'adding/removing' }
BlInfiniteElementInfoStore >> addToOldChangeHolders: anElementHolder at: aKey [
	"Adds the given ElementHolder to the oldChangeHolders list"

	oldChangedHolders at: aKey put: anElementHolder
]

{ #category : #'adding/removing' }
BlInfiniteElementInfoStore >> addToPostLayout: anElementHolder itemHolder: anItemHolder [
	"Adds the item information to the post layout tracking"
	| aRecord |

	aRecord := layoutHolderMap
		at: anElementHolder
		ifAbsentPut: [ BlInfiniteElementInfoStoreRecord obtain ].

	aRecord flags addPost.
	aRecord postInfo: anItemHolder
]

{ #category : #'adding/removing' }
BlInfiniteElementInfoStore >> addToPreLayout: anElementHolder itemHolder: anItemHolder [
	"Adds the item information to the pre layout tracking"
	| aRecord |
	
	aRecord := layoutHolderMap
		at: anElementHolder
		ifAbsentPut: [ BlInfiniteElementInfoStoreRecord obtain ].
	
	aRecord flags addPre.
	aRecord preInfo: anItemHolder
]

{ #category : #invalidation }
BlInfiniteElementInfoStore >> clear [
	"Clear the state and all existing tracking data"

	layoutHolderMap removeAll.
	oldChangedHolders removeAll
]

{ #category : #initialization }
BlInfiniteElementInfoStore >> initialize [
	super initialize.
	
	layoutHolderMap := IdentityDictionary new.
	oldChangedHolders := IdentityDictionary new
]

{ #category : #testing }
BlInfiniteElementInfoStore >> isDisappearing: anElementHolder [
	"Return true if the given ElementHolder is in disappearing list, false otherwise"
	<return: #Boolean>
	
	^ layoutHolderMap
		at: anElementHolder
		ifPresent: [ :aRecord | aRecord flags hasDisappeared ]
		ifAbsent: [ false ]
]

{ #category : #testing }
BlInfiniteElementInfoStore >> isInPreLayout: anElementHolder [
	"Return true if the given ElementHolder is in preLayout list, false otherwise"
	<return: #Boolean>
	
	^ layoutHolderMap
		at: anElementHolder
		ifPresent: [ :aRecord | aRecord flags hasPre ]
		ifAbsent: [ false ]
]

{ #category : #'instance creation' }
BlInfiniteElementInfoStore >> obtainRecord [
	
	<return: #BlInfiniteElementInfoStoreRecord>
	
	^ BlInfiniteElementInfoStoreRecord obtain
]

{ #category : #accessing }
BlInfiniteElementInfoStore >> oldChangedHolderAt: aKey [
	"Queries the oldChangeHolder list for the given key. If they are not tracked, simply returns nil"
	<return: #BlInfiniteHolder or: nil>

	^ oldChangedHolders at: aKey ifAbsent: [ nil ]
]

{ #category : #hooks }
BlInfiniteElementInfoStore >> onDetached [

	BlInfiniteElementInfoStoreRecord drainCache
]

{ #category : #hooks }
BlInfiniteElementInfoStore >> onHolderDetached: anElementHolder [

	self removeFromDisappearedInLayout: anElementHolder
]

{ #category : #private }
BlInfiniteElementInfoStore >> popFromLayoutStep: anElementHolder flag: aFlag [
	
	| aRecord |
	
	aRecord := layoutHolderMap
		at: anElementHolder
		ifAbsent: [ ^ nil ].
	
	self
		assert: [ aRecord isNotNil ]
		description: [ 'An info store record must not be nil!' ].
	
	^ (aRecord flags has: aFlag)
		ifTrue: [ 
			| anInfo |
			aRecord flags remove: aFlag.
			anInfo := (aFlag = BlInfiniteInfoStoreRecordFlags Pre)
				ifTrue: [ aRecord preInfo ]
				ifFalse: [ (aFlag = BlInfiniteInfoStoreRecordFlags Post)
					ifTrue: [ aRecord postInfo ]
					ifFalse: [ self error: 'Unknown flag: ', aFlag asString ] ].
			(aRecord flags hasPre or: [ aRecord flags hasPost ]) ifFalse: [ 
				layoutHolderMap removeKey: anElementHolder ifAbsent: [ ].
				BlInfiniteElementInfoStoreRecord recycle: aRecord ].
			anInfo ]
		ifFalse: [ nil ]
]

{ #category : #'adding/removing' }
BlInfiniteElementInfoStore >> popFromPostLayout: anElementHolder [
	"Finds the ItemHolderInfo for the given element holder in postLayout list and removes it"
	<return: #BlInfiniteItemInfoHolder or: nil>

	^ self
		popFromLayoutStep: anElementHolder
		flag: BlInfiniteInfoStoreRecordFlags Post
]

{ #category : #'adding/removing' }
BlInfiniteElementInfoStore >> popFromPreLayout: anElementHolder [
	"Finds the ItemHolderInfo for the given element holder in preLayout list and removes it"
	<return: #BlInfiniteItemInfoHolder or: nil>

	^ self
		popFromLayoutStep: anElementHolder
		flag: BlInfiniteInfoStoreRecordFlags Pre
]

{ #category : #processing }
BlInfiniteElementInfoStore >> processOn: aProcessor [
	"I am doing a hard work processing appearing/disappearing elements.
	
	Processor must have the following API:
		- unused: anElementHolder
		- processDisappeared: anElementHolder preInfo: aBlInfiniteItemInfoHolder postInfo: aBlInfiniteItemInfoHolder
		- processAppeared: anElementHolder preInfo: aBlInfiniteItemInfoHolder postInfo: aBlInfiniteItemInfoHolder
		- processPersistent: anElementHolder preInfo: aBlInfiniteItemInfoHolder postInfo: aBlInfiniteItemInfoHolder"

	layoutHolderMap associations do: [ :aKeyValuePair |
		| anElementHolder aRecord |
		anElementHolder := aKeyValuePair key.
		aRecord := aKeyValuePair value.
		"anElementHolder is guaranteed to be one of the keys, otherwise there is something
		really bad happening"
		layoutHolderMap removeKey: anElementHolder. 
		
		(aRecord flags hasAppear and: [ aRecord flags hasDisappeared ])
			"Appeared then disappeared. Not useful for animations."
			ifTrue: [ aProcessor unused: anElementHolder ]
			ifFalse: [ aRecord flags hasDisappeared
				ifTrue: [ aRecord preInfo isNil
					"similar to appear disappear but happened between different layout passes.
					this can happen when the layout manager is using auto-measure"
					ifTrue: [ aProcessor unused: anElementHolder ]
					ifFalse: [ aProcessor processDisappeared: anElementHolder preInfo: aRecord preInfo postInfo: aRecord postInfo ] ]
				ifFalse: [ (aRecord flags hasAppear and: [ aRecord flags hasPre and: [ aRecord flags hasPost ] ])
					"Appeared in the layout but not in the data source (e.g. entered the viewport)"
					ifTrue: [ aProcessor processAppeared: anElementHolder preInfo: aRecord preInfo postInfo: aRecord postInfo ]
					ifFalse: [ (aRecord flags hasPre and: [ aRecord flags hasPost ])
						"Persistent in both passes. Animate persistence"
						ifTrue: [ aProcessor processPersistent: anElementHolder preInfo: aRecord preInfo postInfo: aRecord postInfo ]
						ifFalse: [ aRecord flags hasPre
							"Was in pre-layout, never been added to post layout"
							ifTrue: [ aProcessor processDisappeared: anElementHolder preInfo: aRecord preInfo postInfo: nil ]
							ifFalse: [ aRecord flags hasPost
								"Was not in pre-layout, been added to post layout"
								ifTrue: [ aProcessor processAppeared: anElementHolder preInfo: aRecord preInfo postInfo: aRecord postInfo ]
								ifFalse: [ aRecord flags hasAppear
									"Scrap view. RecyclerView will handle removing/recycling this."
									ifFalse: [ self error: 'Record has invalid flag combination!' ] ] ] ] ] ] ].
		BlInfiniteElementInfoStoreRecord recycle: aRecord ]
]

{ #category : #'adding/removing' }
BlInfiniteElementInfoStore >> removeFromDisappearedInLayout: anElementHolder [
	"Removes an ElementHolder from disappearing list."

	layoutHolderMap
		at: anElementHolder
		ifPresent: [ :aRecord | aRecord clearDisappeared ]
]

{ #category : #'adding/removing' }
BlInfiniteElementInfoStore >> removeHolder: anElementHolder [
	"Removes the anElementHolder from all lists"
	
	oldChangedHolders removeKey: anElementHolder ifAbsent:  [  ].
	(layoutHolderMap removeKey: anElementHolder ifAbsent:  [ nil ])
		ifNotNil: [ :aRecord | BlInfiniteElementInfoStoreRecord recycle: aRecord ]
]
